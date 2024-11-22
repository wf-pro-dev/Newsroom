import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { Separator } from "@/components/ui/separator"
import NewsArticle from "./newsarticle"
import NewsCarousel from "./newsCarousel"
import { Article, Question, Video } from "@/utils/types"
import { useEffect, useState } from "react"
import { Button } from "./ui/button"
import { Heart } from "lucide-react"
import NewsFavorites from "./newsFavorites"
import NewsVideo from "./newsvideo"


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
    setVideos:React.Dispatch<React.SetStateAction<Video[]>>,
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
            
            if (arr2[j] && ((i > 0 && i % chunkSize == 0 ) || i >= arr.length)) { arr2[j]["type"] = "video";result.push(arr2[j]); j++ }
            if (arr[i]) { arr[i]["type"] = "article";result.push(arr[i]); }
       
            
        }
        return result;
    }    


    return (

        <Tabs value={activeTab} onValueChange={onValueChange} className="relative w-screen">
            <TabsList className={`group fixed opacity-${showHeader ? '1' : '0'} h-fit py-4 px-0 top-0 left-0 right-0 grid grid-cols-2 lg:grid-cols-5 bg-transparent z-50 transition-all duration-300 ease-in-out`}>
                {Object.keys(newsData).map((category) => {
                   
                    return (
                        <div className="flex flex-1 justify-center">
                            <TabsTrigger
                                key={category}
                                value={category}
                                onClick={() => goUp(category)}
                                className={`w-fit py-3 px-5 rounded-full text-white/60 text-sm hover:animate-bounce-subtle hover:text-white hover:bg-gray-700/80 group-hover:translate-y-0 2xl:font-medium transition-all duration-300 ease-in-out 
                                    ${AtinnerHeight ? 'translate-y-0' : '-translate-y-20'} 
                                    data-[state=active]:translate-y-0 data-[state=active]:bg-black/70 backdrop-blur-sm bg-black/70 data-[state=active]:text-white data-[state=active]:border-[1.5px]`}
                            >
                                {category}
                            </TabsTrigger>
                        </div>
                    )
                })}

            </TabsList>

            {!showFavorites && Object.keys(newsData).map((topic) => {
                var articles_by_topic = newsData[topic as keyof typeof newsData]
                return (

                    <div className=" xl:px-20 2xl:px-40 bg-black/[.05] backdrop-blur-sm  backdrop-contrast-125">
                        <TabsContent key={topic} value={topic} className={`${isChanging ? 'opacity-0' : 'opacity-100'} mt-0 2xl:pt-28 xl:pt-20 transition-all duration-300 ease-in-out`}>

                            <NewsCarousel
                                questions={questions.filter((question: any) => question.topic == activeTab)}
                                articles={newsData[activeTab]}
                            />

                            <Separator className="my-12 bg-gray-600" />

                            {questions.filter((question: Question) => question.topic == topic).map((question: Question,index:number) => {
                                var video_by_question = videos.filter((video: Video) => parseInt(video.question_id) == question.id)
                                var news_by_question = mixArray(articles_by_topic.filter((article: any) => article.question_id == question.id), video_by_question, 4)
                                
                                if ( question.id == 1 ) {console.log("news",video_by_question,news_by_question[4])}
                                
                                return (
                                    <div>

                                        <div className="mb-6 flex flex-col items-center justify-center text-lg">
                                            <h1 className="text-3xl leading-normal mb-2 text-center font-medium">
                                                {question.question}
                                            </h1>
                                            <p className="text-gray-400">
                                                {question.keywords.replaceAll(",", ", ")}
                                            </p>
                                        </div>

                                        <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-4">
                                            {news_by_question.map((obj: any, index: number) => {

                                                if (obj["type"] == "article") return (

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

                                                )
                                                else return (
                                                    <div key={obj.id} className="col-span-2 justify-items-center items-center">
                                                        <NewsVideo 
                                                        video={obj} 
                                                        videos={videos} 
                                                        setVideos={setVideos} 
                                                        favorites={Vfavorites} 
                                                        setVFavorites={setVFavorites}
                                                        />
                                                    </div>

                                                )

                                            }
                                            )}

                                        </div>

                                        <Separator className="my-12 bg-gray-600" />
                                    </div>
                                )
                            }
                            )}

                        </TabsContent>
                    </div>
                )
            })}

            {showFavorites && (
                <NewsFavorites
                    favorites={favorites}
                    setFavorites={setFavorites}
                    showFavorites={showFavorites}
                    showDelete={showDelete}
                    showAdd={showAdd}
                />
            )}

            <div className={`w-fit h-fit translate-y-${showHeader ? '0' : 'full'} xl:py-4 2xl:py-8 fixed bottom-0 xl:right-2 2xl:right-12 transition-all duration-300 ease-in-out`}>
                <Button
                    variant="secondary"
                    className={`p-0 w-fit h-fit rounded-full backdrop-blur-sm hover:bg-gray-700/80 ${showFavorites ? 'border-2' : ''} bg-${showFavorites ? 'transparent' : 'gray-700/50'} text-gray-300 transition-all duration-300 ease-in-out hover:animate-bounce-subtle`}
                    onClick={() => setShowFavorites(!showFavorites)}>
                    <div className='p-4 flex justify-center items-center'>
                        <Heart strokeWidth={2} style={{ width: 28, height: 28 }} />
                    </div>
                </Button>
            </div>

        </Tabs>



    )
}

export default NewsMain;