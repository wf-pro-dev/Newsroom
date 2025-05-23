import { useEffect, useMemo, useRef, useState } from "react";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Separator } from "@/components/ui/separator";
import NewsCarousel from "./newsCarousel";
import { Question } from "@/utils/types";
import { Button } from "./ui/button";
import { Heart, LogOut, User } from "lucide-react";
import NewsFavorites from "./newsFavorites";
import "@/styles/newsmain.css";
import { useGlobalState } from "@/components/context/GlobalStateContext";
import QuestionContainer from "./questionContainer";
import { logout } from "@/utils/api";

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
  const [atInnerHeight, setAtInnerHeight] = useState(false);
  const showHeaderRef = useRef(false);
  const atInnerHeightRef = useRef(false); 

  const {
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

  // Inside NewsMain component
const topic_questions = useMemo(() => 
  questions
  .filter((question: Question) =>
    Object.keys(newsData[activeTab]).includes(question.text)
  )
  .sort((a, b) => a.order - b.order), 
  [questions, newsData, activeTab] // Recompute only when these change
);
console.log("topic_question",topic_questions)
  return (
    <Tabs
      value={activeTab}
      onValueChange={onValueChange}
      className="tabs-container"
    >
      <TabsList className="tabs-list group">
        {Object.keys(newsData).map((category, index) => (
          <div key={index} className="tab-item">
            <TabsTrigger
              key={category}
              value={category}
              onClick={() => goUp(category)}
              className={`
                          tab-trigger
                          group-hover:translate-y-0
                          ${showHeader
                  ? "data-[state=active]:translate-y-0"
                  : "data-[state=active]:-translate-y-20"
                } 
                          ${atInnerHeight
                  ? "translate-y-0"
                  : "-translate-y-20"
                }
                      `}
            >
              <p className="2xl:text-[15px] xl:text-sm font-medium">
                {category}
              </p>
            </TabsTrigger>
          </div>
        ))}
      </TabsList>

      {!showFavorites &&
        Object.keys(newsData).map(
          (topic, index) =>
          { 
            return (
            topic === activeTab && (
              <div
                key={index}
                className="tabs-content-container xl:px-24 2xl:px-40"
              >
                <TabsContent
                  key={topic}
                  value={topic}
                  className={`${isChanging ? "opacity-0" : "opacity-100"
                    } tabs-content`}
                >
                  <Separator className="separator" />

                  {questions.filter((question: Question) =>
                    Object.keys(newsData[activeTab]).includes(question.text)
                  ).length == 3 && (

                      <NewsCarousel
                        topic_title={activeTab}
                        questions={topic_questions}
                      />

                    )}

                  <Separator className="separator" />

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

      <div className={`footer  ${showHeader ? "translate-y-0 -bottom-8" : "translate-y-full bottom-0"
        }`} >

        <div className="flex flex-col items-center space-y-2" >
          <div
            className={`button-container`}
          >
            <Button
              variant="secondary"
              className={`button`}
              onClick={onLogOut}
            >
              <div className="button-content">
                <User strokeWidth={2} style={{ width: 20, height: 20 }} />
              </div>
            </Button>
          </div>
          <p className="text-xs text-center font-semibold ">Profile</p>
        </div>

        <div className="flex flex-col items-center space-y-2" >
          <div
            className={`button-container`}
          >
            <Button
              variant="secondary"
              className={`button`}
              onClick={() => setShowFavorites(!showFavorites)}
            >
              <div className="button-content">
                <Heart strokeWidth={2} style={{ width: 20, height: 20 }} />
              </div>
            </Button>
          </div>

          <p className="text-xs text-center font-semibold"> Likes</p>
        </div>


        <div className="flex flex-col items-center space-y-2" >
          <div
            className={`button-container`}
          >
            <Button
              variant="secondary"
              className={`button`}
              onClick={onLogOut}
            >
              <div className="button-content">
                <LogOut strokeWidth={2} style={{ width: 20, height: 20 }} />
              </div>
            </Button>
          </div>
          <p className="text-xs text-center font-semibold"> Log Out</p>
        </div>

      </div>
    </Tabs>
  );
}

export default NewsMain;
