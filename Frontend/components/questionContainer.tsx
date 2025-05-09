//React
import React, { useEffect, useRef, useState } from "react";

/* COMPONENTS */
import { Button } from "./ui/button";
import { RefreshCcw } from "lucide-react";
import NewsArticle from "./core/newsarticle";
import NewsVideo from "./core/newsvideo";
import { Separator } from "@/components/ui/separator";

/* FUNCTIONS */
import { addQuestion, deleteQuestionbyId } from "@/utils/api";
import { useGlobalState } from "./context/GlobalStateContext";

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
        favourites,
        setFavourites,
    } = useGlobalState();

    const [isExpanded, setIsExpanded] = useState(true);
    const [contentHeight, setContentHeight] = useState(0);
    const contentRef = useRef<HTMLDivElement | null>(null);

    useEffect(() => {
        // Measure the scrollHeight of the content to get its full height
        if (contentRef.current) {
            setContentHeight(contentRef.current.scrollHeight);
        }

        // Update the height measurement if content changes
        const resizeObserver = new ResizeObserver(entries => {
            for (const entry of entries) {
                if (entry.target === contentRef.current) {
                    setContentHeight(entry.target.scrollHeight);
                }
            }
        });

        if (contentRef.current) {
            resizeObserver.observe(contentRef.current);
        }

        return () => {
            if (contentRef.current) {
                resizeObserver.unobserve(contentRef.current);
            }
        };
    }, []);

    function KeywordHighlighter({ text, keywords }: { text: string; keywords: string }) {
        const highlightKeyword = (word: string) => {
            return keywords.split(" ").includes(word.toLowerCase())
                ? 'bg-gradient-to-r from-blue-300 to-blue-500 text-transparent bg-clip-text'
                : '';
        };

        return (
            <div className="w-full flex justify-center">
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

        const index = questions.findIndex((question) => question == qst)

        deleteQuestionbyId(qst.id, csrftoken)
            .then(() => setIsExpanded(false))


        addQuestion(qst.topic_id, csrftoken)
            .then((data) => {

                const objData = data[0]
                const qstData: Question =
                {
                    id: objData.id,
                    text: objData.text,
                    topic_id: objData.topic_id,
                    keywords: objData.keywords
                }

                setArticles(
                    articles
                        .filter((article) => article.question_id != qst.id)
                        .concat(objData.articles)
                )

                setVideos(
                    videos
                        .filter((video) => video.question_id != qst.id)
                        .concat(objData.videos)
                )

                setQuestions(
                    questions
                        .filter((question) => question != qst)
                        .toSpliced(index, 0, qstData)
                )


                setIsExpanded(true)

            })

    }

    return (
        <div key={`${index}-${qIndex}`}
            ref={contentRef}
            style={{
                height: isExpanded ? `${contentHeight}px` : '1px',
                opacity: isExpanded ? 1 : 0,
                transition: 'height 0.6s ease-in-out, opacity 0.6s ease-in-out',
                overflow: 'hidden'
            }}
        >
            <div className="question-header">
                {/* <h1 className="question-title">{questionText}</h1> */}

                <KeywordHighlighter text={questionText} keywords={questionKeywords} />


                <div className="flex flex-row items-center justify-center w-full">

                    <div className="xl:top-0 xl:left-0 refresh-button-container">
                        <Button
                            variant="ghost"
                            className={`button`}
                            onClick={() => onQuestionChange(questions.find((qst: Question) => qst.text === questionText)!)}
                        >
                            <div className="button-content p-3">
                                <RefreshCcw
                                    strokeWidth={2}
                                    style={{ width: 16, height: 16 }}
                                />
                            </div>
                        </Button>
                    </div>

                    <p className="question-keywords w-fit flex-grow">
                        {questionKeywords}
                    </p>

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
                                        favourites={favourites}
                                        showFavorites={showFavorites}
                                        setFavourites={setFavourites}
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
                                        favourites={favourites}
                                        setFavourites={setFavourites}
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

