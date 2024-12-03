import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { Separator } from "@/components/ui/separator"
import NewsArticle from "./core/newsarticle"
import NewsCarousel from "./newsCarousel"
import { Article, Favourite, Question, Topic, Video } from "@/utils/types"
import { useEffect, useState } from "react"
import { Button } from "./ui/button"
import { Heart } from "lucide-react"
import NewsFavorites from "./newsFavorites"
import NewsVideo from "./core/newsvideo"
import '@/styles/newsmain.css';
import { useGlobalState } from '@/components/context/GlobalStateContext'
import { mixArray } from "@/lib/utils"


function NewsMain({
    activeTab,
    setActiveTab,
    showFavorites,
    setShowFavorites,
    showDelete,
    showAdd
}: {

    activeTab: string,
    setActiveTab: (tab: string) => void,
    showFavorites: boolean,
    setShowFavorites: React.Dispatch<React.SetStateAction<boolean>>,
    showDelete: React.Dispatch<React.SetStateAction<boolean>>,
    showAdd: React.Dispatch<React.SetStateAction<boolean>>
}) {

    const [isChanging, setisChanging] = useState(false)
    const [showHeader, setShowHeader] = useState(false)
    const [AtinnerHeight, setAtinnerHeight] = useState(false)

    const  {newsData,setNewsData,topics,questions,articles,videos,setVideos,favourites,setFavourites}  = useGlobalState()

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
    }, [topics ,questions ,articles ,videos])

    function onValueChange(value: string) {

        showFavorites && setShowFavorites(false)
        setisChanging(true)

        setTimeout(() => {
            setActiveTab(value)
            window.scrollTo({ top: window.innerHeight })
            setTimeout(() => {
                setisChanging(false)
            }, 200)
        }, 400)

    }

    function goUp(category: string) {
        if (category == activeTab) {
            window.scrollTo({ top: window.innerHeight, behavior: "smooth" })
        }
    }

    useEffect(() => {
        const handleScroll = () => {
            setShowHeader(window.scrollY >= window.innerHeight);
            setAtinnerHeight(window.scrollY == window.innerHeight)
        };

        window.addEventListener('scroll', handleScroll);

        return () => {
            window.removeEventListener('scroll', handleScroll);
        };
    }, []);

    return (

        <Tabs value={activeTab} onValueChange={onValueChange} className="tabs-container m-0 p-0">

            <TabsList className={`tabs-list group`}>
                {Object.keys(newsData).map((category, index) => {
                    return (
                        <div key={index} className="tab-item">
                            <TabsTrigger
                                key={category}
                                value={category}
                                onClick={() => goUp(category)}

                                className={
                                    `tab-trigger
                                    group-hover:translate-y-0
                                    ${showHeader ? "data-[state=active]:translate-y-0" : "data-[state=active]:-translate-y-20"} 
                                    ${AtinnerHeight ? "translate-y-0" : "-translate-y-20"}`
                                }>
                                <p className="2xl:text-[15px] xl:text-sm font-medium">
                                    {category}
                                </p>

                            </TabsTrigger>
                        </div>
                    )
                })}

            </TabsList>


            
            {!showFavorites && Object.keys(newsData).map((topic, index) => {
                return (
                    topic == activeTab && (
                        <div key={index} className="tabs-content-container xl:px-24 2xl:px-40">

                            <TabsContent key={topic} value={topic} className={`${isChanging ? 'opacity-0' : 'opacity-100'} tabs-content`}>

                                <Separator className="separator" />

                                <NewsCarousel
                                    topic={activeTab}
                                    questions={questions.filter((question: Question) => Object.keys(newsData[activeTab]).includes(question.text))}
                                    videos={videos}
                                />

                                <Separator className="separator" />

                                {Object.keys(newsData[activeTab]).map((question_text:string) => {
                                    var question_keywords = questions.find((qst : Question) => qst.text == question_text)?.keywords
                                    return (
                                        <div key={index}>

                                            <div className="question-header">
                                                <h1 className="question-title">
                                                    {question_text}
                                                </h1>
                                                 <p className="question-keywords">
                                                    {question_keywords}
                                                </p>
                                            </div>

                                            <div className="news-grid">
                                                {newsData[activeTab][question_text].map((obj: any, index: number) => {
                                                    if (obj["type"] == "article") return (
                                                        <div key={obj.type + obj.id}>
                                                            <NewsArticle
                                                                key={index}
                                                                article={obj}
                                                                favourites={favourites}
                                                                showFavorites={showFavorites}
                                                                setFavourites={setFavourites}
                                                                showDelete={showDelete}
                                                                showAdd={showAdd}
                                                                questions={questions}
                                                                newsData={newsData}
                                                                setNewsData={setNewsData}
                                                            />
                                                        </div>
                                                    )
                                                    else return (
                                                        <div key={obj.type + obj.id} className="video-container">
                                                            <div className="video-wrapper">
                                                                <NewsVideo
                                                                    video={obj}
                                                                    videos={videos}
                                                                    setVideos={setVideos}
                                                                    favourites={favourites}
                                                                    setFavourites={setFavourites}
                                                                    showFavorites={showFavorites}
                                                                    showDelete={showDelete}
                                                                    showAdd={showAdd}
                                                                />
                                                            </div>
                                                        </div>

                                                    )

                                                }
                                                )}

                                            </div>

                                            <Separator className="separator" />
                                        </div>
                                    )
                                }
                                )}

                            </TabsContent>

                        </div>
                    )

                )
            })}

            {showFavorites && (
                <NewsFavorites
                    showFavorites={showFavorites}
                    showDelete={showDelete}
                    showAdd={showAdd}
                />
            )}

            <div className={`button-container xl:right-2 2xl:right-12  ${showHeader ? 'translate-y-0' : 'translate-y-full'}`}>
                <Button
                    variant="secondary"
                    className={`button ${showFavorites ? 'bg-gray-700/80' : 'bg-black/70'}`}
                    onClick={() => setShowFavorites(!showFavorites)}>
                    <div className='button-content'>
                        <Heart strokeWidth={2} style={{ width: 28, height: 28 }} />
                    </div>
                </Button>
            </div>

        </Tabs>



    )
}

export default NewsMain;