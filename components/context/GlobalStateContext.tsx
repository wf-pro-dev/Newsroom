'use client'
// components/context/GlobalStateContext.tsx
import React, { createContext, useContext, useState, ReactNode, useEffect } from 'react';
import { Article, Question, Favourite, Topic, Video } from '@/utils/types';
import { fetchAllData } from '@/utils/api';
import { mixArray } from '@/lib/utils';

interface GlobalState {
    topics: Topic[];
    setTopics: React.Dispatch<React.SetStateAction<Topic[]>>;
    questions: Question[];
    setQuestions: React.Dispatch<React.SetStateAction<Question[]>>;
    articles: Article[];
    setArticles: React.Dispatch<React.SetStateAction<Article[]>>;
    videos: Video[];
    setVideos: React.Dispatch<React.SetStateAction<Video[]>>;
    favourites: Favourite[];
    setFavourites: React.Dispatch<React.SetStateAction<Favourite[]>>;
    newsData: Record<string, Record<string, Array<Video | Article>>>;
    setNewsData: React.Dispatch<Record<string, Record<string, (Article | Video)[]>>>
}

const GlobalStateContext = createContext<GlobalState | undefined>(undefined);

export const GlobalStateProvider = ({ children }: { children: ReactNode }) => {


    const [topics, setTopics] = useState<Topic[]>([]);
    const [questions, setQuestions] = useState<Question[]>([]);
    const [articles, setArticles] = useState<Article[]>([]);
    const [videos, setVideos] = useState<any[]>([]);
    const [favourites, setFavourites] = useState<Favourite[]>([]);
    const [newsData, setNewsData] = useState<Record<string, Record<string, Array<Video | Article>>>>({});

    useEffect(() => {
        const fetchInitialData = async () => {
            const [AllData] = await Promise.all([
                fetchAllData()
            ])
            

            setTopics(AllData["topics"])
            setQuestions(AllData["questions"])
            setArticles(AllData["articles"])
            setVideos(AllData["videos"])
            setFavourites(AllData["favourites"])
        }

        fetchInitialData()

    }, [])


    useEffect(() => {
        const data: Record<string, Record<string, Array<Video | Article>>> = {}
        
        
        topics.forEach((topic: Topic) => {
            // Initialize the topic title as an object if it doesn't exist
            if (!data[topic.title]) {
                data[topic.title] = {}
            }

            questions
                .filter((question: Question) => question.topic_id == topic.id)
                .forEach((qst: Question) => {
                    // Now you can safely set the property
                    data[topic.title][qst.text] = mixArray(articles.filter((article) => article.question_id == qst.id), videos.filter((video) => video.question_id == qst.id), 4)
                })
        })

        setNewsData(data)
    }, [])

    return (
        <GlobalStateContext.Provider value={{ topics, setTopics, questions, setQuestions, articles, setArticles, videos, setVideos, favourites, setFavourites, newsData, setNewsData }}>
            {children}
        </GlobalStateContext.Provider>
    );
};

export const useGlobalState = () => {
    const context = useContext(GlobalStateContext);
    if (!context) {
        throw new Error('useGlobalState must be used within a GlobalStateProvider');
    }
    return context;
};