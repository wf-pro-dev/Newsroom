'use client'

import { useState } from 'react'
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card"
import Image from 'next/image'
import { Button } from "@/components/ui/button"
import { X, Heart, HeartOff, ArrowRight, CalendarDays } from 'lucide-react'
import { Article, Favourite, Video } from '@/utils/types'
import { addFavourite, deleteFavouritebyId, hideContent } from '@/utils/api'
import moment from 'moment'
import { Separator } from '@radix-ui/react-separator'
import { useGlobalState } from '@/components/context/GlobalStateContext'
import { mixArray } from '@/lib/utils'

function NewsArticle({ article, showFavorites, showDelete, showAdd }:
    {
        article: Article,
        showFavorites: boolean,
        showDelete: React.Dispatch<React.SetStateAction<boolean>>,
        showAdd: React.Dispatch<React.SetStateAction<boolean>>,
    }) {

    const [isDeleting, setIsDeleting] = useState(false);
    const article_date = new Date(article.publishedAt)
    const { articles, setArticles, favourites, setFavourites } = useGlobalState()

    const favorite = favourites.find((fav) => fav.type == "article" && fav.article_id == article.id) ||
        favourites.find((fav: Favourite) => fav == article)

    async function handleFavorite() {
        try {

            if (favorite) {

                if (showFavorites) setIsDeleting(true);

                // Optimistically update UI
                setTimeout(() => {
                    setFavourites(favourites.filter((fav: Favourite) => fav.id != favorite.id));
                }, 300)

                showDelete(true);
                await deleteFavouritebyId(favorite.id, favorite.type);

            } else {

                showAdd(true);

                const newFavorite = await addFavourite(article.id, article.type);

                let newFavourites : (Article | Video)[] = [...favourites, newFavorite]

                const articlesFavorites = newFavourites.filter((fav: (Article | Video)) => fav.type === "article") as Article[]
                const videosFavorites = newFavourites.filter((fav: (Article | Video)) => fav.type === "video") as Video[]

                newFavourites = mixArray(
                   articlesFavorites , videosFavorites, 4
                )
                // Optimistically update UI
                setFavourites(newFavourites as Favourite[]);
            }
        } catch (error) {
            console.error("Error handling favorite:", error);
        }
    }

    async function handleDelete() {
        // Optimistically update UI
        setIsDeleting(true);

        setTimeout(() => {
            setArticles(articles.filter((art) => art.id != article.id));
        }, 300);

        try {
            await hideContent(article.id, "article");
            showDelete(true);

        } catch (error) {
            console.error("Error deleting article:", error);
            // Revert optimistic update if necessary
            // Fetch the latest data or handle the error state
            setIsDeleting(false);
        }
    }

    return (
        <Card className={`article-card group bg-gray-800/50 ${isDeleting ? 'opacity-0 scale-95' : 'opacity-100 scale-100'} `}>

            <div className='relative'>
                {article.urlToImage && (
                    <Image
                        src={article.urlToImage}
                        alt={`Illustration for ${article.urlToImage}`}
                        width={300}
                        height={200}
                        className="object-cover w-full h-48 rounded-t-lg"
                        priority={true}
                    />
                )}
                <div className="absolute flex flex-row justify-between bottom-4 left-6 right-6 ">
                    <div className='flex items-center p-2 rounded w-fit bg-gray-700/60 backdrop-blur-sm'>
                        <CalendarDays style={{ width: 18, height: 18 }} strokeWidth={1} color='white' />
                        <Separator orientation="vertical" className='mx-1 w-[1px] h-[12px] bg-gray-300' />
                        <p className='text-white xl:text-xs 2xl:text-sm'>{moment(article_date).format("DD MMMM YY")}</p>
                    </div>

                    <div className='flex items-center p-2 rounded w-fit bg-gray-700/60 backdrop-blur-sm'>
                        <p className='text-white xl:text-xs 2xl:text-sm'>{article.score}</p>
                    </div>

                    <div className='flex items-center p-2 rounded w-fit bg-gray-700/60 backdrop-blur-sm'>
                        <p className='text-white xl:text-xs 2xl:text-sm'>{article.api_source}</p>
                    </div>
                </div>
            </div>

            <CardHeader className="overflow-hidden">
                <div className="absolute flex justify-between top-4 left-6 right-6">
                    <Button
                        variant="secondary"
                        className="p-0 text-gray-300 transition-all duration-300 ease-in-out h-fit bg-gray-700/60 backdrop-blur-sm hover:bg-gray-700/80 hover:animate-bounce-subtle"
                        onClick={handleFavorite}>
                        <div className='flex items-center justify-center p-2'>
                            {favourites.length > 0 && favorite ?
                                <HeartOff style={{ width: 18, height: 18 }} strokeWidth={2} />
                                :
                                <Heart style={{ width: 18, height: 18 }} strokeWidth={2} />
                            }
                        </div>
                    </Button>

                    {!showFavorites && (
                        <Button
                            variant="secondary"
                            className="p-0 text-gray-300 transition-all duration-300 ease-in-out h-fit bg-gray-700/60 backdrop-blur-sm hover:bg-gray-700/80 hover:animate-bounce-subtle"
                            onClick={handleDelete}>
                            <div className='flex items-center justify-center p-2'>
                                <X style={{ width: 18, height: 18 }} strokeWidth={2} />
                            </div>
                        </Button>
                    )}
                </div>

                <div className="overflow-hidden">
                    <CardTitle className="inline-block font-medium text-gray-100 whitespace-nowrap group-hover:animate-marquee">
                        {article.title}
                    </CardTitle>
                </div>
            </CardHeader>

            <CardContent>
                <CardDescription className="text-gray-300 line-clamp-2">{article.description}</CardDescription>
            </CardContent>

            <CardFooter>
                <Button
                    variant="secondary"
                    className={`button rounded-lg`}
                    onClick={() => window.open(article.url)}
                >
                    <div className='space-x-1.5 button-content'>
                        <p className='font-medium'>Read More</p>
                        <ArrowRight strokeWidth={2} size={5} />
                    </div>

                </Button>
            </CardFooter>
        </Card>
    )
}

export default NewsArticle;