import { useEffect, useMemo, useRef, useState } from "react";
import { Tabs, TabsContent } from "@/components/ui/tabs";
import NewsCarousel from "./newsCarousel";
import { Question } from "@/utils/types";
import { Button } from "./ui/button";
import { Heart, LogOut, LucideIcon, User } from "lucide-react";
import NewsFavorites from "./newsFavorites";
import "@/styles/newsmain.css";
import "@/styles/page.css";
import { useGlobalState } from "@/src/contexts/GlobalStateContext";
import QuestionContainer from "./questionContainer";
import { logout } from "@/utils/api";
import ProfilePage from "./profile";
import { motion, AnimatePresence } from "framer-motion";

function NewsMain({
  activeTab,
  setActiveTab,
  showFavorites,
  setShowFavorites,
  showDelete,
  showAdd,
}: {
  activeTab: string;
  setActiveTab: (tab: string) => void;
  showFavorites: boolean;
  setShowFavorites: React.Dispatch<React.SetStateAction<boolean>>;
  showDelete: React.Dispatch<React.SetStateAction<boolean>>;
  showAdd: React.Dispatch<React.SetStateAction<boolean>>;
}) {
  const [isChanging, setIsChanging] = useState(false);
  const [showHeader, setShowHeader] = useState(false);
  const [showProfile, setShowProfile] = useState(false);
  const [atInnerHeight, setAtInnerHeight] = useState(false);
  const showHeaderRef = useRef(false);
  const atInnerHeightRef = useRef(false);
  

  const {
    user,
    setUser,
    newsData,
    questions,
  } = useGlobalState();

  const availableTabs = useMemo(() => Object.keys(newsData), [newsData]);

  useEffect(() => {
    const handleScroll = () => {
      const showHeader = window.scrollY >= window.innerHeight;
      const atInnerHeight = window.scrollY === window.innerHeight;

      // Only update state if values actually changed
      if (showHeader !== showHeaderRef.current || atInnerHeight !== atInnerHeightRef.current) {
        setShowHeader(showHeader);
        setAtInnerHeight(atInnerHeight);
        showHeaderRef.current = showHeader;
        atInnerHeightRef.current = atInnerHeight;
      }
    };

    window.addEventListener("scroll", handleScroll);
    return () => window.removeEventListener("scroll", handleScroll);
  }, []);

  function onValueChange(value: string) {
    if (showFavorites) setShowFavorites(false);

    setIsChanging(true);
    // Add smooth transition animation
    setTimeout(() => {
      setActiveTab(value);
      window.scrollTo({ top: window.innerHeight, behavior: "instant" });
      setTimeout(() => {
        setIsChanging(false);
      }, 300);
    }, 200);
  }

  function onTabChange(category: string) {
    if (category === activeTab) {
      // If clicking the same tab, scroll to content
      window.scrollTo({ top: window.innerHeight, behavior: "smooth" });
    } else {
      // If clicking a different tab, use proper onValueChange flow
      onValueChange(category);
    }
  }

  const onLogOut = async () => {
    window.scrollTo({ top: 0, behavior: "smooth" });
    setTimeout(async () => {
      await logout().then(() => { setUser(null) })
    }, 400);
  }

  const onPageChange = (page: string) => {
    if (page === "profile") {
      setShowProfile(!showProfile)
      setShowFavorites(false)
    } else if (page === "favorites") {
      setShowFavorites(!showFavorites)
      setShowProfile(false)
    }
  }

  // Inside NewsMain component
  const topic_questions = useMemo(() =>
    questions
      .filter((question: Question) =>
        Object.keys(newsData[activeTab]).includes(question.text)
      )
      .sort((a, b) => a.order - b.order),

    [questions, newsData, activeTab] // Recompute only when these change
  );


  const bottom_buttons = [
    {
      icon: User,
      text: user?.username ? user.username.charAt(0).toUpperCase() + user.username.slice(1) : "Profile",
      active: showProfile,
      onClick: () => onPageChange("profile")
    },
    {
      icon: Heart,
      text: "Favorites",
      active: showFavorites,
      onClick: () => onPageChange("favorites")
    },
    {
      icon: LogOut,
      text: "LogOut",
      active: false,
      onClick: onLogOut
    }
  ]

  const BottomButton = (
    { Icon, text, active, onClick }: { Icon: LucideIcon, text: string, active: boolean, onClick: () => void }) => {
    return (
      <div className="flex flex-col items-center group" >
        <div
          className={`button-container`}
        >
          <Button
            variant="secondary"
            className={`${active ? "active-button" : "button"}`}
            onClick={onClick}
          >
            <div className="button-content">
              <Icon strokeWidth={1.5} style={{ width: 28, height: 28 }} />
            </div>
          </Button>
        </div>


        <div className="absolute flex flex-col px-2 py-1 transition-all duration-300 ease-in-out border rounded-lg shadow-lg opacity-0 grow -top-2/3 bg-gradient-to-r from-slate-700/80 via-slate-800/80 to-slate-700/80 border-slate-600/50 shadow-slate-900/40 group-hover:opacity-100" >
          <p className="text-sm font-medium text-slate-200">{text}</p>
        </div>

      </div>
    )
  }

  return (
    <Tabs
      value={activeTab}
      onValueChange={onValueChange}
      className="tabs-container"
    >
      {!showFavorites && (
        <div
          className={`tabs-list group relative opacity-0`}
        >
          <AnimatePresence mode="wait" >
            {availableTabs.map((category, index) => (
              <motion.div
                key={`${category}-${index}`}
                className="tab-item relative z-10"
                initial={{ scale: 0.8, opacity: 0, y: 20 }}
                animate={{ scale: 1, opacity: 1, y: 0 }}
                exit={{ scale: 0.8, opacity: 0, y: -20 }}
                transition={{
                  duration: 0.5,
                  delay: index * 0.08,
                  ease: [0.23, 1, 0.32, 1]
                }}
              >
                <motion.button
                  onClick={() => onTabChange(category)}
                  className={`
                    relative p-4 rounded-2xl font-medium tracking-wide
                    transition-all duration-500 ease-in-out backdrop-blur-xl
                    overflow-hidden z-20
                    ${activeTab === category
                      ? 'text-white font-semibold'
                      : 'text-slate-300 hover:text-slate-200'
                    }
                  `}
                  whileHover={{
                    scale: 1.02,
                    transition: { duration: 0.2 }
                  }}
                  whileTap={{
                    scale: 0.98,
                    transition: { duration: 0.1 }
                  }}
                  onTap={() => {
                    // Create ripple effect
                    const ripple = document.createElement('div');
                    ripple.className = 'absolute inset-0 bg-white/20 rounded-2xl animate-ping';
                    ripple.style.animationDuration = '0.6s';
                    const button = event?.currentTarget as HTMLElement;
                    button.appendChild(ripple);
                    setTimeout(() => ripple.remove(), 600);
                  }}
                >



                  {/* Enhanced text animation */}
                  <motion.span
                    className="relative z-30"
                    initial={{ y: 10, opacity: 0 }}
                    animate={{ y: 0, opacity: 1 }}
                    transition={{
                      duration: 0.4,
                      delay: index * 0.05,
                      ease: [0.23, 1, 0.32, 1]
                    }}
                  >
                    <AnimatePresence mode="wait">
                      <motion.span
                        key={activeTab}
                        initial={{
                          y: activeTab === category ? -20 : 0,
                          opacity: activeTab === category ? 0 : 1,
                          scale: activeTab === category ? 0.9 : 1
                        }}
                        animate={{
                          y: 0,
                          opacity: 1,
                          scale: 1
                        }}
                        exit={{
                          y: activeTab === category ? 20 : 0,
                          opacity: activeTab === category ? 0 : 1,
                          scale: activeTab === category ? 1.1 : 1
                        }}
                        transition={{
                          duration: 0.3,
                          ease: [0.23, 1, 0.32, 1]
                        }}
                        className="inline-block"
                      >
                        {category.split('').map((char, charIndex) => (
                          <motion.span
                            key={`${category}-${charIndex}`}
                            initial={{
                              y: 15,
                              opacity: 0,
                              rotateX: -90
                            }}
                            animate={{
                              y: 0,
                              opacity: 1,
                              rotateX: 0
                            }}
                            transition={{
                              duration: 0.4,
                              delay: (index * 0.05) + (charIndex * 0.015),
                              ease: [0.23, 1, 0.32, 1]
                            }}
                            className="inline-block"
                            style={{
                              transformOrigin: 'center bottom',
                              textShadow: activeTab === category
                                ? '0 0 10px rgba(59, 130, 246, 0.5), 0 0 20px rgba(59, 130, 246, 0.3)'
                                : 'none'
                            }}
                          >
                            {char === ' ' ? '\u00A0' : char}
                          </motion.span>
                        ))}
                      </motion.span>
                    </AnimatePresence>
                  </motion.span>

                  {/* Particle effect for active tab */}
                  <AnimatePresence>
                    {activeTab === category && (
                      <motion.div className="absolute inset-0 pointer-events-none">
                        {[...Array(6)].map((_, i) => (
                          <motion.div
                            key={i}
                            className="absolute w-1 h-1 bg-blue-400/60 rounded-full"
                            initial={{
                              opacity: 0,
                              scale: 0,
                              x: Math.random() * 100 - 50,
                              y: Math.random() * 40 - 20
                            }}
                            animate={{
                              opacity: [0, 1, 0],
                              scale: [0, 1, 0],
                              y: [0, -30, -60],
                              x: [0, (Math.random() - 0.5) * 40]
                            }}
                            transition={{
                              duration: 2,
                              repeat: Infinity,
                              delay: i * 0.3,
                              ease: "easeOut"
                            }}
                            style={{
                              left: '50%',
                              top: '50%',
                              boxShadow: '0 0 6px rgba(59, 130, 246, 0.8)'
                            }}
                          />
                        ))}
                      </motion.div>
                    )}
                  </AnimatePresence>
                </motion.button>
              </motion.div>
            ))}
          </AnimatePresence>
        </div>
      )}

      {!showFavorites &&
        !showProfile &&
        availableTabs.map(
          (topic, index) => {
            return (
              topic === activeTab && (
                <div
                  key={index}
                  className="overflow-scroll tabs-content-container "
                >
                  <TabsContent
                    key={topic}
                    value={topic}
                    className={`${isChanging ? "opacity-0" : "opacity-100"
                      } tabs-content`}
                  >


                    {questions.filter((question: Question) =>
                      Object.keys(newsData[activeTab]).includes(question.text)
                    ).length == 3 && (

                        <NewsCarousel
                          key={activeTab}
                          topic_title={activeTab}
                          questions={topic_questions}
                          activeTab={activeTab}
                          setActiveTab={setActiveTab}
                          availableTabs={availableTabs}
                        />

                      )}

                    <div className="my-16 separator" />

                    <div
                      key={activeTab}
                    >

                      {topic_questions.map(
                        (question: Question, qIndex) => {

                          return (
                            <QuestionContainer
                              key={`question_${qIndex}`}
                              activeTab={activeTab}
                              index={index}
                              qIndex={qIndex}
                              questionText={question.text}
                              questionKeywords={question.keywords ? question.keywords : ""}
                              showFavorites={showFavorites}
                              showDelete={showDelete}
                              showAdd={showAdd}
                            />

                          );
                        }

                      )}
                    </div>

                  </TabsContent>
                </div>
              )
            )
          }

        )}

      {showFavorites && (
        <NewsFavorites
          showFavorites={showFavorites}
          showDelete={showDelete}
          showAdd={showAdd}
        />
      )}

      {showProfile && (
        <ProfilePage />
      )}

      <div className={`footer  ${(showHeader && (!atInnerHeight || showFavorites)) ? "translate-y-1/2 bottom-0" : "translate-y-full bottom-0"
        }`} >

        {bottom_buttons.map((button, index) => (
          <BottomButton
            key={index}
            Icon={button.icon}
            text={button.text!}
            active={button.active}
            onClick={button.onClick}
          />
        ))}

      </div>
    </Tabs >
  );
}

export default NewsMain;
