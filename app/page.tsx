'use client'

import { useCallback, useEffect, useRef, useState } from 'react'
import { Topic, Question, Article, Video } from '@/utils/types'

import NewsMain from '@/components/newsMain'
import Notification from '@/components/notification'

import { HeaderAndHeroGlobeComponent } from '@/components/header-and-hero-globe'

import { fetchTopics, fetchQuestions, fetchFavorites, fetchArticles, fetchVideos } from '../utils/api';
import { Button } from '@/components/ui/button'
import '@/styles/page.css';

// Constants for scroll directions
const SCROLL_DIRECTIONS = {
  BOTH: 'both',
  TOP_ONLY: 'top-only',
  BOTTOM_ONLY: 'bottom-only'
};

// AppPage Component
const AppPage = ({ title, children, className }) => {
  useEffect(() => {
    if (title) document.title = title;
  }, [title]);
  return <div className={className}>{children}</div>;
};



// ScrollTriggers Component
const useScrollTriggers = (triggers) => {
  const [lastScroll, setLastScroll] = useState(0);
  const [triggeredPoints, setTriggeredPoints] = useState(new Set());

  const handleScroll = useCallback(
    debounce(() => {
      const currentScroll = window.innerHeight - window.scrollY;
      const isScrollingDown = currentScroll > lastScroll;
      const isScrollingUp = currentScroll < lastScroll;

      triggers.forEach(({ limitT, limitB, scrollTo, direction = SCROLL_DIRECTIONS.BOTH, smooth = true }) => {
        const shouldTrigger = (() => {
          switch (direction) {
            case SCROLL_DIRECTIONS.TOP_ONLY:
              return isScrollingDown && limitB > currentScroll && currentScroll > limitT;
            case SCROLL_DIRECTIONS.BOTTOM_ONLY:
              return isScrollingUp && limitB > currentScroll && currentScroll > limitT;
            case SCROLL_DIRECTIONS.BOTH:
              return (isScrollingDown && currentScroll > limitT && lastScroll < limitT) ||
                     (isScrollingUp && currentScroll < limitT && lastScroll > limitT);
            default:
              return false;
          }
        })();

        if (shouldTrigger && !triggeredPoints.has(limitT)) {
          window.scrollTo({ top: scrollTo, behavior: smooth ? 'smooth' : 'auto' });
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

// Main Page Component
export default function Page() {
  const [mounted, setMounted] = useState(false);
  const [newsData, setNewsData] = useState<Record<string, Article[]>>({});
  const [activeTab, setActiveTab] = useState("");
  const [topics, setTopics] = useState<Topic[]>([]);
  const [questions, setQuestions] = useState<Question[]>([]);
  const [articles, setArticles] = useState<Article[]>([]);
  const [videos, setVideos] = useState<Video[]>([]);
  const [favorites, setFavorites] = useState<Article[]>([]);
  const [showFavorites, setShowFavorites] = useState(false);
  const [AddNotification, showAddNotification] = useState(false);
  const [DeleteNotification, showDeleteNotification] = useState(false);
  const [isFixed, setIsFixed] = useState(false);
  const heroRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const fetchInitialData = async () => {
      const [topicsData, questionsData, favoritesData, articlesData, videosData] = await Promise.all([
        fetchTopics(),
        fetchQuestions(),
        fetchFavorites(),
        fetchArticles(),
        fetchVideos(),
      ]);
      setTopics(topicsData);
      setActiveTab(topicsData[0].title_top);
      setQuestions(questionsData);
      setFavorites(favoritesData);
      setArticles(articlesData);
      setVideos(videosData);
      setMounted(true);
    };

    fetchInitialData();
  }, []);

  useEffect(() => {
    const data: Record<string, Article[]> = {};
    topics.forEach((topic) => {
      data[topic.title_top] = articles.filter((article) => questions[parseInt(article.question_id) - 1].topic === topic.title_top);
    });
    setNewsData(data);
  }, [articles, questions, topics]);

  useScrollTriggers([
    { limitT: 0, limitB: 200, scrollTo: window.innerHeight, direction: SCROLL_DIRECTIONS.TOP_ONLY },
    { limitT: 200, limitB: window.innerHeight, scrollTo: 0, direction: SCROLL_DIRECTIONS.TOP_ONLY },
    { limitT: 0, limitB: window.innerHeight - 200, scrollTo: window.innerHeight, direction: SCROLL_DIRECTIONS.BOTTOM_ONLY },
    { limitT: window.innerHeight - 200, limitB: window.innerHeight, scrollTo: 0, direction: SCROLL_DIRECTIONS.BOTTOM_ONLY },
  ]);

  useEffect(() => {
    document.body.style.overflow = isFixed ? 'auto' : 'hidden';
  }, [isFixed]);

  const getHeroStyles = (isFixed: boolean) => {
    const baseStyles = {
      transition: 'opacity 0.3s ease-in-out, transform 0.3s ease-in-out',
    };

    return isFixed ? baseStyles : { ...baseStyles, opacity: 1, transform: 'scale(1)' };
  };

  // HeroSection Component
const HeroSection = ({ isFixed, heroRef, setIsFixed }) => (
  <div
    ref={heroRef}
    className="hero-section"
    style={getHeroStyles(isFixed)}
  >
    <div className="hero-content">
      <div className="pointer-events-auto">
        <Button
          variant="outline"
          className="hero-button"
          onClick={() => setIsFixed(true)}
        >
          <p>Welcome to the</p>
          <p className='font-bold'>NewsRoom</p>
        </Button>
      </div>
    </div>
  </div>
);

  if (!mounted) {
    return null;
  }

  return (
    <div className="app-page">
      <div className="z-100 w-screen h-screen transition-[height] duration-300 ease-in-out" style={{ height: isFixed ? heroRef.current?.offsetHeight : 'auto' }}>
        {!isFixed && <HeroSection isFixed={isFixed} heroRef={heroRef} setIsFixed={setIsFixed} />}
      </div>

      <div className="header-hero" style={{
        height: heroRef.current?.offsetHeight,
        pointerEvents: isFixed ? 'auto' : 'none',
        ...getHeroStyles(true)
      }}>
        <HeaderAndHeroGlobeComponent />
      </div>

      <div className={`news-main ${isFixed ? 'z-10' : ''}`}>
        <NewsMain
          newsData={newsData}
          setNewsData={setNewsData}
          questions={questions}
          activeTab={activeTab}
          setActiveTab={setActiveTab}
          favorites={favorites}
          videos={videos}
          setFavorites={setFavorites}
          showFavorites={showFavorites}
          setShowFavorites={setShowFavorites}
          showDelete={showDeleteNotification}
          showAdd={showAddNotification}
        />
      </div>
      <Notification message="Article added to favorites!" color="green" show={AddNotification} setShow={showAddNotification} />
      <Notification message="Article removed from favorites!" color="red" show={DeleteNotification} setShow={showDeleteNotification} />
    </div>
  );
}

// Debounce function
function debounce(func, wait) {
  let timeout;
  return (...args) => {
    clearTimeout(timeout);
    timeout = setTimeout(() => func(...args), wait);
  };
}

