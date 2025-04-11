'use client'

import React, { useRef, useEffect, useState } from 'react'
import { LogIn,  User2 } from 'lucide-react'
import { Button } from '@/components/ui/button'
import * as THREE from 'three'
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls.js';
import { OBJLoader } from 'three/examples/jsm/loaders/OBJLoader.js';
import { MTLLoader } from 'three/examples/jsm/loaders/MTLLoader.js';
import '@/styles/heroglobe.css'


const newsData = [
  { id: 1, title: "AI Breakthrough in Climate Modeling", lat: 48.8575, lon: 2.3514 },
  { id: 2, title: "Quantum Internet Achieves First Long-Distance Entanglement", lat: 52.3676, lon: 4.9041 },
  { id: 3, title: "Mars Colony Produces First Successful Crop", lat: -1.2921, lon: 36.8219 },
  { id: 4, title: "Fusion Reactor Reaches Net Energy Milestone", lat: 35.6762, lon: 139.6503 },
  { id: 5, title: "Brain-Computer Interface Restores Speech to Paralyzed Patient", lat: -33.8688, lon: 151.2093 },
]




export function HeroGlobe() {
  const globeRef = useRef<HTMLDivElement | null>(null)
  const [selectedNews, setSelectedNews] = useState<{ id: number; title: string; lat: number; lon: number } | null>(null)
  const [isHoveringMarker, setIsHoveringMarker] = useState(false);  


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
    const globe_Texture = globe_loader.load('/textures/enhanced_world_map.jpg')
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
    atmosphere.scale.set(1.1, 1.1, 1.1)
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

    const createGlowMaterial = () => {
      return new THREE.ShaderMaterial({
        uniforms: {
          glowColor: { type: "c", value: new THREE.Color(0xff3366) },
          viewVector: { type: "v3", value: camera.position }
        },
        vertexShader: `
          uniform vec3 viewVector;
          varying float intensity;
          void main() {
            gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
            vec3 actual_normal = normalize(normalMatrix * normal);
            intensity = pow(0.7 - dot(actual_normal, normalize(viewVector)), 2.0);
          }
        `,
        fragmentShader: `
          uniform vec3 glowColor;
          varying float intensity;
          void main() {
            vec3 glow = glowColor * intensity;
            gl_FragColor = vec4(glow, intensity * 0.5);
          }
        `,
        side: THREE.BackSide,
        blending: THREE.AdditiveBlending,
        transparent: true
      });
    };
    

    

    const mtlLoader = new MTLLoader();
    mtlLoader.setPath('/models/');
    mtlLoader.load('marker.mtl', (materials) => {
      materials.preload();

      const objLoader = new OBJLoader();
      objLoader.setMaterials(materials);
      objLoader.load("/models/marker.obj", (obj) => {
 
  
      const box = new THREE.Box3().setFromObject(obj);
      const center = new THREE.Vector3();
      box.getCenter(center);
      const size = new THREE.Vector3();
      box.getSize(size);
          
      newsData.forEach(({ lat, lon }) => {
          const marker = obj.clone(); // Clone the marker for each point
  
          const phi = (90 - lat) * (Math.PI / 180);
          const theta = (lon + 180) * (Math.PI / 180);
  
          // Calculate the position on the globe surface
          const x = -(5 * Math.sin(phi) * Math.cos(theta));
          const z = (5 * Math.sin(phi) * Math.sin(theta));
          const y = (5 * Math.cos(phi));
          
          // Create a normalized vector from the center of the globe to the marker position
          const fromCenter = new THREE.Vector3(x, y, z).normalize();

          // Add an offset (0.3 units in this example) to move the marker away from the surface
          const offset = 0.3;
          const markerX = x + fromCenter.x * offset;
          const markerY = y + fromCenter.y * offset;
          const markerZ = z + fromCenter.z * offset;


          // Add point light
          const pointLight = new THREE.PointLight(0xff3366, 0.5, 2);
          pointLight.position.set(markerX, markerY, markerZ);
          globe.add(pointLight);
          
          // Add glow effect
          const glowMaterial = createGlowMaterial();
          const glowGeometry = new THREE.SphereGeometry(0.25, 32, 32);
          const glow = new THREE.Mesh(glowGeometry, glowMaterial);
          glow.position.set(markerX, markerY, markerZ);
          globe.add(glow);
          
          // Set the marker position with offset
          marker.position.set(markerX, markerY, markerZ);
                  
          // Create a quaternion that rotates from the default up vector (0,1,0) to our desired direction
          const quaternion = new THREE.Quaternion().setFromUnitVectors(
            new THREE.Vector3(0, 1, 0), // Default up vector
            fromCenter                  // Direction we want the bottom to point (toward globe center)
          );
          
          // Apply the rotation
          marker.quaternion.copy(quaternion);
          marker.rotateY(Math.PI / 2);

          marker.scale.set(0.25, 0.25, 0.25); // Scale if needed
          marker.userData.isMarker = true
          globe.add(marker);
      });
    });
  });
    camera.position.z = 11
    
    /* Controls Paremeters */
    const controls = new OrbitControls(camera, renderer.domElement)
    controls.enableDamping = true
    controls.dampingFactor = 0.25
    controls.enableZoom = false
    controls.enablePan = false
    controls.autoRotate = true
    controls.autoRotateSpeed = 1.5

    const raycaster = new THREE.Raycaster()
    const mouse = new THREE.Vector2()

   // Replace your existing onMouseMove function with this:
const onMouseMove = (event: MouseEvent) => {
  if (!globeRef.current) return;

  const rect = renderer.domElement.getBoundingClientRect();
  mouse.x = ((event.clientX - rect.left) / rect.width) * 2 - 1;
  mouse.y = -((event.clientY - rect.top) / rect.height) * 2 + 1;

  raycaster.setFromCamera(mouse, camera);
  
  // Check all objects recursively
  const intersects = raycaster.intersectObjects(globe.children, true);

  if (intersects.length > 0) {
    // Find if we hit a marker by checking parent groups
    let hitMarker = false;
    let intersectedObject = intersects[0].object;

    
    
    // Traverse up the parent chain to find if this is part of a marker
    while (intersectedObject.parent !== null) {
    
      if (intersectedObject.userData.isMarker || 
          (intersectedObject.parent && intersectedObject.parent.userData.isMarker)) {
        hitMarker = true;
        break;
      }
      intersectedObject = intersectedObject.parent;
    }

    if (hitMarker) {
      setIsHoveringMarker(true);
      controls.autoRotate = false;
    } 
  } else {
    setIsHoveringMarker(false);
    controls.autoRotate = true;

  }
};

  // Add mouse leave handler
  const onMouseLeave = () => {
    setIsHoveringMarker(false);
    if (controls) {
      controls.autoRotate = true;
    }
    setSelectedNews(null);
  };

 
  globeRef.current.addEventListener('mousemove', onMouseMove);
  globeRef.current.addEventListener('mouseleave', onMouseLeave);


    const clock = new THREE.Clock()

    const animate = () => {
      requestAnimationFrame(animate);
      
      const elapsedTime = clock.getElapsedTime();
      globe_customMaterial.uniforms.time.value = elapsedTime;
      
      // Update controls only if not hovering
      if (!isHoveringMarker) {
        controls.autoRotate = true;
      }
      
      controls.update();
      renderer.render(scene, camera);
    };
    animate();

    return () => {
      if (globeRef.current) {
        globeRef.current.removeEventListener('mousemove', onMouseMove)
        globeRef.current.removeEventListener('mouseleave', onMouseLeave);        
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
    <div className="hero-globe-container">
      <section className="hero-section">
        <div ref={globeRef} className="globe" />

        {selectedNews && (
          <div className="news-popup">
            <h2 className="news-title">{selectedNews.title}</h2>
            <Button className="read-more-button">Read More</Button>
          </div>
        )}

       
        
      </section>
     
    </div>
  )
}
