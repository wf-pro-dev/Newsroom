'use client'

import { useState, useCallback } from 'react'
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card"
import Image from 'next/image'
import { Button } from "@/components/ui/button"
import { X, Heart, HeartOff, ArrowRight, CalendarDays} from 'lucide-react'
import { Article, Question } from '@/utils/types'
import { addFavorite, deleteNewsbyId, removeFavorite } from '@/utils/api'
import moment from 'moment'

function NewsArticle({ article, favorites, showFavorites, setFavorites, showDelete, showAdd, questions, newsData, setNewsData }:
    {
        article: Article,
        favorites: Article[],
        showFavorites: boolean,
        setFavorites: React.Dispatch<React.SetStateAction<Article[]>>,
        showDelete: React.Dispatch<React.SetStateAction<boolean>>,
        showAdd: React.Dispatch<React.SetStateAction<boolean>>,
        questions?: Question[],
        newsData?: any,
        setNewsData?: React.Dispatch<React.SetStateAction<any>>
    }) {

    const [isDeleting, setIsDeleting] = useState(false);
    const [article_date, setdate] = useState(new Date(article.publishedAt))

    async function handleFavorite() {

        if (favorites.some((fav: Article) => fav.title === article.title)) {

            

            await removeFavorite(article.id)
                .then(() => {
                    showDelete(true)
                    showFavorites && setIsDeleting(true)

                    setTimeout(() => {
                        setFavorites(favorites.filter((fav: Article) => fav.title !== article.title))
                        showFavorites && setIsDeleting(false)
                    }, 400)

                })
        } else {
            await addFavorite(article)
                .then(() => {
                    setFavorites([...favorites, article])

                    showAdd(true)
                })
        }
    }

    async function handleDelete() {
        const topic: string = questions!.find((question: Question) => question.id == article.question_id)!.topic
        await deleteNewsbyId(article.id, topic)
            .then(() => {
                showDelete(true)
                setIsDeleting(true)

                setTimeout(() => {
                    showDelete(false)
                }, 2000)

                setTimeout(() => {
                    setNewsData!(() => ({
                        ...newsData,
                        [topic]: newsData[topic].filter((art: Article) => art.id !== article.id)
                    }));
                    setIsDeleting(false)
                }, 400)

            })
    }


    return (
        <Card className={`h-fit group overflow-hidden bg-gray-800/80 border-gray-700 hover:bg-gray-700/80 transition-colors backdrop-blur-sm ${isDeleting ? 'opacity-0 scale-95' : 'opacity-100 scale-100'} transition-all duration-300 ease-in-out`}>
            <div className='relative'>
                {article.urlToImage && (
                    <Image
                        src={article.urlToImage}
                        alt={`Illustration for ${article.title}`}
                        width={300}
                        height={200}
                        className="w-full h-48 object-cover"
                        priority={true}
                    />
                )}
                <div className="absolute bottom-4 left-6 ">
                    <div className='p-2 w-fit flex items-center bg-gray-700/60 backdrop-blur-sm rounded'>
                        <CalendarDays strokeWidth={2} size={16} className='mr-1' color='white'/>
                        <p className='text-white text-xs'>{moment(article_date).format("DD MMMM YY")}</p>
                    </div>
                </div>
            </div>

            <CardHeader className="overflow-hidden">

                <div className="absolute top-4 left-6 right-6 flex justify-between">


                    <Button
                        variant="secondary"
                        className="p-0 h-fit bg-gray-700/60 backdrop-blur-sm hover:bg-gray-700/80 text-gray-300 transition-all duration-300 ease-in-out hover:animate-bounce-subtle"
                        onClick={handleFavorite}>
                        <div className='p-2 flex justify-center items-center'>
                            {favorites.length > 0 && favorites.some((fav: Article) => fav.title === article.title) ? <HeartOff strokeWidth={3} size={18}  /> : <Heart  strokeWidth={3} size={18} />}
                        </div>

                    </Button>



                    {!showFavorites && (
                        <Button
                            variant="secondary"
                            className="p-0 h-fit bg-gray-700/60 backdrop-blur-sm hover:bg-gray-700/80 text-gray-300 transition-all duration-300 ease-in-out hover:animate-bounce-subtle"
                            onClick={handleDelete}>
                            <div className='p-2 flex justify-center items-center'>
                                <X strokeWidth={3} size={18} />
                            </div>
                        </Button>
                    )}
                </div>

                <div className="overflow-hidden">
                    <CardTitle className="text-gray-100 whitespace-nowrap group-hover:animate-marquee inline-block">
                        {article.title}
                    </CardTitle>
                </div>
            </CardHeader>

            <CardContent>
                <CardDescription className="line-clamp-2 text-gray-300">{article.description}</CardDescription>
            </CardContent>

            <CardFooter>
                <Button
                    variant="outline"
                    className="hover:text-primary hover:scale-95 active:scale-90 font-medium bg-gray-800/50 text-gray-300  transition-all ease-in-out"
                    onClick={() => open(article.url)}
                >
                    <p className='font-semibold'>Read More</p>
                    <ArrowRight strokeWidth={2} size={5} />
                </Button>
            </CardFooter>
        </Card>
    )
}

export default NewsArticle;

