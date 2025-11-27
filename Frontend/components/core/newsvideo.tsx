import { Article, Favourite, Video } from "@/utils/types";
import { HeartOff, X, Heart, Play } from "lucide-react";
import React, { useEffect, useRef, useState } from "react";
import YouTube from "react-youtube"
import { Button } from "../ui/button";
import Image from "next/image";
import { addFavourite, deleteFavouritebyId, hideContent } from "@/utils/api";
import { useGlobalState } from "../../src/contexts/GlobalStateContext";
import { motion } from 'framer-motion';
import { Separator } from '@radix-ui/react-separator';

import "@/styles/newsmain.css"
import { mixArray } from "@/lib/utils";

type NewsVideoProps = {
    video: Video;
    showFavorites: boolean
    showAdd: React.Dispatch<React.SetStateAction<boolean>>,
    showDelete: React.Dispatch<React.SetStateAction<boolean>>,
};

type YouTubePlayerRef = {
    setSize: (width: number, height: number) => void;
    cueVideoById: (params: { videoId: string, suggestedQuality: string }) => void;
};

function NewsVideo({ video, showFavorites, showAdd, showDelete }: NewsVideoProps) {
    const containerRef = useRef<HTMLDivElement>(null);
    const playerRef = useRef<YouTubePlayerRef | null>(null);
    const [dimensions, setDimensions] = useState({ width: 0, height: 0 });
    const [opts, setOpts] = useState({});
    const [isFullyLoaded, setIsFullyLoaded] = useState(false);
    const [isDeleting, setIsDeleting] = useState(false);
    const [isMounted, setIsMounted] = useState(false);
    const bufferingTimeoutRef = useRef<NodeJS.Timeout | null>(null);

    const { videos, setVideos, favourites, setFavourites } = useGlobalState()

    const favorite = favourites.find((fav) => fav.type == "video" && fav.video_id == video.id) ||
        favourites.find((fav: Favourite) => fav == video)

    // Set mounted state
    useEffect(() => {
        setIsMounted(true);
        return () => {
            setIsMounted(false);
        };
    }, []);

    // Function to update dimensions and player size
    const updateDimensions = () => {
        if (!isMounted || !containerRef.current) return;

        const { offsetWidth, offsetHeight } = containerRef.current;
        const newDimensions = {
            width: offsetWidth,
            height: offsetHeight
        };

        setDimensions(newDimensions);

        // Only update player size if the player is available
        if (playerRef.current && typeof playerRef.current.setSize === 'function' && newDimensions.width && newDimensions.height) {
            try {
                playerRef.current.setSize(newDimensions.width, newDimensions.height);
            } catch (error) {
                console.warn('Failed to resize YouTube player:', error);
            }
        }
    };

    useEffect(() => {
        if (!isMounted) return;

        // Initial dimension setup
        updateDimensions();

        // Set up ResizeObserver for container changes
        const observer = new ResizeObserver(() => {
            if (isMounted) {
                requestAnimationFrame(updateDimensions);
            }
        });

        if (containerRef.current) {
            observer.observe(containerRef.current);
        }

        // Handle window resize events with debouncing
        let resizeTimeout: NodeJS.Timeout;
        const handleResize = () => {
            if (!isMounted) return;
            clearTimeout(resizeTimeout);
            resizeTimeout = setTimeout(updateDimensions, 100);
        };

        window.addEventListener('resize', handleResize);

        // Cleanup
        return () => {
            observer.disconnect();
            window.removeEventListener('resize', handleResize);
            clearTimeout(resizeTimeout);
            if (bufferingTimeoutRef.current) {
                clearTimeout(bufferingTimeoutRef.current);
            }
        };
    }, [isMounted]);

    // Update YouTube player options when dimensions change
    useEffect(() => {
        if (!isMounted) return;

        if (dimensions.height && dimensions.width) {
            setOpts({
                height: dimensions.height,
                width: dimensions.width,
                playerVars: {
                    autoplay: 0,
                    modestbranding: 1,
                    rel: 0,
                    showinfo: 0,
                    playsinline: 1,
                    controls: 1,
                    enablejsapi: 1,
                    origin: window.location.origin,
                    host: 'https://www.youtube-nocookie.com'
                },
            });
        }
    }, [dimensions, isMounted]);


    const onReady = (event: { target: YouTubePlayerRef }) => {
        if (!isMounted) return;

        playerRef.current = event.target;

        // Set initial size only if dimensions are available
        if (dimensions.width && dimensions.height) {
            try {
                event.target.setSize(dimensions.width, dimensions.height);
            } catch (error) {
                console.warn('Failed to set initial YouTube player size:', error);
            }
        }

        event.target.cueVideoById({
            videoId: video.youtube_id,
            suggestedQuality: 'medium'
        });
    }

    const onStateChange = (event: { data: number }) => {
        if (!isMounted) return;

        if (bufferingTimeoutRef.current) {
            clearTimeout(bufferingTimeoutRef.current);
        }

        if (event.data === 5) {
            setIsFullyLoaded(true);
            if (bufferingTimeoutRef.current) {
                clearTimeout(bufferingTimeoutRef.current);
            }
        }

        if (event.data === 1 || event.data === 2 || event.data === -1) {
            setIsFullyLoaded(true);
        }

        if (event.data === 3) {
            bufferingTimeoutRef.current = setTimeout(() => {
                if (playerRef.current && !isFullyLoaded && isMounted) {
                    setIsFullyLoaded(true);
                }
            }, 3000);
        }
    }

    const onError = () => {
        if (isMounted) {
            setIsFullyLoaded(true);
        }
    }

    const LoadingState = () => (
        <div className="absolute top-0 left-0 flex flex-col items-center justify-center w-full h-full gap-2 bg-gray-800/30 backdrop-blur-xl rounded-2xl overflow-hidden">
            <div className="w-full h-full relative">
                <Image
                    src={video.thumbnail}
                    alt="Video thumbnail"
                    layout="fill"
                    objectFit="cover"
                    className="transition-transform duration-500 group-hover:scale-125"
                />
                {/* Enhanced image overlay */}
                <div className="absolute inset-0 bg-gradient-to-t from-black/60 via-transparent to-transparent" />
                <div className="absolute inset-0 bg-gradient-to-br from-blue-500/20 via-transparent to-cyan-500/20" />
            </div>
            <div className="absolute inset-0 flex items-center justify-center bg-black/40 backdrop-blur-sm">
                <motion.div
                    initial={{ opacity: 0, scale: 0.8 }}
                    animate={{ opacity: 1, scale: 1 }}
                    transition={{ duration: 0.5, repeat: Infinity, repeatType: "reverse" }}
                    className="flex flex-col items-center space-y-3"
                >
                    <div className="p-4 bg-blue-500/20 backdrop-blur-md border border-blue-400/30 rounded-full">
                        <Play className="w-8 h-8 text-blue-300" strokeWidth={1.5} />
                    </div>
                    <p className="text-slate-200 font-medium">Loading Video...</p>
                </motion.div>
            </div>
        </div>
    );

    // Rest of your handlers
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

                const newFavorite = await addFavourite(video.id, video.type);

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
            setVideos(videos.filter((vid) => vid.id != video.id));
        }, 300)

        try {
            await hideContent(video.id, "video");
            showDelete(true);

            setTimeout(() => {
                showDelete(false);
            }, 2000);
        } catch (error) {
            console.error("Error deleting video:", error);
        } finally {
            setIsDeleting(false);
        }
    }

    if (!isMounted) return null;
    
    return (
        <motion.div
            ref={containerRef}
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: isDeleting ? 0 : 1, y: 0, scale: isDeleting ? 0.95 : 1 }}
            transition={{ duration: 0.3 }}
            whileHover={{ y: -8, scale: 1.02, transition: { duration: 0.3, ease: "easeOut" } }}
            className="group w-full h-full"
        >
            <div className="relative min-h-full overflow-hidden transition-all duration-500 border-2 shadow-2xl bg-gray-800/30 backdrop-blur-xl border-slate-600/30 rounded-2xl hover:shadow-blue-500/30 group-hover:border-blue-400/50 group-hover:bg-gray-700/40">
                {/* Enhanced holographic effects */}
                <div className="absolute inset-0 transition-opacity duration-500 opacity-0 bg-gradient-to-br from-blue-400/10 via-cyan-400/5 to-purple-400/10 rounded-2xl group-hover:opacity-100" />
                <div className="absolute inset-0 bg-gradient-to-t from-blue-500/10 via-transparent to-white/5 rounded-2xl" />
                
                {!isFullyLoaded && <LoadingState />}

                {dimensions.width > 0 && dimensions.height > 0 && (
                    <div className="relative w-full h-full rounded-2xl overflow-hidden">
                        <YouTube
                            videoId={video.youtube_id}
                            opts={opts}
                            onReady={onReady}
                            onStateChange={onStateChange}
                            onError={onError}
                            className={`${isFullyLoaded ? 'opacity-100' : 'opacity-0'} w-full h-full`}
                            style={{ transition: 'opacity 0.3s ease-in-out' }}
                        />
                        
                        {/* Video overlay information */}
                        {isFullyLoaded && (
                            <>
                                {/* Top overlay with metadata */}
                                <div className="absolute flex flex-row justify-between top-3 left-3 right-3 z-30">
                                    <motion.div
                                        className='p-2 rounded-lg bg-slate-800/60 backdrop-blur-md border border-slate-600/40'
                                        whileHover={{ scale: 1.05 }}
                                        transition={{ duration: 0.2 }}
                                    >
                                        <div className='flex flex-row items-center'>
                                            <Play style={{ width: 18, height: 18 }} strokeWidth={1.5} className="text-blue-300" />
                                            <Separator orientation="vertical" className='mx-2 w-[1px] h-[12px] bg-slate-400/60' />
                                            <p className='text-slate-200 xl:text-xs 2xl:text-sm font-medium'>
                                                Video
                                            </p>
                                        </div>
                                    </motion.div>

                                    <motion.div
                                        className='p-2 rounded-lg bg-slate-800/60 backdrop-blur-md border border-slate-600/40'
                                        whileHover={{ scale: 1.05 }}
                                        transition={{ duration: 0.2 }}
                                    >
                                        <p className='text-blue-300 xl:text-xs 2xl:text-sm font-medium'>YouTube</p>
                                    </motion.div>
                                </div>

                                {/* Bottom overlay with score */}
                                <div className="absolute flex flex-row justify-between bottom-3 left-3 right-3 z-30">
                                    <motion.div
                                        className='p-2 rounded-lg bg-slate-800/60 backdrop-blur-md border border-slate-600/40'
                                        whileHover={{ scale: 1.05 }}
                                        transition={{ duration: 0.2 }}
                                    >
                                        <p className='text-cyan-300 xl:text-xs 2xl:text-sm font-semibold'>Video #{video.id}</p>
                                    </motion.div>
                                </div>

                                {/* Enhanced action buttons */}
                                <div className="absolute right-3 z-50 flex flex-col gap-2 transition-all duration-300 ease-in-out transform -translate-y-1/2 top-1/2 translate-x-16 group-hover:translate-x-0">
                                    <motion.div
                                        whileHover={{ scale: 1.1 }}
                                        whileTap={{ scale: 0.95 }}
                                    >
                                        <Button
                                            className="p-2 bg-slate-800/60 backdrop-blur-md border border-slate-600/40 rounded-xl hover:bg-gradient-to-r hover:from-blue-500/30 hover:via-cyan-400/20 hover:to-blue-500/30 hover:border-blue-400/60 hover:shadow-lg hover:shadow-blue-500/40 transition-all duration-300"
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
                                                className="p-2 bg-slate-800/60 backdrop-blur-md border border-slate-600/40 rounded-xl hover:bg-gradient-to-r hover:from-red-500/30 hover:via-red-400/20 hover:to-red-500/30 hover:border-red-400/60 hover:shadow-lg hover:shadow-red-500/40 transition-all duration-300"
                                                onClick={handleDelete}>
                                                <div className='flex items-center justify-center'>
                                                    <X style={{ width: 18, height: 18 }} strokeWidth={2} className="text-slate-300 hover:text-red-400 transition-colors duration-200" />
                                                </div>
                                            </Button>
                                        </motion.div>
                                    )}
                                </div>
                            </>
                        )}
                    </div>
                )}

                {/* Subtle corner accent */}
                <div className="absolute top-0 right-0 w-20 h-20 bg-gradient-to-bl from-blue-400/20 via-transparent to-transparent rounded-tr-2xl opacity-0 group-hover:opacity-100 transition-opacity duration-500" />
            </div>
        </motion.div>
    );
}

export default React.memo(NewsVideo);