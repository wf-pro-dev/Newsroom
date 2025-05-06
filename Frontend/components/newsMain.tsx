import { useEffect, useState } from "react";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Separator } from "@/components/ui/separator";
import NewsCarousel from "./newsCarousel";
import { Question } from "@/utils/types";
import { Button } from "./ui/button";
import { Heart, LogOut } from "lucide-react";
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

  const {
    setUser,
    newsData,
    questions
  } = useGlobalState();


  useEffect(() => {
    const handleScroll = () => {
      setShowHeader(window.scrollY >= window.innerHeight);
      setAtInnerHeight(window.scrollY === window.innerHeight);
    };

    window.addEventListener("scroll", handleScroll);

    return () => {
      window.removeEventListener("scroll", handleScroll);
    };
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


  return (
    <Tabs
      value={activeTab}
      onValueChange={onValueChange}
      className="tabs-container m-0 p-0"
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
                        questions={questions.filter((question: Question) =>
                          Object.keys(newsData[activeTab]).includes(question.text)
                        )
                        }
                      />

                    )}

                  <Separator className="separator" />

                  <div
                    key={activeTab}
                  >

                    {Object.keys(newsData[activeTab]).map(
                      (questionText: string, qIndex) => {
                        const questionKeywords = questions.find(
                          (qst: Question) => qst.text === questionText
                        )?.keywords;
                        return (
                          <QuestionContainer
                            key={`question_${qIndex}`}
                            activeTab={activeTab}
                            index={index}
                            qIndex={qIndex}
                            questionText={questionText}
                            questionKeywords={questionKeywords ? questionKeywords : ""}
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

        )}

      {showFavorites && (
        <NewsFavorites
          showFavorites={showFavorites}
          showDelete={showDelete}
          showAdd={showAdd}
        />
      )}

      <div className={`footer  ${showHeader ? "translate-y-0" : "translate-y-full"
        }`} >

        <div
          className={`button-container`}
        >
          <Button
            variant="secondary"
            className={`button ${showFavorites ? "bg-gray-700/80" : "bg-black/70"
              }`}
            onClick={() => setShowFavorites(!showFavorites)}
          >
            <div className="button-content">
              <Heart strokeWidth={1.5} style={{ width: 20, height: 20 }} />
            </div>
          </Button>
        </div>
        
        <div
          className={`button-container`}
        >
          <Button
            variant="secondary"
            className={`button ${showFavorites ? "bg-gray-700/80" : "bg-black/70"
              }`}
            onClick={onLogOut}
          >
            <div className="button-content">
              <LogOut strokeWidth={1.5} style={{ width: 20, height: 20 }} />
            </div>
          </Button>
        </div>

      </div>
    </Tabs>
  );
}

export default NewsMain;
