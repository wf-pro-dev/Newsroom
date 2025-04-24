import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Separator } from "@/components/ui/separator";
import NewsCarousel from "./newsCarousel";
import { Article, Question, Topic, Video } from "@/utils/types";
import { useEffect, useState } from "react";
import { Button } from "./ui/button";
import { Heart } from "lucide-react";
import NewsFavorites from "./newsFavorites";
import "@/styles/newsmain.css";
import { useGlobalState } from "@/components/context/GlobalStateContext";
import { mixArray } from "@/lib/utils";
import QuestionContainer from "./questionContainer";

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
    newsData,
    setNewsData,
    topics,
    questions,
    articles,
    videos,
  } = useGlobalState();

  useEffect(() => {
    const data: Record<string, Record<string, Array<Video | Article>>> = {};

    topics.forEach((topic: Topic) => {
      if (!data[topic.title]) {
        data[topic.title] = {};
      }

      questions
        .filter((question: Question) => question.topic_id === topic.id)
        .forEach((qst: Question) => {
          data[topic.title][qst.text] = mixArray(
            articles.filter((article) => article.question_id === qst.id),
            videos.filter((video) => video.question_id === qst.id),
            4
          );
        });
    });
    setNewsData(data);
  }, [topics, questions, articles, videos]);

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
      window.scrollTo({ top: window.innerHeight });
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
                          ${
                            showHeader
                              ? "data-[state=active]:translate-y-0"
                              : "data-[state=active]:-translate-y-20"
                          } 
                          ${
                            atInnerHeight
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
                  className={`${
                    isChanging ? "opacity-0" : "opacity-100"
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

      <div
        className={`button-container xl:right-2 2xl:right-12 ${
          showHeader ? "translate-y-0" : "translate-y-full"
        }`}
      >
        <Button
          variant="secondary"
          className={`button ${
            showFavorites ? "bg-gray-700/80" : "bg-black/70"
          }`}
          onClick={() => setShowFavorites(!showFavorites)}
        >
          <div className="button-content">
            <Heart strokeWidth={2} style={{ width: 28, height: 28 }} />
          </div>
        </Button>
      </div>
    </Tabs>
  );
}

export default NewsMain;
