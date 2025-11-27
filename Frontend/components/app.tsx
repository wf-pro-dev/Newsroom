'use client'

import { useCallback, useEffect, useRef, useState } from 'react'
import NewsMain from '@/components/newsMain'
import Notification from '@/components/core/notification'
import { HeroGlobe } from '@/components/heroglobe'
import { Button } from '@/components/ui/button'
import '@/styles/page.css'
import { useGlobalState } from '../src/contexts/GlobalStateContext'
import Auth from './auth'
import { motion } from 'framer-motion'


// Constants for scroll directions
const SCROLL_DIRECTIONS = {
  BOTH: 'both',
  TOP_ONLY: 'top-only',
  BOTTOM_ONLY: 'bottom-only'
}

// Custom hook for scroll triggers
const useScrollTriggers = () => {
  const [lastScroll, setLastScroll] = useState(0)
  const [triggeredPoints, setTriggeredPoints] = useState(new Set())
  const [windowHeight, setWindowHeight] = useState(0)

  // Initialize window height
  useEffect(() => {
    if (typeof window !== 'undefined') {
      setWindowHeight(window.innerHeight)
      const handleResize = () => setWindowHeight(window.innerHeight)
      window.addEventListener('resize', handleResize)
      return () => window.removeEventListener('resize', handleResize)
    }
  }, [])

  const handleScroll = useCallback(
    debounce(() => {
      if (!windowHeight) return

      const currentScroll = windowHeight - window.scrollY
      const isScrollingDown = currentScroll > lastScroll
      const isScrollingUp = currentScroll < lastScroll

      const triggers = [
        { limitT: 0, limitB: 200, scrollTo: windowHeight, direction: SCROLL_DIRECTIONS.TOP_ONLY, smooth: true },
        { limitT: 200, limitB: windowHeight, scrollTo: 0, direction: SCROLL_DIRECTIONS.TOP_ONLY, smooth: true },
        { limitT: 0, limitB: windowHeight - 200, scrollTo: windowHeight, direction: SCROLL_DIRECTIONS.BOTTOM_ONLY, smooth: true },
        { limitT: windowHeight - 200, limitB: windowHeight, scrollTo: 0, direction: SCROLL_DIRECTIONS.BOTTOM_ONLY, smooth: true }
      ]

      triggers.forEach(({ limitT, limitB, scrollTo, direction = SCROLL_DIRECTIONS.BOTH, smooth = true }) => {
        const shouldTrigger = (() => {
          switch (direction) {
            case SCROLL_DIRECTIONS.TOP_ONLY:
              return isScrollingDown && limitB > currentScroll && currentScroll > limitT
            case SCROLL_DIRECTIONS.BOTTOM_ONLY:
              return isScrollingUp && limitB > currentScroll && currentScroll > limitT
            case SCROLL_DIRECTIONS.BOTH:
              return (isScrollingDown && currentScroll > limitT && lastScroll < limitT) ||
                (isScrollingUp && currentScroll < limitT && lastScroll > limitT)
            default:
              return false
          }
        })()

        if (shouldTrigger && !triggeredPoints.has(limitT)) {
          window.scrollTo({ top: scrollTo, behavior: smooth ? 'smooth' : 'auto' })
          setTriggeredPoints(prev => new Set([...prev, limitT]))
        }

        if (Math.abs(currentScroll - scrollTo) > 100) {
          setTriggeredPoints(prev => {
            const newSet = new Set(prev)
            newSet.delete(limitT)
            return newSet
          })
        }
      })

      setLastScroll(currentScroll)
    }, 50),
    [lastScroll, triggeredPoints, windowHeight]
  )

  useEffect(() => {
    if (typeof window !== 'undefined' && windowHeight) {
      window.addEventListener('scroll', handleScroll)
      return () => window.removeEventListener('scroll', handleScroll)
    }
  }, [handleScroll, windowHeight])
}

