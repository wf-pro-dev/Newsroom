import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { Separator } from "@/components/ui/separator"
import NewsArticle from "./core/newsarticle"
import NewsCarousel from "./newsCarousel"
import { Article, Question, Video } from "@/utils/types"
import { useEffect, useState } from "react"
import { Button } from "./ui/button"
import { Heart } from "lucide-react"
import NewsFavorites from "./newsFavorites"
import NewsVideo from "./core/newsvideo"
import '@/styles/newsmain.css';


function NewsMain({
    newsData,
    setNewsData,
    activeTab,
    setActiveTab,
    Afavorites,
    setAFavorites,
    Vfavorites,
    setVFavorites,
    showFavorites,
    setShowFavorites,
    questions,
    videos,
    setVideos,
    showDelete,
    showAdd
}: {
    newsData: Record<string, Article[]>,
    setNewsData: React.Dispatch<React.SetStateAction<Record<string, Article[]>>>,
    activeTab: string,
    setActiveTab: (tab: string) => void,
    Afavorites: Article[],
    setAFavorites: React.Dispatch<React.SetStateAction<Article[]>>,
    Vfavorites: Video[],
    setVFavorites: React.Dispatch<React.SetStateAction<Video[]>>,
    showFavorites: boolean,
    setShowFavorites: React.Dispatch<React.SetStateAction<boolean>>,
    questions: Question[],
    videos: Video[],
    setVideos: React.Dispatch<React.SetStateAction<Video[]>>,
    showDelete: React.Dispatch<React.SetStateAction<boolean>>,
    showAdd: React.Dispatch<React.SetStateAction<boolean>>
}) {

    const [isChanging, setisChanging] = useState(false)
    const [showHeader, setShowHeader] = useState(false)
    const [AtinnerHeight, setAtinnerHeight] = useState(false)

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

    function mixArray(arr: Array<any>, arr2: Array<any>, chunkSize: number) {
        const result = [];
        let j = 0;
        for (let i = 0; i < arr.length || j < arr2.length; i++) {

            if (arr2[j] && ((i > 0 && i % chunkSize == 0) || i >= arr.length)) { arr2[j]["type"] = "video"; result.push(arr2[j]); j++ }
            if (arr[i]) { arr[i]["type"] = "article"; result.push(arr[i]); }


        }
        return result;
    }


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
                                <p className="text-[15px]">
                                    {category}
                                </p>

                            </TabsTrigger>
                        </div>
                    )
                })}

            </TabsList>



            {!showFavorites && Object.keys(newsData).map((topic, index) => {
                var articles_by_topic = newsData[topic as keyof typeof newsData]
                console.log(Object.keys(newsData)[index], activeTab )
                return (
                    Object.keys(newsData)[index] == activeTab && (
                        <div key={index} className="tabs-content-container xl:px-24 2xl:px-40">

                            <TabsContent key={topic} value={topic} className={`${isChanging ? 'opacity-0' : 'opacity-100'} tabs-content`}>

                                <Separator className="separator" />

                                <NewsCarousel
                                    questions={questions.filter((question: any) => question.topic == activeTab)}
                                    articles={newsData[activeTab]}
                                />

                                <Separator className="separator" />

                                {questions.filter((question: Question) => question.topic == topic).map((question: Question, index: number) => {
                                    var video_by_question = videos.filter((video: Video) => parseInt(video.question_id) == question.id)
                                    var news_by_question = mixArray(articles_by_topic.filter((article: any) => article.question_id == question.id), video_by_question, 4)
                                    return (
                                        <div key={index}>

                                            <div className="question-header">
                                                <h1 className="question-title">
                                                    {question.text}
                                                </h1>
                                                {/* <p className="question-keywords">
                                                    {question.keywords.replaceAll(",", ", ")}
                                                </p> */}
                                            </div>

                                            <div className="news-grid">
                                                {news_by_question.map((obj: any, index: number) => {
                                                    if (obj["type"] == "article") return (
                                                        <div key={obj.type + obj.id}>
                                                            <NewsArticle
                                                                key={index}
                                                                article={obj}
                                                                favorites={Afavorites}
                                                                showFavorites={showFavorites}
                                                                setFavorites={setAFavorites}
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
                                                                    favorites={Vfavorites}
                                                                    setFavorites={setVFavorites}
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
                    Afavorites={Afavorites}
                    Vfavorites={Vfavorites}
                    setAFavorites={setAFavorites}
                    setVFavorites={setVFavorites}
                    videos={videos}
                    setVideos={setVideos}
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