'use client'

import { Dispatch, SetStateAction, useCallback, useEffect, useRef, useState } from 'react'
import NewsMain from '@/components/newsMain'
import Notification from '@/components/core/notification'
import { HeroGlobe } from '@/components/heroglobe'
import { Button } from '@/components/ui/button'
import '@/styles/page.css'
import { useGlobalState } from './context/GlobalStateContext'
import Auth from './auth'


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



  const { topics, user, articles } = useGlobalState();

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
      document.body.style.overflow = isFixed ? 'auto' : 'hidden'
    }
  }, [isFixed])

  const getHeroStyles = (isFixed: boolean) => ({
    transition: '',
    ...(isFixed ? {} : { opacity: 1 })
  })

  useEffect(() => {


    if (user == null) setIsFixed(false)

  }, [user])

  // DupeHero Component
  const DupeHero = useCallback(
    ({ isFixed, heroRef, setIsFixed }: { isFixed: boolean, heroRef: React.Ref<HTMLDivElement>, setIsFixed: Dispatch<SetStateAction<boolean>> }) => (
      <div
        ref={heroRef}
        className={`dupe-section ${isFixed ? 'opacity-0' : 'opacity-100'} 0.3s ease-in-out, transform 0.3s ease-in-out`}
        style={getHeroStyles(isFixed)}
      >
        <div className="dupe-content ">

          {user && (
            <div className="pointer-events-auto w-screen flex flex-row justify-center" >

              <div className='flex flex-col self-center items-center  p-10 space-y-16 '>

                <div className='space-y-2 w-fit p-8 bg-black/60 rounded-lg feature-card'>
                  <h1 className='text-center text-4xl font-bold bg-gradient-to-r from-blue-600 to-purple-600 bg-clip-text text-transparent'>The Newsroom</h1>
                  <div className='h-0.5 w-16 bg-gradient-to-r from-blue-600 to-purple-600 rounded-full'></div>
                  <p className='text-lg font-medium text-white'>Your Gateway to Global Intelligence</p>
                </div>

                <div className='flex flex-row items-center space-x-16 '>

                  <div className='flex flex-col items-center max-w-[250px] p-4 space-y-2 bg-black/60 rounded-lg feature-card'>
                    <p className='text-base text-white font-medium' >Discover</p>
                    <p className='text-base text-gray-500 text-center'>
                      curated insights from trusted sources worldwide.
                    </p>
                  </div>

                  <div className='flex flex-col items-center max-w-[250px] p-4 space-y-2 bg-black/60 rounded-lg feature-card'>
                    <p className='text-base text-white font-medium' >Transform</p>
                    <p className='text-base text-gray-500 text-center'>
                      complex information into clear, actionable knowledge.
                    </p>
                  </div>

                  <div className='flex flex-col items-center max-w-[250px] p-4 space-y-2 bg-black/60 rounded-lg feature-card'>
                    <p className='text-base text-white font-medium' >Join</p>
                    <p className='text-base text-gray-500 text-center'>
                      a community of decision-makers shaping tomorrow.
                    </p>
                  </div>

                </div>

                <div>
                  <Button
                    variant="outline"
                    className="dupe-button"
                    onClick={() => setIsFixed(true)}
                  >

                    <p className="text-sm text-gray-600">Welcome,</p>
                    <p className="font-bold">{user.username}</p>

                  </Button>
                </div>

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
      <div className="dupe-main relative before:absolute before:inset-0 before:border-2 before:border-transparent before:rounded-lg before:animate-border-flow"
        style={{ height: isFixed ? heroRef.current?.offsetHeight : 'auto' }}>
        <DupeHero isFixed={isFixed} heroRef={heroRef} setIsFixed={setIsFixed} />
      </div>

      <div className="header-hero relative before:absolute before:inset-0 before:border-2 before:border-transparent before:rounded-lg before:animate-border-flow"
        style={{
          height: heroRef.current?.offsetHeight,
          pointerEvents: isFixed ? 'auto' : 'none',
          ...getHeroStyles(true)
        }}
      >
        <HeroGlobe />
      </div>

      <Auth />

      <div className={`news-main relative before:absolute before:inset-0 before:border-2 before:border-transparent before:rounded-lg before:animate-border-flow ${isFixed ? 'z-10' : ''}`}>
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