// Main App Component
export default function App() {
  const [mounted, setMounted] = useState(false)
  const [activeTab, setActiveTab] = useState("")
  const [showFavorites, setShowFavorites] = useState(false)
  const [AddNotification, showAddNotification] = useState(false)
  const [DeleteNotification, showDeleteNotification] = useState(false)
  const [isFixed, setIsFixed] = useState(false)
  const heroRef = useRef<HTMLDivElement>(null)



  const { topics, user } = useGlobalState();

  useEffect(() => {
    if (topics.length > 0) {
      setMounted(true)
      setActiveTab(topics[0].title)
    }

  }, [topics])

  // Initialize scroll triggers
  useScrollTriggers()


  useEffect(() => {
    if (typeof document !== 'undefined') {
      document.body.style.overflow = 'auto'
    }
  }, [])


  useEffect(() => {


    if (user == null) setIsFixed(false)

    if (typeof document !== 'undefined') {
      document.body.style.overflow = user ? 'auto' : 'hidden'
    }

  }, [user])

  // DupeHero Component
  const DupeHero = useCallback(
    ({ heroRef }: { heroRef: React.Ref<HTMLDivElement> }) => (
      <div
        ref={heroRef}
        className={`dupe-section transition-all duration-300 ease-in-out relative overflow-hidden`}
      >



        <div className="dupe-content relative z-10">
          {user && (
            <div className="pointer-events-auto w-screen flex flex-row justify-center min-h-screen">
              <div className='flex flex-col self-center items-center p-10 space-y-20 max-w-7xl'>

                {/* Main Title Card with enhanced effects */}
                <motion.div
                  className='relative group space-y-6 w-fit p-10 bg-gray-800/20 backdrop-blur-2xl border border-blue-500/30 rounded-2xl shadow-2xl shadow-blue-500/20'
                  initial={{ opacity: 0, y: 50, scale: 0.9 }}
                  animate={{ opacity: 1, y: 0, scale: 1 }}
                  transition={{ duration: 1.2, ease: "easeOut" }}
                  whileHover={{ scale: 1.03, y: -5 }}
                >

                  {/* Animated border glow */}
                  <div className="absolute inset-0 rounded-2xl bg-gradient-to-r from-blue-400/0 via-blue-400/50 to-blue-400/0 opacity-0 group-hover:opacity-100 transition-opacity duration-500" style={{
                    background: 'linear-gradient(45deg, transparent, rgba(59, 130, 246, 0.3), transparent)',
                    backgroundSize: '200% 200%',
                    animation: 'gradientSlide 3s ease-in-out infinite'
                  }} />

                  <div className="relative z-10 space-y-6 text-center">
                    <motion.h1
                      className='text-4xl font-bold bg-gradient-to-r from-blue-300 via-blue-400 to-cyan-300 bg-clip-text text-transparent leading-tight'
                      initial={{ opacity: 0, y: 20 }}
                      animate={{ opacity: 1, y: 0 }}
                      transition={{ duration: 1, delay: 0.3 }}
                    >
                      The Newsroom
                    </motion.h1>

                    <motion.div
                      className='h-1 w-32 mx-auto bg-gradient-to-r from-blue-400/40 via-cyan-400/80 to-blue-400/40 rounded-full shadow-lg shadow-blue-500/40'
                      initial={{ width: 0 }}
                      animate={{ width: 128 }}
                      transition={{ duration: 1, delay: 0.6 }}
                    />

                    <motion.p
                      className='text-xl font-medium text-gray-200 leading-relaxed'
                      initial={{ opacity: 0 }}
                      animate={{ opacity: 1 }}
                      transition={{ duration: 1, delay: 0.8 }}
                    >
                      Your Gateway to Global Intelligence
                    </motion.p>
                  </div>
                </motion.div>

                {/* Enhanced Feature Cards Grid */}
                <div className='grid grid-cols-1 md:grid-cols-3 gap-6 w-full max-w-4xl'>
                  {[
                    {
                      title: "Discover",
                      description: "Curated insights from trusted sources worldwide, delivered with precision and clarity.",
                      icon: "🌍",
                      gradient: "from-blue-400/20 to-cyan-400/20"
                    },
                    {
                      title: "Transform",
                      description: "Complex information transformed into clear, actionable knowledge for informed decisions.",
                      icon: "⚡",
                      gradient: "from-cyan-400/20 to-blue-400/20"
                    },
                    {
                      title: "Join",
                      description: "Connect with a community of decision-makers who are shaping tomorrow's world.",
                      icon: "🚀",
                      gradient: "from-blue-400/20 to-purple-400/20"
                    }
                  ].map((feature, index) => (
                    <motion.div
                      key={feature.title}
                      className='relative group flex flex-col items-center p-6 space-y-3 bg-gray-800/20 backdrop-blur-2xl border border-gray-600/30 rounded-2xl shadow-xl hover:shadow-blue-500/30 h-full'
                      initial={{ opacity: 0, y: 50 }}
                      animate={{ opacity: 1, y: 0 }}
                      transition={{ duration: 0.4, delay: 0.4 + index * 0.2 }}
                      whileHover={{
                        scale: 1.05,
                        y: -10,
                        borderColor: 'rgba(59, 130, 246, 0.5)',
                        backgroundColor: 'rgba(31, 41, 55, 0.3)',
                        transition: { duration: 0.2, delay: 0, ease: "easeInOut" }

                      }}
                    >
                      {/* Enhanced holographic effects */}
                      <div className={`absolute inset-0 bg-gradient-to-br ${feature.gradient} rounded-2xl opacity-0 group-hover:opacity-100 transition-opacity duration-500 blur-sm`} />
                      <div className="absolute inset-0 bg-gradient-to-t from-blue-500/10 via-transparent to-transparent rounded-2xl" />

                      <div className="relative z-10 text-center space-y-3 flex-1 flex flex-col justify-center">
                        <motion.div
                          className="text-3xl mb-1"
                          whileHover={{ scale: 1.2, rotate: 5 }}
                          transition={{ duration: 0.3 }}
                        >
                          {feature.icon}
                        </motion.div>

                        <h3 className='text-xl font-bold bg-gradient-to-r from-blue-200 to-cyan-200 bg-clip-text text-transparent'>
                          {feature.title}
                        </h3>

                        <p className='text-sm text-gray-300 leading-relaxed text-center'>
                          {feature.description}
                        </p>
                      </div>
                    </motion.div>
                  ))}
                </div>

                {/* Enhanced Welcome Button */}
                <motion.div
                  initial={{ opacity: 0, y: 30 }}
                  animate={{ opacity: 1, y: 0 }}
                  transition={{ duration: 1, delay: 1.2 }}
                  whileHover={{ scale: 1.05 }}
                  whileTap={{ scale: 0.98 }}
                  className="relative"
                >
                  {/* Button glow effect */}
                  <div className="absolute inset-0 bg-gradient-to-r from-blue-500/30 via-cyan-400/30 to-blue-500/30 rounded-2xl blur-lg opacity-0 group-hover:opacity-100 transition-opacity duration-500" />

                  <div className="relative group/button flex flex-col items-center -space-y-1">
                    <motion.p
                      className="text-sm text-gray-300 font-medium z-10 group/button-hover:text-white transition-colors duration-300"
                      initial={{ opacity: 0.7 }}
                      whileHover={{ opacity: 1 }}
                    >
                      Welcome back,
                    </motion.p>
                    <Button
                      className="min-w-64 relative px-12 py-6 bg-gray-800/20 backdrop-blur-2xl border-2 border-blue-500/40 text-white transition-all duration-500 hover:shadow-2xl hover:shadow-blue-500/40 rounded-2xl text-lg hover:border-cyan-400/60 overflow-hidden"
                      onClick={() => window.scrollTo({ top: window.innerHeight, behavior: 'smooth' })}
                    >
                      {/* Sliding background effect */}
                      <div className="absolute inset-0 bg-gradient-to-r from-blue-500/15 via-cyan-400/15 to-blue-500/15 transform -translate-x-full group-hover/button:translate-x-0 transition-transform duration-700 ease-out" />

                      <div className="relative z-10 flex flex-col items-center space-y-2">


                        <motion.p
                          className="font-bold text-2xl bg-gradient-to-r from-blue-200 via-cyan-200 to-blue-200 bg-clip-text text-transparent"
                          whileHover={{ scale: 1.05 }}
                        >
                          {user.username}
                        </motion.p>

                      </div>
                    </Button>

                    <motion.p
                      className="text-xs text-gray-400 font-medium z-10 group/button-hover:text-white transition-colors duration-300"
                      initial={{ opacity: 0 }}
                      animate={{ opacity: 1 }}
                      transition={{ delay: 1.5 }}
                    >
                      Continue to your personalized feed
                    </motion.p>

                   
                  </div>
                </motion.div>

              </div>
            </div>
          )}
        </div>
      </div>
    ), [user])


  if (!mounted) {
    return null
  }

  return (
    <div className="app-page">
      <div className="dupe-main relative"
        style={{ height: isFixed ? heroRef.current?.offsetHeight : 'auto' }}>
        <DupeHero heroRef={heroRef} />
      </div>

      <div className="header-hero relative"
        style={{
          height: heroRef.current?.offsetHeight,
          pointerEvents: isFixed ? 'auto' : 'none',
        }}
      >
        <HeroGlobe />
      </div>

      <div className="fixed top-0 left-0 w-screen h-3/4  bg-gradient-to-b from-blue-900/60 via-gray-700/40  to-black/40" />

      <Auth />

      <div className={`news-main relative`}>

        <NewsMain
          activeTab={activeTab}
          setActiveTab={setActiveTab}
          showFavorites={showFavorites}
          setShowFavorites={setShowFavorites}
          showDelete={showDeleteNotification}
          showAdd={showAddNotification}
        />
      </div>

      <Notification
        message="Article added to favorites!"
        color="green"
        show={AddNotification}
        setShow={showAddNotification}
      />

      <Notification
        message="Article removed from favorites!"
        color="red"
        show={DeleteNotification}
        setShow={showDeleteNotification}
      />
    </div>
  )
}

// Debounce function
function debounce(func: () => void, wait: number) {
  let timeout: NodeJS.Timeout
  return () => {
    clearTimeout(timeout)
    timeout = setTimeout(() => func(), wait)
  }
}
