'use client'

import React, { useRef, useEffect, useState } from 'react'
import { Search, Menu, Bell, User } from "lucide-react"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import * as THREE from 'three'
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls'
import { start } from 'repl'


const newsData = [
  { id: 1, title: "AI Breakthrough in Climate Modeling", lat: 48.8575, lon: 2.3514 },
  { id: 2, title: "Quantum Internet Achieves First Long-Distance Entanglement", lat: 52.3676, lon: 4.9041 },
  { id: 3, title: "Mars Colony Produces First Successful Crop", lat: -1.2921, lon: 36.8219 },
  { id: 4, title: "Fusion Reactor Reaches Net Energy Milestone", lat: 35.6762, lon: 139.6503 },
  { id: 5, title: "Brain-Computer Interface Restores Speech to Paralyzed Patient", lat: -33.8688, lon: 151.2093 },
]




export function HeaderAndHeroGlobeComponent() {
  const globeRef = useRef<HTMLDivElement | null>(null)
  const [selectedNews, setSelectedNews] = useState<{ id: number; title: string; lat: number; lon: number } | null>(null)


  useEffect(() => {
    if (!globeRef.current) return

    const scene = new THREE.Scene()
    const camera = new THREE.PerspectiveCamera(75, globeRef.current.clientWidth / globeRef.current.clientHeight, 0.1, 1000)
    const renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true })

    renderer.setSize(globeRef.current.clientWidth, globeRef.current.clientHeight)
    globeRef.current.appendChild(renderer.domElement)

    // Create globe
    const globe_geometry = new THREE.SphereGeometry(5, 64, 64)
    const globe_loader = new THREE.TextureLoader()
    const globe_Texture = globe_loader.load('https://miro.medium.com/v2/resize:fit:1400/0*F9GANogspBRfY3sR.jpg')
    //https://static.vecteezy.com/system/resources/previews/020/596/672/non_2x/black-and-white-world-map-background-free-vector.jpg
    //https://miro.medium.com/v2/resize:fit:1400/0*F9GANogspBRfY3sR.jpg

    // Custom shader material
    const globe_customMaterial = new THREE.ShaderMaterial({
      uniforms: {
        globeTexture: { value: globe_Texture },
        time: { value: 0 },
      },
      vertexShader: `
        varying vec2 vUv;
        varying vec3 vNormal;
        
        void main() {
          vUv = uv;
          vNormal = normalize(normalMatrix * normal);
          gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
        }
      `,
      fragmentShader: `
        uniform sampler2D globeTexture;
        uniform float time;
        varying vec2 vUv;
        varying vec3 vNormal;
        
        void main() {
          vec4 texColor = texture2D(globeTexture, vUv);
          float intensity = 1.05 - dot(vNormal, vec3(0.0, 0.0, 1.0));
          vec3 atmosphere = vec3(0.3, 0.6, 1.0) * pow(intensity, 1.5);
          
          vec3 finalColor = mix(texColor.rgb, atmosphere, 0.3);
          finalColor += vec3(0.1, 0.4, 0.8) * (sin(time * 2.0 + vUv.y * 10.0) * 0.5 + 0.5) * 0.15;
          
          gl_FragColor = vec4(finalColor, 1.0);
        }
      `,
    })

    const globe = new THREE.Mesh(globe_geometry, globe_customMaterial)
    scene.add(globe)


    //create atmosphere
    const atm_geometry = new THREE.SphereGeometry(5, 64, 64)

    // Custom shader material
    const atm_customMaterial = new THREE.ShaderMaterial({
      vertexShader: `
        varying vec3 vertexNormal;

        void main() {
          vertexNormal = normalize(normalMatrix * normal);
          gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
        }
      `,
      fragmentShader: `
        varying vec3 vertexNormal;
        void main() {

            float intensity = pow(0.95 - dot(vertexNormal, vec3(0, 0, 1.0)), 2.0);
            gl_FragColor = vec4(0.3, 0.6, 1.0, 1.0) * intensity;
        }
      `,
      blending: THREE.AdditiveBlending,
      side: THREE.BackSide

    })

    const atmosphere = new THREE.Mesh(atm_geometry, atm_customMaterial)
    atmosphere.scale.set(1.1, 1.1, 1.1, 1.1)
    scene.add(atmosphere)

    const starGeometry = new THREE.BufferGeometry()
    const starMaterial = new THREE.PointsMaterial({
      color: 0xffffff,
      size: 2.25, // Increase the size of the stars to make them more visible
      sizeAttenuation: true // Enanble size attenuation to keep the size consistent
    })

    const starVertices = new Float32Array(24000)

    for (let i = 0; i < 8000; i += 3) {
      const x = (Math.random() - 0.5) * 2000
      const y = (Math.random() - 0.5) * 2000
      const z = (Math.random() - 0.5) * 2000
      starVertices[i] = x
      starVertices[i + 1] = y
      starVertices[i + 2] = z
    }

    starGeometry.setAttribute('position', new THREE.BufferAttribute(starVertices, 3))
    const stars = new THREE.Points(starGeometry, starMaterial)
    scene.add(stars)

    // Add ambient light
    const ambientLight = new THREE.AmbientLight(0xffffff, 0.5)
    scene.add(ambientLight)

    // Add point light
    const pointLight = new THREE.PointLight(0x3366ff, 1.5)
    pointLight.position.set(5, 3, 5)
    scene.add(pointLight)

    // Add news markers
    const markerGeometry = new THREE.SphereGeometry(0.1, 16, 16)
    const markerMaterial = new THREE.MeshBasicMaterial({ color: 0xff3366 })

    newsData.forEach(news => {
      const marker = new THREE.Mesh(markerGeometry, markerMaterial)
      const phi = (90 - news.lat) * (Math.PI / 180)
      const theta = (news.lon + 180) * (Math.PI / 180)
      marker.position.x = -(5 * Math.sin(phi) * Math.cos(theta))
      marker.position.z = (5 * Math.sin(phi) * Math.sin(theta))
      marker.position.y = (5 * Math.cos(phi))
      globe.add(marker)
    })

    camera.position.z = 10

    const controls = new OrbitControls(camera, renderer.domElement)
    controls.enableDamping = true
    controls.dampingFactor = 0.25
    controls.enableZoom = false

    const raycaster = new THREE.Raycaster()
    const mouse = new THREE.Vector2()

    const onMouseMove = (event: MouseEvent) => {
      const rect = renderer.domElement.getBoundingClientRect()
      mouse.x = ((event.clientX - rect.left) / rect.width) * 2 - 1
      mouse.y = -((event.clientY - rect.top) / rect.height) * 2 + 1

      raycaster.setFromCamera(mouse, camera)
      const intersects = raycaster.intersectObjects(globe.children)

      if (intersects.length > 0) {
        const index = globe.children.indexOf(intersects[0].object)
        setSelectedNews(newsData[index])
      } else {
        setSelectedNews(null)
      }
    }

    globeRef.current.addEventListener('mousemove', onMouseMove)

    const clock = new THREE.Clock()

    const animate = () => {
      requestAnimationFrame(animate)
      controls.update()

      const elapsedTime = clock.getElapsedTime()
      globe_customMaterial.uniforms.time.value = elapsedTime

      globe.rotation.y += 0.002
      renderer.render(scene, camera)
    }
    animate()

    const handleResize = () => {
      if (globeRef.current) {
        camera.aspect = globeRef.current.clientWidth / globeRef.current.clientHeight
        camera.updateProjectionMatrix()
        renderer.setSize(globeRef.current.clientWidth, globeRef.current.clientHeight)
      }
    }

    window.addEventListener('resize', handleResize)

    return () => {
      window.removeEventListener('resize', handleResize)
      if (globeRef.current) {
        globeRef.current.removeEventListener('mousemove', onMouseMove)
        if (globeRef.current.contains(renderer.domElement)) {
          globeRef.current.removeChild(renderer.domElement)
        }
      }
      renderer.dispose()
      globe_geometry.dispose()
      globe_customMaterial.dispose()
      markerGeometry.dispose()
      markerMaterial.dispose()
    }
  }, [])

  return (
    <div className=" min-h-screen bg-transparent text-white">


      <section className="relative h-screen">
        
        <div ref={globeRef} className="w-full h-full" />
       
        {selectedNews && (
          <div className="absolute bottom-8 left-1/2 transform -translate-x-1/2 bg-gray-900 bg-opacity-80 p-4 rounded-lg shadow-lg">
            <h2 className="text-xl font-bold text-blue-400">{selectedNews.title}</h2>
            <Button className="mt-2 bg-blue-600 hover:bg-blue-700 text-white">Read More</Button>
          </div>
        )}
        
        <div className="absolute top-4 left-4 bg-gray-800/50 backdrop-blur-sm p-4 rounded-lg shadow-lg">

          <h1 className="text-4xl font-bold mb-2 bg-gradient-to-r from-blue-300 to-blue-700 text-transparent bg-clip-text">
            Today's Top Stories
          </h1>
          <p className="text-gray-300">Explore breaking news from around the world</p>
        </div>

        

      </section>

    </div>
  )
}