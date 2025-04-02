'use client'

import { Dispatch, SetStateAction, useCallback, useEffect, useRef, useState } from 'react'
import NewsMain from '@/components/newsMain'
import Notification from '@/components/core/notification'
import { HeroGlobe } from '@/components/heroglobe'
import { Button } from '@/components/ui/button'
import '@/styles/page.css'
import { useGlobalState } from './context/GlobalStateContext'

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
    () => debounce(() => {
      if (!windowHeight) return

      const currentScroll = windowHeight - window.scrollY
      const isScrollingDown = currentScroll > lastScroll
      const isScrollingUp = currentScroll < lastScroll

      const triggers = [
        { limitT: 0, limitB: 200, scrollTo: windowHeight, direction: SCROLL_DIRECTIONS.TOP_ONLY, smooth : true },
        { limitT: 200, limitB: windowHeight, scrollTo: 0, direction: SCROLL_DIRECTIONS.TOP_ONLY, smooth : true },
        { limitT: 0, limitB: windowHeight - 200, scrollTo: windowHeight, direction: SCROLL_DIRECTIONS.BOTTOM_ONLY, smooth : true },
        { limitT: windowHeight - 200, limitB: windowHeight, scrollTo: 0, direction: SCROLL_DIRECTIONS.BOTTOM_ONLY, smooth : true }
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

  const { topics } = useGlobalState();

  useEffect(() => {
    if (topics.length > 0) {
      setMounted(true)
      console.log("topics", topics)
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
    transition: 'opacity 0.3s ease-in-out, transform 0.3s ease-in-out',
    ...(isFixed ? {} : { opacity: 1, transform: 'scale(1)' })
  })

  // DupeHero Component
  const DupeHero = ({ isFixed, heroRef, setIsFixed }:{isFixed:boolean,heroRef:React.Ref<HTMLDivElement>,setIsFixed:Dispatch<SetStateAction<boolean>> }) => (
    <div
      ref={heroRef}
      className="dupe-section"
      style={getHeroStyles(isFixed)}
    >
      <div className="dupe-content">
        <div className="pointer-events-auto">
          <Button
            variant="outline"
            className="dupe-button"
            onClick={() => setIsFixed(true)}
          >
            <p>Welcome to the</p>
            <p className='font-bold'>NewsRoom</p>
          </Button>
        </div>
      </div>
    </div>
  )


  if (!mounted) {
    return null
  }

  return (
    <div className="app-page">

      <div className="dupe-main"
        style={{ height: isFixed ? heroRef.current?.offsetHeight : 'auto' }}>
        {!isFixed && <DupeHero isFixed={isFixed} heroRef={heroRef} setIsFixed={setIsFixed} />}
      </div>

      <div className="header-hero"
        style={{
          height: heroRef.current?.offsetHeight,
          pointerEvents: isFixed ? 'auto' : 'none',
          ...getHeroStyles(true)
        }}
      >
        <HeroGlobe />
      </div>

      <div className={`news-main ${isFixed ? 'z-10' : ''}`}>
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
function debounce(func:()=>void, wait:number) {
  let timeout:NodeJS.Timeout
  return () => {
    clearTimeout(timeout)
    timeout = setTimeout(() => func(), wait)
  }
}
