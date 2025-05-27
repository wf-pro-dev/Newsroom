/* REACT */
import React, { useState } from "react";

/* COMPONENTS */
import { Button } from "./ui/button";
import { RefreshCcw } from "lucide-react";
import NewsArticle from "./core/newsarticle";
import NewsVideo from "./core/newsvideo";

/* FUNCTIONS */
import { refreshQuestion } from "@/utils/api";
import { useGlobalState } from "./context/GlobalStateContext";

/* STYLES */
import "../styles/newsmain.css";

/* TYPES */
import { Article, Question, Video } from "@/utils/types";



function QuestionContainer({
    activeTab,
    index,
    qIndex,
    questionText,
    questionKeywords,
    showFavorites,
    showDelete,
    showAdd,
}: {
    activeTab: string,
    index: number,
    qIndex: number,
    questionText: string
    questionKeywords: string,
    showFavorites: boolean;
    showDelete: React.Dispatch<React.SetStateAction<boolean>>;
    showAdd: React.Dispatch<React.SetStateAction<boolean>>;
}) {

    const {
        csrftoken,
        newsData,
        questions,
        setQuestions,
        articles,
        setArticles,
        videos,
        setVideos,
    } = useGlobalState();

    const [isCollapsed, setIsCollapsed] = useState(false);
   

    function KeywordHighlighter({ text, keywords }: { text: string; keywords: string }) {
        const highlightKeyword = (word: string) => {
          word = word.replace(/[^a-zA-Z0-9]/g, '');
          return keywords.includes(word)
            ? 'bg-gradient-to-l from-blue-300 to-blue-600 text-transparent bg-clip-text animated-gradient'
            : '';
        };
      
        return (
          <div className="w-4/5">
            <div className="inline-block text-center break-words whitespace-normal">
              <p>
                {text.split(' ').map((word, index) => (
                  <span
                    key={index}
                    className={`
                      ${highlightKeyword(word)}
                      question-title
                      mr-1
                      inline-block
                      break-words 
                      overflow-wrap-normal
                    `}
                  >
                    {word}
                  </span>
                ))}
              </p>
            </div>
          </div>
        );
      }



    function onQuestionChange(qst: Question) {

        setIsCollapsed(true); 

        const index = questions.findIndex((question) => question == qst)

        refreshQuestion(qst.id, csrftoken!)
            .then((data) => {

               
                const qstData: Question =
                {
                    id: data.id,
                    text: data.text,
                    topic_id: data.topic_id,
                    keywords: data.keywords,
                    order: data.order
                }

                setArticles(
                    articles
                        .filter((article) => article.question_id != qst.id)
                        .concat(data.articles)
                )

                setVideos(
                    videos
                        .filter((video) => video.question_id != qst.id)
                        .concat(data.videos)
                )

                setQuestions(
                    questions
                        .filter((question) => question != qst)
                        .toSpliced(index, 0, qstData)
                )

            })
            .finally(() => {
                setIsCollapsed(false);  // Expand after API completes
            });

    }

    return (
        <div key={`${index}-${qIndex}`} className={`transition-all duration-700 ease-in-out ${
            isCollapsed 
                ? "max-h-0 opacity-0 overflow-hidden" 
                : "max-h-[5000px] opacity-100"
        }`}>
            <div className="space-y-8 question-header">
                <div className="flex flex-col items-center w-full">
                    <KeywordHighlighter text={questionText} keywords={questionKeywords} />
                </div>

                <div className="relative">
                    <div className="flex flex-row items-center justify-center w-full">
                        <div className="relative group">
                            <Button
                                variant="ghost"
                                className="absolute p-3 transition-all duration-300 -translate-y-1/2 rounded-full shadow-lg -left-16 top-1/2 hover:bg-blue-500/20 hover:shadow-blue-500/20"
                                onClick={() => onQuestionChange(questions.find((qst: Question) => qst.text === questionText)!)}
                            >
                                <RefreshCcw
                                    strokeWidth={2.5}
                                    className="w-6 h-6 text-blue-400 transition-colors group-hover:text-blue-300"
                                />
                            </Button>
                            
                            <div className="px-4 py-3 border shadow-lg rounded-xl bg-gradient-to-r from-blue-500/20 via-blue-600/20 to-blue-500/20 backdrop-blur-md border-blue-500/20 shadow-blue-500/10">
                                <p className="text-base font-medium text-transparent bg-gradient-to-r from-blue-300 to-blue-500 bg-clip-text">
                                    {questionKeywords || "No keywords"}
                                </p>
                            </div>
                        </div>
                    </div>
                    
                    <div className="my-8 separator" />
                </div>
            </div>

            <div className="news-grid">
                {newsData[activeTab][questionText].map(
                    (obj: Video | Article) => {
                        if (obj.type == "article") {
                            return (
                                <div key={`article-${obj.id}`} className="bg-transparent">
                                    <NewsArticle
                                        article={obj as Article}
                                        showFavorites={showFavorites}
                                        showDelete={showDelete}
                                        showAdd={showAdd}
                                    />
                                </div>
                            );
                        }
                        return (
                            <div
                                key={`video-${obj.id}`}
                                className="video-container"
                            >
                                <div className="video-wrapper">
                                    <NewsVideo
                                        video={obj as Video}
                                        showFavorites={showFavorites}
                                        showDelete={showDelete}
                                        showAdd={showAdd}
                                    />
                                </div>
                            </div>
                        );
                    }
                )}
            </div>

            <div className="my-16 separator" />
        </div>
    )
}

export default React.memo(QuestionContainer);

