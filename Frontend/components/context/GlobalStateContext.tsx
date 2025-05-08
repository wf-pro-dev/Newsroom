'use client'
// components/context/GlobalStateContext.tsx
import React, { createContext, useContext, useState, ReactNode, useEffect } from 'react';
import { User, Article, Question, Favourite, Topic, Video } from '@/utils/types';
import { fetchAllData, fetchArticles, fetchCsrfToken, fetchFavorites, fetchQuestions, fetchUser, fetchVideos } from '@/utils/api';
import { mixArray } from '@/lib/utils';

interface GlobalState {
    csrftoken: string | null;
    setCSRFtoken: React.Dispatch<React.SetStateAction<string | null>>;
    user: User | null;
    setUser: React.Dispatch<React.SetStateAction<User | null>>;
    isLoadingUser: boolean;
    setIsLoadingUser: React.Dispatch<React.SetStateAction<boolean>>;
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

    const [csrftoken, setCSRFtoken] = useState<string | null>(null)
    const [user, setUser] = useState<User | null>(null)
    const [topics, setTopics] = useState<Topic[]>([]);
    const [questions, setQuestions] = useState<Question[]>([]);
    const [articles, setArticles] = useState<Article[]>([]);
    const [videos, setVideos] = useState<Video[]>([]);
    const [favourites, setFavourites] = useState<Favourite[]>([]);
    const [newsData, setNewsData] = useState<Record<string, Record<string, Array<Video | Article>>>>({});
    const [ isLoadingUser, setIsLoadingUser] = useState(true);

    useEffect(() => {
        const fetchInitialData = async () => {
            
            
            const [AllData] = await Promise.all([
                fetchAllData(),
            ])
            
            setIsLoadingUser(true) 
            fetchUser()
                .then((user) => setUser(user || null))
                .finally(()=>  setIsLoadingUser(false))
                
            setTopics(AllData["topics"])

            fetchCsrfToken().then((token) => setCSRFtoken(token || null))

        }

        fetchInitialData()

    }, [])

    useEffect(() => {
        if (user) {

            fetchQuestions()
                .then((questions)=> setQuestions(questions))
                .catch((error) => console.log(error) )
            
            fetchArticles()
                .then((articles) => setArticles(articles))
                .catch((error) => console.log(error))

            fetchVideos()
                .then((videos) => setVideos(videos))
                .catch((error) => console.log(error))

            fetchFavorites()
                .then((favourites)=> setFavourites(favourites))
                .catch((error) => console.log(error) )
            
        }

    }, [user])


    useEffect(() => {
        if (!user || !questions || !articles || !videos ) return

       
 
        const data: Record<string, Record<string, Array<Video | Article>>> = {}


        topics.forEach((topic: Topic) => {
            // Initialize the topic title as an object if it doesn't exist
            if (!data[topic.title]) {
                data[topic.title] = {}
            }

            questions
                .filter((question: Question) => question.topic_id == topic.id)
                .forEach((qst: Question) => {
                    
                    data[topic.title][qst.text] = mixArray(articles.filter((article) => article.question_id == qst.id), videos.filter((video) => video.question_id == qst.id), 4)
                })
        })

        setNewsData(data)
    }, [user, topics, questions, articles, videos ])

    if (isLoadingUser) return null;

    return (
        <GlobalStateContext.Provider 
            value={{ 
                csrftoken, setCSRFtoken,
                user, setUser,
                isLoadingUser ,setIsLoadingUser,
                topics, setTopics,
                questions, setQuestions,
                articles, setArticles,
                videos, setVideos,
                favourites, setFavourites,
                newsData, setNewsData 
            }}
        >
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
