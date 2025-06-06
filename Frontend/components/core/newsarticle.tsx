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
import { useGlobalState } from '@/src/contexts/GlobalStateContext'
import { mixArray } from '@/lib/utils'
import { motion } from 'framer-motion'
import '@/styles/newsmain.css'

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

                let newFavourites: (Article | Video)[] = [...favourites, newFavorite]

                const articlesFavorites = newFavourites.filter((fav: (Article | Video)) => fav.type === "article") as Article[]
                const videosFavorites = newFavourites.filter((fav: (Article | Video)) => fav.type === "video") as Video[]

                newFavourites = mixArray(
                    articlesFavorites, videosFavorites, 4
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
        <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: isDeleting ? 0 : 1, y: 0, scale: isDeleting ? 0.95 : 1 }}
            transition={{ duration: 0.3 }}
            whileHover={{ y: -8, scale: 1.02, transition: { duration: 0.01, ease: "easeInOut" } }}
            className="group"
        >
            <Card className="relative h-full overflow-hidden transition-all duration-500 border-2 shadow-2xl bg-gray-800/30 backdrop-blur-xl border-slate-600/30 rounded-2xl hover:shadow-blue-500/30 group-hover:border-blue-400/50 group-hover:bg-gray-700/40">
                {/* Enhanced holographic effects */}

                <div className="absolute inset-0 transition-opacity duration-500 opacity-0 bg-gradient-to-br from-blue-400/10 via-cyan-400/5 to-purple-400/10 rounded-2xl group-hover:opacity-100" />
                <div className="absolute inset-0 bg-gradient-to-t from-blue-500/10 via-transparent to-white/5 rounded-2xl" />
                
                <CardHeader className='relative z-10 p-6'>

                    <div className='relative z-10'>
                        {article.urlToImage && (
                            <div className="relative overflow-hidden rounded-2xl">
                                <Image
                                    src={article.urlToImage}
                                    alt={`Illustration for ${article.urlToImage}`}
                                    width={300}
                                    height={200}
                                    className="object-cover w-full h-48 transition-transform duration-700 group-hover:scale-105"
                                    priority={true}
                                />
                                {/* Enhanced image overlay */}
                                <div className="absolute inset-0 bg-gradient-to-t from-black/40 via-transparent to-transparent" />
                                <div className="absolute inset-0 bg-gradient-to-br from-blue-500/10 via-transparent to-cyan-500/10" />
                            </div>
                        )}

                        {/* Enhanced overlay tags */}
                        <div className="absolute flex flex-row justify-between top-2 left-2 right-2">
                            <motion.div
                                className='p-2 rounded-lg bg-slate-800/60 backdrop-blur-md border border-slate-600/40'
                                whileHover={{ scale: 1.05 }}
                                transition={{ duration: 0.2 }}
                            >
                                <div className='flex flex-row items-center'>
                                    <CalendarDays style={{ width: 18, height: 18 }} strokeWidth={1.5} className="text-blue-300" />
                                    <Separator orientation="vertical" className='mx-2 w-[1px] h-[12px] bg-slate-400/60' />
                                    <p className='text-slate-200 xl:text-xs 2xl:text-sm font-medium'>{moment(article_date).format("DD MMMM YY")}</p>
                                </div>
                            </motion.div>

                           

                            <motion.div
                                className='p-2 rounded-lg bg-slate-800/60 backdrop-blur-md border border-slate-600/40'
                                whileHover={{ scale: 1.05 }}
                                transition={{ duration: 0.2 }}
                            >
                                <p className='text-blue-300 xl:text-xs 2xl:text-sm font-medium'>{article.api_source}</p>
                            </motion.div>
                        </div>

                        <div className="absolute flex flex-row justify-between bottom-2 left-2 right-2">
                           

                            <motion.div
                                className='p-2 rounded-lg bg-slate-800/60 backdrop-blur-md border border-slate-600/40'
                                whileHover={{ scale: 1.05 }}
                                transition={{ duration: 0.2 }}
                            >
                                <p className='text-cyan-300 xl:text-xs 2xl:text-sm font-semibold'>{article.score}</p>
                            </motion.div>

                           
                        </div>

                    </div>

                    




                </CardHeader>

                <CardContent className="relative z-10 space-y-2 h-">
                    <div className="overflow-hidden">
                        <CardTitle className="inline-block font-semibold text-slate-100 whitespace-nowrap group-hover:animate-marquee text-lg leading-tight">
                            {article.title}
                        </CardTitle>
                    </div>
                    <CardDescription className="text-xs text-slate-300 line-clamp-3 leading-relaxed">
                        {article.description}
                    </CardDescription>
                </CardContent>

                <CardFooter className="relative z-10">
                    <div className="relatrive overflow-hidden">
                        {/* Enhanced action buttons */}
                        <div className="flex flex-row space-x-2 z-20">
                            <motion.div
                                whileHover={{ scale: 1.1 }}
                                whileTap={{ scale: 0.95 }}
                            >
                                <Button
                                    variant="secondary"
                                    className="p-3 bg-slate-800/60 backdrop-blur-md border border-slate-600/40 rounded-xl hover:bg-gradient-to-r hover:from-blue-500/30 hover:via-cyan-400/20 hover:to-blue-500/30 hover:border-blue-400/60 hover:shadow-lg hover:shadow-blue-500/40 transition-all duration-300"
                                    onClick={handleFavorite}>
                                    <div className='flex items-center justify-center'>
                                        {favourites.length > 0 && favorite ?
                                            <HeartOff style={{ width: 18, height: 18 }} strokeWidth={2} className="text-red-400" />
                                            :
                                            <Heart style={{ width: 18, height: 18 }} strokeWidth={2} className="text-slate-300 hover:text-red-400 transition-colors duration-200" />
                                        }
                                    </div>
                                </Button>
                            </motion.div>

                            {!showFavorites && (
                                <motion.div
                                    whileHover={{ scale: 1.1 }}
                                    whileTap={{ scale: 0.95 }}
                                >
                                    <Button
                                        variant="secondary"
                                        className="p-3 bg-slate-800/60 backdrop-blur-md border border-slate-600/40 rounded-xl hover:bg-gradient-to-r hover:from-red-500/30 hover:via-red-400/20 hover:to-red-500/30 hover:border-red-400/60 hover:shadow-lg hover:shadow-red-500/40 transition-all duration-300"
                                        onClick={handleDelete}>
                                        <div className='flex items-center justify-center'>
                                            <X style={{ width: 18, height: 18 }} strokeWidth={2} className="text-slate-300 hover:text-red-400 transition-colors duration-200" />
                                        </div>
                                    </Button>
                                </motion.div>
                            )}

                            <motion.div
                                whileHover={{ scale: 1.05 }}
                                whileTap={{ scale: 0.98 }}
                                className="w-full"
                            >
                                <Button
                                    variant="secondary"
                                    className="w-full p-4 bg-gradient-to-r from-blue-500/20 via-cyan-400/20 to-blue-500/20 backdrop-blur-md border border-blue-500/40 rounded-xl hover:from-blue-500/30 hover:via-cyan-400/30 hover:to-blue-500/30 hover:border-cyan-400/60 hover:shadow-lg hover:shadow-blue-500/40 transition-all duration-300 text-slate-200 hover:text-white"
                                    onClick={() => window.open(article.url)}
                                >
                                    <div className='flex items-center justify-center space-x-2'>
                                        <p className='font-semibold'>Read More</p>
                                        <ArrowRight strokeWidth={2.5} size={18} className="transition-transform group-hover:translate-x-1" />
                                    </div>
                                </Button>
                            </motion.div>
                        </div>
                    </div>

                </CardFooter>

                {/* Subtle corner accent */}
                <div className="absolute top-0 right-0 w-20 h-20 bg-gradient-to-bl from-blue-400/20 via-transparent to-transparent rounded-tr-2xl opacity-0 group-hover:opacity-100 transition-opacity duration-500" />
            </Card>
        </motion.div>
    )
}

export default NewsArticle;