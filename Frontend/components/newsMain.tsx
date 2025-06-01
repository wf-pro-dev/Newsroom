import { useEffect, useMemo, useRef, useState } from "react";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import NewsCarousel from "./newsCarousel";
import { Question } from "@/utils/types";
import { Button } from "./ui/button";
import { Heart, LogOut, LucideIcon, User } from "lucide-react";
import NewsFavorites from "./newsFavorites";
import "@/styles/newsmain.css";
import "@/styles/page.css";
import { useGlobalState } from "@/components/context/GlobalStateContext";
import QuestionContainer from "./questionContainer";
import { logout } from "@/utils/api";
import ProfilePage from "./profile";

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

    setTimeout(() => {
      setActiveTab(value);
      window.scrollTo({ top: window.innerHeight, behavior: "instant" });
      setTimeout(() => {
        setIsChanging(false);
      }, 200);
    }, 400);
  }

  function goUp(category: string) {
    if (category === activeTab) {
      window.scrollTo({ top: window.innerHeight, behavior: "smooth" });
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
      text: user?.username.charAt(0).toUpperCase() + user?.username.slice(1),
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
              className={`${ active ? "active-button" : "button" }`}
              onClick={onClick}
            >
              <div className="button-content">
                <Icon strokeWidth={1.5} style={{ width: 28, height: 28 }} />
              </div>
            </Button>
          </div>


          <div className="absolute flex flex-col px-2 py-1 transition-all duration-300 ease-in-out border rounded-lg shadow-lg opacity-0 grow -top-2/3 bg-gradient-to-r from-blue-500/60 via-blue-600/60 to-blue-500/60 border-blue-500/30 shadow-blue-500/20 group-hover:opacity-100" >
            <p className="text-sm font-medium">{text}</p>
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
      <TabsList className={`tabs-list group ${showHeader && !showProfile ? "opacity-100" : "opacity-0"}`}>
        {Object.keys(newsData).map((category, index) => (
          <div key={index} className="tab-item">
            <TabsTrigger
              key={category}
              value={category}
              onClick={() => goUp(category)}
              className={`
                relative
                py-2.5 px-4
                tab-trigger
                
                ${showHeader && !showProfile
                  ? "data-[state=active]:translate-y-0 group-hover:translate-y-0"
                  : "data-[state=active]:-translate-y-20"
                } 
                ${atInnerHeight && !showProfile
                  ? "translate-y-0"
                  : "-translate-y-20"
                }
              `}
            >
              <p className="text-sm font-medium">
                {category}
              </p>
            </TabsTrigger>
          </div>
        ))}
      </TabsList>

      {!showFavorites &&
       !showProfile &&
       Object.keys(newsData).map(
          (topic, index) => {
            return (
              topic === activeTab && (
                <div
                  key={index}
                  className="overflow-scroll tabs-content-container xl:px-24 2xl:px-40"
                >
                  <TabsContent
                    key={topic}
                    value={topic}
                    className={`${isChanging ? "opacity-0" : "opacity-100"
                      } tabs-content`}
                  >
                    <div className="my-12 separator" />

                    {questions.filter((question: Question) =>
                      Object.keys(newsData[activeTab]).includes(question.text)
                    ).length == 3 && (

                        <NewsCarousel
                          topic_title={activeTab}
                          questions={topic_questions}
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

      <div className={`footer  ${(showHeader && ( !atInnerHeight || showFavorites )) ? "translate-y-1/2 bottom-0" : "translate-y-full bottom-0"
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
