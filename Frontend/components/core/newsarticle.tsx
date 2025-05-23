'use client'

import { useState } from 'react'
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card"
import Image from 'next/image'
import { Button } from "@/components/ui/button"
import { X, Heart, HeartOff, ArrowRight, CalendarDays } from 'lucide-react'
import { Article, Favourite } from '@/utils/types'
import { addFavourite, deleteFavouritebyId, hideContent } from '@/utils/api'
import moment from 'moment'
import { Separator } from '@radix-ui/react-separator'
import { useGlobalState } from '@/components/context/GlobalStateContext'

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

    const favorite = favourites.find((fav) =>  fav.type == "article" && fav.article_id == article.id  ) ||
        favourites.find((fav: Favourite) => fav == article )
    
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

                const newFavorite  = await addFavourite(article.id, article.type) ;
                

                // Optimistically update UI
                setFavourites([...favourites, newFavorite]);
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
        <Card className={`h-fit group overflow-hidden bg-gray-800/80 border-gray-700 hover:bg-gray-700/80 transition-colors backdrop-blur-sm ${isDeleting ? 'opacity-0 scale-95' : 'opacity-100 scale-100'} transition-all duration-300 ease-in-out`}>
            <div className='relative'>
                {article.urlToImage && (
                    <Image
                        src={article.urlToImage}
                        alt={`Illustration for ${article.urlToImage}`}
                        width={300}
                        height={200}
                        className="w-full h-48 object-cover"
                        priority={true}
                    />
                )}
                <div className="absolute bottom-4 left-6 ">
                    <div className='p-2 w-fit flex items-center bg-gray-700/60 backdrop-blur-sm rounded'>
                        <CalendarDays style={{ width: 18, height: 18 }} strokeWidth={1} color='white' />
                        <Separator orientation="vertical" className='mx-1 w-[1px] h-[12px] bg-gray-300' />
                        <p className='text-white xl:text-xs 2xl:text-sm'>{moment(article_date).format("DD MMMM YY")}</p>
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
                            {favourites.length > 0 &&  favorite ?
                                <HeartOff style={{ width: 18, height: 18 }} strokeWidth={2} />
                                :
                                <Heart style={{ width: 18, height: 18 }} strokeWidth={2} />
                            }
                        </div>
                    </Button>

                    {!showFavorites && (
                        <Button
                            variant="secondary"
                            className="p-0 h-fit bg-gray-700/60 backdrop-blur-sm hover:bg-gray-700/80 text-gray-300 transition-all duration-300 ease-in-out hover:animate-bounce-subtle"
                            onClick={handleDelete}>
                            <div className='p-2 flex justify-center items-center'>
                                <X style={{ width: 18, height: 18 }} strokeWidth={2} />
                            </div>
                        </Button>
                    )}
                </div>

                <div className="overflow-hidden">
                    <CardTitle className="text-gray-100 font-medium whitespace-nowrap group-hover:animate-marquee inline-block">
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
                    onClick={() => window.open(article.url)}
                >
                    <p className='font-semibold'>Read More</p>
                    <ArrowRight strokeWidth={2} size={5} />
                </Button>
            </CardFooter>
        </Card>
    )
}

export default NewsArticle;