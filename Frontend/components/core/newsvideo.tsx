import { Favourite, Video } from "@/utils/types";
import { HeartOff, X } from "lucide-react";
import React, { useEffect, useRef, useState } from "react";
import YouTube from "react-youtube"
import { Button } from "../ui/button";
import { Heart } from "lucide-react";
import Image from "next/image";
import { addFavourite, deleteFavouritebyId, hideContent } from "@/utils/api";
import { useGlobalState } from "../context/GlobalStateContext";

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
        <div className="absolute top-0 left-0 w-full h-full bg-stone-800 flex flex-col items-center justify-center gap-2">
            <div className="absolute top-0 left-0 w-full h-full">
                <Image
                    src={video.thumbnail}
                    alt="Video thumbnail"
                    layout="fill"
                    objectFit="cover"
                />
            </div>
            <div className="absolute inset-0 bg-black bg-opacity-75 animate-pulse flex items-center justify-center">
                <p className="text-white">Loading Video...</p>
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

                const newFavourite = await addFavourite(video.id, video.type);
                // Optimistically update UI
                setFavourites([...favourites, newFavourite]);
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
        <div ref={containerRef} className={`${isDeleting ? 'opacity-0 scale-95' : 'opacity-100 scale-100'} w-full h-full border border-gray-700 rounded-md overflow-hidden relative transition-all duration-300 ease-in-out`}>
            {dimensions.width > 0 && dimensions.height > 0 && (
                <YouTube
                    videoId={video.youtube_id}
                    opts={opts}
                    onReady={onReady}
                    onStateChange={onStateChange}
                    onError={onError}
                    className={`${isFullyLoaded ? 'opacity-100' : 'opacity-0'} w-full h-full`}
                    style={{ transition: 'opacity 0.3s ease-in-out' }}
                />
            )}
            {!isFullyLoaded && <LoadingState />}

            {isFullyLoaded && (
                <div className="z-50 p-4 pr-2 rounded-l-3xl bg-gray-700/50 backdrop-blur-sm grid grid-cols-1  absolute gap-2 right-0 top-1/2 transform -translate-y-1/2 translate-x-11 hover:translate-x-0 transition-all duration-300 ease-in-out">
                    <Button
                        variant="secondary"
                        className="p-0 h-fit bg-gray-700/60 backdrop-blur-sm hover:bg-gray-700/80 text-gray-300 transition-all duration-300 ease-in-out hover:animate-bounce-subtle"
                        onClick={handleFavorite}>
                        <div className='p-2 flex justify-center items-center'>
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
                            className="p-0 h-fit  bg-gray-700/60 backdrop-blur-sm hover:bg-gray-700/80 text-gray-300 transition-all duration-300 ease-in-out hover:animate-bounce-subtle"
                            onClick={handleDelete}>
                            <div className='p-2 flex justify-center items-center'>
                                <X style={{ width: 18, height: 18 }} strokeWidth={2} />
                            </div>
                        </Button>
                    )}
                </div>
            )}
        </div>
    );
}

export default React.memo(NewsVideo);