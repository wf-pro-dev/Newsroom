/* REACT */
import React, { useState } from "react";

/* COMPONENTS */
import NewsArticle from "./core/newsarticle";
import NewsVideo from "./core/newsvideo";
import { motion } from "framer-motion";

/* FUNCTIONS */
import { refreshQuestion } from "@/utils/api";
import { useGlobalState } from "../src/contexts/GlobalStateContext";

/* STYLES */
import "../styles/newsmain.css";

/* TYPES */
import { Article, Question, Video } from "@/utils/types";

/* LDRS */
import { DotStream } from 'ldrs/react'
import 'ldrs/react/DotStream.css'

/* Add this import at the top with other imports */
import { Roboto_Mono } from 'next/font/google'
import { Button } from "./ui/button";
import { RefreshCcw } from "lucide-react";

/* Add font configuration after imports - replace Space_Grotesk config */
const roboto = Roboto_Mono({
    subsets: ['latin'],
    weight: ['400', '500', '700'],
    display: 'swap'
})

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
            const cleanWord = word.replace(/[^a-zA-Z0-9]/g, '');
            return keywords.includes(cleanWord);
        };

        return (
            <div className="w-full">
                <div className={`break-words leading-tight flex flex-wrap tracking-tight z-10 ${roboto.className}`}>
                    {text.split(' ').map((word, index) => {
                        const isKeyword = highlightKeyword(word);
                        return (
                            <span className={`relative`} key={index}>

                                {isKeyword && (
                                    <span className="absolute inset-0 flex items-center justify-center ">

                                        <div className="absolute inset-0 flex items-center justify-center">
                                            <h2
                                                className="
                                                text-lg
                                                md:text-xl
                                                lg:text-2xl 
                                                font-bold 
                                                tracking-tight 
                                                text-slate-400/60 blur-sm"
                                                style={{
                                                    filter: 'blur(6px)',
                                                }}
                                            >
                                                {word}
                                            </h2>
                                        </div>

                                        <div className="absolute inset-0 flex items-center justify-center">
                                            <h2
                                                className="
                                                text-lg
                                                md:text-xl
                                                lg:text-2xl
                                                font-bold 
                                                tracking-tight 
                                                text-blue-700/40 
                                                blur-md"
                                                style={{
                                                    filter: 'blur(10px)',
                                                }}
                                            >
                                                {word}
                                            </h2>
                                        </div>
                                        <div className="absolute inset-0 flex items-center justify-center">
                                            <h2
                                                className="
                                                text-lg
                                                md:text-xl
                                                lg:text-2xl 
                                                font-bold 
                                                tracking-tight 
                                                text-slate-600/30"
                                                style={{
                                                    filter: 'blur(16px)',
                                                }}
                                            >
                                                {word}
                                            </h2>
                                        </div>
                                        <div className="absolute inset-0 flex items-center justify-center">
                                            <h2
                                                className="
                                                text-lg
                                                md:text-xl
                                                lg:text-2xl 
                                                font-bold 
                                                tracking-tight 
                                                text-blue-800/25"
                                                style={{
                                                    filter: 'blur(24px)',
                                                }}
                                            >
                                                {word}
                                            </h2>
                                        </div>
                                        <div className="absolute inset-0 flex items-center justify-center">

                                            <h2
                                                className="
                                            text-lg
                                            md:text-xl
                                            lg:text-2xl 
                                            font-bold 
                                            tracking-tight 
                                            text-blue-800/40 blur-md"
                                                style={{
                                                    filter: 'blur(10px)',
                                                }}
                                            >
                                                {word}
                                            </h2>
                                        </div>
                                    </span>

                                )}

                                <span
                                    key={index}
                                    className={`
                                    text-transparent bg-gradient-to-r from-white via-slate-100 to-gray-100 bg-clip-text font-bold
                                
                                    ${isKeyword
                                            ? 'text-white font-bold relative inline-block'
                                            : 'text-slate-100 font-semibold'
                                        }
                                    mr-3
                                    inline-block
                                    break-words 
                                   
                                    transition-all duration-700
                                    hover:text-white
                                    text-lg
                                    md:text-xl
                                    lg:text-2xl
                                `}
                                    style={isKeyword ? {

                                        textShadow: `
                                            0 0 15px rgba(51, 65, 85, 0.7),
                                            0 0 30px rgba(51, 65, 85, 0.4),
                                            0 0 45px rgba(30, 58, 138, 0.3),
                                            0 0 60px rgba(30, 58, 138, 0.2)
                                        `,
                                        filter: 'drop-shadow(0 0 20px rgba(51, 65, 85, 0.6)) drop-shadow(0 0 40px rgba(30, 58, 138, 0.3))',
                                        letterSpacing: '-0.02em'
                                    } : {
                                        letterSpacing: '-0.01em'
                                    }}
                                >


                                    {word}
                                </span>
                            </span>
                        );
                    })}
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
        <div key={`${index}-${qIndex}`} >

            <div className={`transition-all  px-12 duration-700 ease-in-out ${isCollapsed
                ? "max-h-0 opacity-0 overflow-hidden"
                : "max-h-[5000px] opacity-100"
                }`}>

                <header className="relative z-10 w-full border-b border-slate-600/30 px-28 mb-12">
                    {/* Top Tier: Question Label and Keywords */}

                    <div className="flex flex-row items-center space-x-4">


                        <motion.div
                            initial={{ opacity: 0, y: -10 }}
                            animate={{ opacity: 1, y: 0 }}
                            transition={{ delay: 0.2, duration: 0.6 }}
                            className="flex items-center space-x-4"
                        >
                            <p className="text-sm font-medium tracking-[0.25em] text-slate-300 uppercase drop-shadow-md"
                                style={{
                                    textShadow: `
                                        0 0 15px rgba(100, 116, 139, 0.6),
                                        0 0 30px rgba(100, 116, 139, 0.3)
                                    `
                                }}>
                                Question
                            </p>

                            {/* Separator */}
                            <motion.div
                                initial={{ opacity: 0, scale: 0 }}
                                animate={{ opacity: 1, scale: 1 }}
                                transition={{ delay: 0.4, duration: 0.4 }}
                                className="w-px h-6 bg-gradient-to-b from-transparent via-slate-400/60 to-transparent"
                            />
                        </motion.div>







                        {/* <motion.div
                                initial={{ opacity: 0, x: 20 }}
                                animate={{ opacity: 1, x: 0 }}
                                transition={{ delay: 0.8, duration: 0.6 }}
                                className="relative"
                            >
                                <div className="group relative">
                                    <Button
                                        variant="ghost"
                                        className="p-3 transition-all duration-300 rounded-full shadow-lg hover:bg-blue-500/20 hover:shadow-blue-500/20 group border border-slate-600/30 backdrop-blur-md"
                                        onClick={() => onQuestionChange(questions.find((qst: Question) => qst.text === questionText)!)}
                                    >
                                        <RefreshCcw
                                            strokeWidth={2.5}
                                            className="w-6 h-6 text-blue-400 transition-colors group-hover:text-blue-300"
                                            style={{
                                                filter: 'drop-shadow(0 0 8px rgba(59, 130, 246, 0.6))'
                                            }}
                                        />
                                    </Button>

                                    {/* Refresh button label /}
                                    <motion.div
                                        className="absolute -bottom-8 left-1/2 transform -translate-x-1/2 opacity-0 group-hover:opacity-100 transition-opacity duration-300"
                                        initial={{ opacity: 0 }}
                                        whileHover={{ opacity: 1 }}
                                    >
                                        <span className="text-xs text-slate-400 bg-slate-800/80 px-2 py-1 rounded backdrop-blur-sm">
                                            Refresh
                                        </span>
                                    </motion.div>
                                </div>
                            </motion.div> */}

                        <div className="flex flex-col space-y-5">
                            {/* Middle Tier: Main Question Text - Modern and Subtle with Custom Font */}
                            <motion.div
                                initial={{ opacity: 0, y: 20 }}
                                animate={{ opacity: 1, y: 0 }}
                                transition={{ delay: 0.6, duration: 0.8 }}
                                className="relative flex"
                            >
                                <div className={`relative leading-tight tracking-tight text-center max-w-6xl ${roboto.className}`}>
                                    <div className="text-slate-100">
                                        <KeywordHighlighter text={questionText} keywords={questionKeywords} />
                                    </div>
                                    {/* Add a subtle background glow for the entire title */}
                                    <div className="absolute inset-0 bg-gradient-to-r from-transparent via-blue-500/5 to-transparent blur-3xl -z-10" />
                                </div>
                            </motion.div>
                            {/* Keywords Display - Top Right */}
                            <motion.div
                                initial={{ opacity: 0, y: -10 }}
                                animate={{ opacity: 1, y: 0 }}
                                transition={{ delay: 0.5, duration: 0.6 }}
                                className="relative "
                            >
                                {questionKeywords ?
                                    (<div className="flex flex-row items-center space-x-3">


                                        {questionKeywords.split(', ').map((keyword, index) => {
                                            return (
                                                <div key={index} className="px-2 py-1 border shadow-lg rounded-lg bg-gradient-to-r from-blue-500/20 via-blue-600/20 to-blue-500/20 backdrop-blur-md border-blue-500/20 shadow-blue-500/10">
                                                    <p className="text-xs font-medium text-transparent bg-gradient-to-r from-blue-300 to-blue-500 bg-clip-text whitespace-nowrap">
                                                        {keyword}
                                                    </p>
                                                </div>
                                            )
                                        })}

                                        <motion.div
                                            initial={{ opacity: 0, x: 20 }}
                                            animate={{ opacity: 1, x: 0 }}
                                            transition={{ delay: 0.8, duration: 0.6 }}
                                            className="relative"
                                        >
                                            <div className="group relative">
                                                <Button
                                                    variant="ghost"
                                                    className="p-3 transition-all duration-300 rounded-full shadow-lg hover:bg-blue-500/20 hover:shadow-blue-500/20 group border border-slate-600/30 backdrop-blur-md"
                                                    onClick={() => onQuestionChange(questions.find((qst: Question) => qst.text === questionText)!)}
                                                >
                                                    <RefreshCcw
                                                        strokeWidth={2.5}
                                                        className="w-6 h-6 text-blue-400 transition-colors group-hover:text-blue-300"
                                                        style={{
                                                            filter: 'drop-shadow(0 0 8px rgba(59, 130, 246, 0.6))'
                                                        }}
                                                    />
                                                </Button>

                                                {/* Refresh button label */}
                                                <motion.div
                                                    className="absolute -bottom-8 left-1/2 transform -translate-x-1/2 opacity-0 group-hover:opacity-100 transition-opacity duration-300"
                                                    initial={{ opacity: 0 }}
                                                    whileHover={{ opacity: 1 }}
                                                >
                                                    <span className="text-xs text-slate-400 bg-slate-800/80 px-2 py-1 rounded backdrop-blur-sm">
                                                        Refresh
                                                    </span>
                                                </motion.div>
                                            </div>
                                        </motion.div>

                                    </div>
                                    ) :
                                    <div className="px-2 py-1 border shadow-lg rounded-lg bg-gradient-to-r from-blue-500/20 via-blue-600/20 to-blue-500/20 backdrop-blur-md border-blue-500/20 shadow-blue-500/10">
                                        <p className="text-xs font-medium text-transparent bg-gradient-to-r from-blue-300 to-blue-500 bg-clip-text whitespace-nowrap">
                                            No keywords
                                        </p>
                                    </div>


                                }

                            </motion.div>
                        </div>

                    </div>




                </header>

                <div className="news-grid px-20">
                    {newsData[activeTab][questionText].map(
                        (obj: Video | Article) => {
                            if (obj.type == "article") {
                                return (
                                    <div key={`article-${obj.id}`} className="bg-transparent min-h-full">
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

            </div>

            <div className={`flex items-center justify-center ${isCollapsed
                ? "max-h-[100px] opacity-100"
                : "max-h-0 opacity-0 overflow-hidden"
                }`}>

                <DotStream
                    size="110"
                    speed="3"
                    color="white"
                />
            </div>

            <div className="my-16 separator" />
        </div>
    )
}

export default React.memo(QuestionContainer, (prevProps, nextProps) => {
    return (
        prevProps.activeTab === nextProps.activeTab &&
        prevProps.index === nextProps.index &&
        prevProps.qIndex === nextProps.qIndex
    );
});

