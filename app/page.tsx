'use client'

import { useCallback, useEffect, useRef, useState } from 'react'
import { Question, Article, HandleNotification } from '@/utils/types'

import NewsMain from '@/components/newsMain'
import Header from '@/components/header'
import NewsFavorites from '@/components/newsFavorites'
import Notification from '@/components/notification'

import { HeaderAndHeroGlobeComponent } from '@/components/header-and-hero-globe'

import { fetchQuestions, fetchFavorites, fetchNewsForTopic } from '../utils/api';
import { Button } from '@/components/ui/button'
import { Tabs, TabsList, TabsTrigger } from '@/components/ui/tabs'


export default function Page() {

  const [mounted, setMounted] = useState(false)

  const [newsData, setNewsData] = useState<Record<string, Article[]>>({});
  const [activeTab, setActiveTab] = useState("")
  const [questions, setQuestions] = useState<Question[]>([]);
  const [start, setStart] = useState(false)

  const [favorites, setFavorites] = useState<Article[]>([]);
  const [showFavorites, setShowFavorites] = useState(false)

  const [AddNotification, showAddNotification] = useState(false);
  const [DeleteNotification, showDeleteNotification] = useState(false);


  useEffect(() => {
    const fetchInitialData = async () => {
      const [questionsData, favoritesData] = await Promise.all([
        fetchQuestions(),
        fetchFavorites()
      ]);
      setQuestions(questionsData);
      setActiveTab(questionsData[0].topic);
      setFavorites(favoritesData);
      setMounted(true);
    };

    fetchInitialData();
  }, []);

  useEffect(() => {
    if (questions.length > 0) {
      const fetchNewsData = async (): Promise<void> => {
        const newData: Record<string, Article[]> = {};
        for (const question of questions) {
          if (!(question.topic in newsData)) {
            const topicData = await fetchNewsForTopic(question.topic);
            newData[question.topic] = topicData;
          }
        }
        setNewsData(prevData => ({ ...prevData, ...newData }));
      };

      fetchNewsData();
    }
  }, [questions]);

  // Simplified toggleFavorites function
  const toggleFavorites = () => {
    setShowFavorites(!showFavorites)
  }

  // GLOBE BACKGROUND
  const [isFixed, setIsFixed] = useState(false);
  const heroRef = useRef<HTMLDivElement>(null);


  const SCROLL_DIRECTIONS = {
    BOTH: 'both',
    TOP_ONLY: 'top-only',
    BOTTOM_ONLY: 'bottom-only'
  };

  function debounce(func, wait) {
    let timeout;
    return (...args) => {
      clearTimeout(timeout);
      timeout = setTimeout(() => func(...args), wait);
    };
  }

  const useMultipleScrollTriggers = (triggers) => {
    const [lastScroll, setLastScroll] = useState(0);
    const [triggeredPoints, setTriggeredPoints] = useState(new Set());

    const handleScroll = useCallback(
      debounce(() => {
        const currentScroll = window.innerHeight - window.scrollY;
        const isScrollingDown = currentScroll > lastScroll;
        const isScrollingUp = currentScroll < lastScroll;

        triggers.forEach(({ limitT,limitB, scrollTo, direction = SCROLL_DIRECTIONS.BOTH, smooth = true }) => {
          const shouldTrigger = (() => {
            switch (direction) {
              case SCROLL_DIRECTIONS.TOP_ONLY:
                console.log("TRIGGER",lastScroll, limitB)
                return (
                  isScrollingDown &&
                  limitB > currentScroll &&
                  currentScroll > limitT
                );

              case SCROLL_DIRECTIONS.BOTTOM_ONLY:
               
                return (
                  isScrollingUp &&
                  limitB > currentScroll  &&
                  currentScroll > limitT  
                );

              case SCROLL_DIRECTIONS.BOTH:
                return (
                  (isScrollingDown && currentScroll > limitT && lastScroll < limitT) ||
                  (isScrollingUp && currentScroll < limitT && lastScroll > limitT)
                );

              default:
                return false;
            }
          })();
          
          if (shouldTrigger && !triggeredPoints.has(limitT)) {

            window.scrollTo({
              top: scrollTo,
              behavior: smooth ? 'smooth' : 'auto'
            });
            setTriggeredPoints(prev => new Set([...prev, limitT]));
          }

          // Reset trigger when moving away from scrollTo position
          if (Math.abs(currentScroll - scrollTo) > 100) {
            setTriggeredPoints(prev => {
              const newSet = new Set(prev);
              newSet.delete(limitT);
              return newSet;
            });
          }
        });

        setLastScroll(currentScroll);
      }, 50),
      [lastScroll, triggers, triggeredPoints]
    );

    useEffect(() => {
      window.addEventListener('scroll', handleScroll);
      return () => window.removeEventListener('scroll', handleScroll);
    }, [handleScroll]);
  };

  const scrollTriggers = [
    { limitT: 0 ,limitB:200, scrollTo:window.innerHeight, direction: SCROLL_DIRECTIONS.TOP_ONLY },
    { limitT: 200 ,limitB: window.innerHeight, scrollTo:0, direction: SCROLL_DIRECTIONS.TOP_ONLY },
    { limitT: 0 ,limitB: window.innerHeight - 100, scrollTo:window.innerHeight , direction: SCROLL_DIRECTIONS.BOTTOM_ONLY },
    { limitT: window.innerHeight - 100 ,limitB: window.innerHeight , scrollTo:0 , direction: SCROLL_DIRECTIONS.BOTTOM_ONLY },

  ];

  useMultipleScrollTriggers(scrollTriggers);


  useEffect(() => {
    document.body.style.overflow = isFixed ? 'auto' : 'hidden';
  }, [isFixed])

  // Calculate dynamic styles based on scroll progress
  const getHeroStyles = (isFixed: boolean) => {
    const baseStyles = {
      transition: 'opacity 0.3s ease-in-out, transform 0.3s ease-in-out',
    };

    if (isFixed) {
      return baseStyles
    }

    return {
      ...baseStyles,
      opacity: 1,
      transform: 'scale(1)',
    };
  };

  if (!mounted) {
    return null
  }

  return (
    <div className="min-h-screen bg-black text-gray-100  overflow-hidden">
      {/* <div className="fixed inset-0 overflow-hidden">
        <div className="absolute inset-0 bg-[radial-gradient(circle_at_center,_var(--tw-gradient-stops))] from-purple-700 via-gray-900 to-gray-900 animate-fade-pulse"></div>
        <div className="absolute inset-0 bg-[radial-gradient(circle_at_center,_var(--tw-gradient-stops))] from-blue-700 via-transparent to-transparent animate-fade-pulse-delayed"></div>
      </div> */}

      <div
        className="z-100 w-screen h-screen transition-[height] duration-300 ease-in-out"
        style={{
          height: isFixed ? heroRef.current?.offsetHeight : 'auto',
        }}
      >
        
        {/* Initial position of HeaderAndHeroGlobeComponent */}
        {!isFixed && (
          <div
            ref={heroRef}
            className="relative w-screen h-screen z-50 transition-transform duration-300 ease-in-out"
            style={getHeroStyles(false)}
          >
            <div className="w-screen h-screen inset-0 z-50 pointer-events-none flex items-center justify-center">
              <div className="pointer-events-auto">
                <Button
                  variant="outline"
                  className="text-xl rounded-full border-2 p-5 font-bold bg-gray-800/50 text-gray-300 hover:scale-95 transition-all ease-in-out backdrop-blur-sm"
                  onClick={() => setIsFixed(true)}
                >
                  Welcome to NewsRoom
                </Button>
              </div>
            </div>

          </div>
        )}
      </div>

      {/* Fixed version that appears when scrolled */}

      <div
        className={`fixed inset-0 z-0 transition-opacity duration-300 ease-in-out`}
        style={{
          height: heroRef.current?.offsetHeight,
          pointerEvents: isFixed ? 'auto' : 'none',
          ...getHeroStyles(true)
        }}
      >
        <HeaderAndHeroGlobeComponent />
      </div>

      
    

      <div className={`transition-all duration-300 ease-in-out ${isFixed ? 'z-10' : ''}`}>
        <div className="container">
          {/* <Header toggleFavorites={toggleFavorites} showFavorites={showFavorites} /> */}

          {showFavorites ? (
            <NewsFavorites
              favorites={favorites}
              setFavorites={setFavorites}
              showFavorites={showFavorites}
              showDelete={showDeleteNotification}
              showAdd={showAddNotification}
            />
          ) : (

          <NewsMain
                newsData={newsData}
                setNewsData={setNewsData}
                questions={questions}
                activeTab={activeTab}
                setActiveTab={setActiveTab}

                favorites={favorites}
                setFavorites={setFavorites}
                showFavorites={showFavorites}
                showDelete={showDeleteNotification}
                showAdd={showAddNotification}
              />

          )}
        </div>
      </div>
      {AddNotification && <Notification message="Article added to favorites !" color="green" />}
      {DeleteNotification && <Notification message="Article removed from favorites !" color="red" />}
    </div >
  )
}
