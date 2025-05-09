/* REACT */
import React, { useState } from "react";

/* COMPONENTS */
import { Button } from "./ui/button";
import { RefreshCcw } from "lucide-react";
import NewsArticle from "./core/newsarticle";
import NewsVideo from "./core/newsvideo";
import { Separator } from "@/components/ui/separator";

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
            word = word.replace(/[^a-zA-Z0-9]/g, '')
            return keywords.includes(word)
                ? 'bg-gradient-to-r from-blue-300 to-blue-500 text-transparent bg-clip-text'
                : '';
        };

        return (
            <div className="justify-center ">
                <div className="inline-block text-center whitespace-normal break-words">
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
                    keywords: data.keywords
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
            <div className="question-header">
                {/* <h1 className="question-title">{questionText}</h1> */}

                <div className="w-fit">
                    <KeywordHighlighter text={questionText} keywords={questionKeywords} />
                </div>

                <div>
                    <div className="flex flex-row items-center justify-center w-fit mt-6 px-20">
                        <p className="relative question-keywords ">
                            <div className="absolute xl:-top-1/4 xl:-left-14 refresh-button-containe">
                                <Button
                                    variant="ghost"
                                    className={`button`}
                                    onClick={() => onQuestionChange(questions.find((qst: Question) => qst.text === questionText)!)}
                                >
                                    <div className="button-content p-3 ">
                                        <RefreshCcw
                                            strokeWidth={2}
                                            style={{ width: 16, height: 16 }}
                                        />
                                    </div>
                                </Button>
                            </div>


                            {questionKeywords || "No keywords"}

                        </p>

                    </div>
                    <Separator className="bg-gray-600 my-6" />
                </div>

            </div>

            <div className="news-grid">
                {newsData[activeTab][questionText].map(
                    (obj: Video | Article) => {
                        if (obj.type == "article") {
                            return (
                                <div key={`article-${obj.id}`}>
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

            <Separator className="separator" />
        </div>
    )
}

export default React.memo(QuestionContainer);

