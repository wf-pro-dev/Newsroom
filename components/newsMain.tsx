import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { Separator } from "@/components/ui/separator"
import NewsArticle from "./newsarticle"
import NewsCarousel from "./newsCarousel"
import { Article, HandleNotification, Question } from "@/utils/types"
import { useState } from "react"


function NewsMain({ newsData, setNewsData, activeTab, setActiveTab, favorites, setFavorites, showFavorites, questions, showDelete, showAdd }:

    {
        newsData: Record<string, Article[]>,
        setNewsData: React.Dispatch<React.SetStateAction<Record<string, Article[]>>>,
        activeTab: string,
        setActiveTab: (tab: string) => void,
        favorites: Article[],
        setFavorites: React.Dispatch<React.SetStateAction<Article[]>>,
        showFavorites: boolean,
        questions: Question[],
        showDelete: React.Dispatch<React.SetStateAction<boolean>>,
        showAdd: React.Dispatch<React.SetStateAction<boolean>>
    }) {

    const [isChanging, setisChanging] = useState(false)

    function onValueChange(value: string) {

        setisChanging(true)

        setTimeout(() => {
            setActiveTab(value)
            setTimeout(() => {
                setisChanging(false)
            }, 200)
        }, 400)

    }

    return (


        <Tabs value={activeTab} onValueChange={onValueChange} className="relative w-screen">
            <TabsList className="fixed top-0 left-0 right-0 mx-4 mb-10 grid w-[calc(100%-2rem)] grid-cols-2 lg:grid-cols-5 bg-gray-800/50 z-50">
                {Object.keys(newsData).map((category) => (
                    <TabsTrigger
                        key={category}
                        value={category}
                        className="text-sm md:text-base hover:text-gray-300 data-[state=active]:bg-gray-700/50 data-[state=active]:text-white"
                    >
                        {category.replace("_", " ")}
                    </TabsTrigger>
                ))}
            </TabsList>

            {Object.keys(newsData).map((topic) => {
                var articles_by_topic = newsData[topic as keyof typeof newsData]
                return (
                    
                    <div className="xl:px-20  bg-black/10 backdrop-blur-sm  backdrop-contrast-125">
                        <TabsContent key={topic} value={topic} className={`${isChanging ? 'opacity-0' : 'opacity-100'} xl:pt-16 transition-all duration-300 ease-in-out`}>

                            <NewsCarousel
                                questions={questions.filter((question: any) => question.topic == activeTab)}
                                articles={newsData[activeTab]}
                            />

                            <Separator className="my-12 bg-gray-600" />

                            {questions.filter((question: any) => question.topic == topic).map((question: any) => (
                                <div>
                                    <div className="mb-8 flex flex-col items-center justify-center text-lg text-gray-300">
                                        <h1 className="text-4xl leading-normal mb-4 text-center font-bold  text-gray-300">
                                            {question.question}
                                        </h1>
                                        <p className="text-gray-400 md:text-xl">
                                            {question.keywords.replaceAll(",", ", ")}
                                        </p>
                                    </div>
                                    <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-4">
                                        {articles_by_topic.filter((article: any) => article.question_id == question.id).map((article: any, index: number) => (
                                            <NewsArticle
                                                key={index}
                                                article={article}
                                                favorites={favorites}
                                                showFavorites={showFavorites}
                                                setFavorites={setFavorites}
                                                showDelete={showDelete}
                                                showAdd={showAdd}
                                                questions={questions}
                                                newsData={newsData}
                                                setNewsData={setNewsData}
                                            />
                                        ))}
                                    </div>

                                    <Separator className="my-12 bg-gray-600" />
                                </div>
                            )
                            )}

                        </TabsContent>
                    </div>
                )
            })}

        </Tabs>



    )
}

export default NewsMain;