import { Question, Video } from "@/utils/types";
import { HeartOff, X } from "lucide-react";
import React, { useEffect, useRef, useState } from "react";
import YouTube from "react-youtube"
import { Button } from "./ui/button";
import { Heart } from "lucide-react";
import { addFavorite, delteVideobyId, removeFavorite } from "@/utils/api";

type NewsVideoProps = {
    video: Video;
    videos: Video[];
    setVideos: React.Dispatch<React.SetStateAction<Video[]>>;
    favorites: Video[];
    setFavorites: React.Dispatch<React.SetStateAction<Video[]>>,
};

function NewsVideo({ video, videos, setVideos, favorites,setFavorites }: NewsVideoProps) {
    const containerRef = useRef(null);
    const playerRef = useRef(null);
    const [dimensions, setDimensions] = useState({ width: 0, height: 0 });
    const [opts, setOpts] = useState({});
    const [isFullyLoaded, setIsFullyLoaded] = useState(false);
    const [playerState, setPlayerState] = useState(-1);
    const [isDeleting, setIsDeleting] = useState(false)
    const bufferingTimeoutRef = useRef(null);

    // Function to update dimensions and player size
    const updateDimensions = () => {
        if (containerRef.current) {
            const { offsetWidth, offsetHeight } = containerRef.current;
            const newDimensions = {
                width: offsetWidth,
                height: offsetHeight
            };

            setDimensions(newDimensions);

            // Only update player size if the player is available
            if (playerRef.current) {
                try {
                    playerRef.current.setSize(newDimensions.width, newDimensions.height);
                } catch (error) {
                    console.warn('Failed to resize YouTube player:', error);
                }
            }
        }
    };

    useEffect(() => {
        // Initial dimension setup
        updateDimensions();

        // Set up ResizeObserver for container changes
        const observer = new ResizeObserver(() => {
            // Debounce resize operations
            requestAnimationFrame(updateDimensions);
        });

        if (containerRef.current) {
            observer.observe(containerRef.current);
        }

        // Handle window resize events with debouncing
        let resizeTimeout;
        const handleResize = () => {
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
    }, []);

    // Update YouTube player options when dimensions change
    useEffect(() => {
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
    }, [dimensions]);

    const onReady = (event) => {
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
            videoId: video.video_id,
            suggestedQuality: 'medium'
        });
    }


    const onStateChange = (event) => {
        setPlayerState(event.data);

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
                if (playerRef.current && !isFullyLoaded) {
                    setIsFullyLoaded(true);
                }
            }, 3000);
        }
    }

    const onError = (event) => {
        setIsFullyLoaded(true);
    }

    async function handleFavorite() {

        if (favorites.some((fav: Video) => fav.id === video.id)) {



            await removeFavorite("Fav_Videos",video.id)
                .then(() => {
                    // showDelete(true)
                    
                    setIsDeleting(true)

                    setTimeout(() => {
                        setFavorites(favorites.filter((fav: Video) => fav.id !== video.id))
                        setIsDeleting(false)
                    }, 400)

                })
        } else {
            await addFavorite("Fav_Videos",video)
                .then(() => {
                    setFavorites([...favorites, video])

                    // showAdd(true)
                })
        }
    }

    async function handleDelete() {
        await delteVideobyId(video.id)
            .then(() => {
                // showDelete(true)
                setIsDeleting(true)

                // setTimeout(() => {
                //     showDelete(false)
                // }, 2000)

                setTimeout(() => {
                    setVideos(videos.filter((vid) => vid.id != video.id))
                    setIsDeleting(false)
                }, 400)


            })
    }

    function LoadingState() {
        return (
            <div className="absolute top-0 left-0 w-full h-full bg-stone-800 flex flex-col items-center justify-center gap-2">
                <img
                    src={video.thumbnail}
                    alt="Video thumbnail"
                    className="absolute top-0 left-0 w-full h-full object-cover"
                />
                <div className="absolute inset-0 bg-black bg-opacity-75 animate-pulse flex items-center justify-center">
                    <p className="text-white">Loading Video...</p>
                </div>
            </div>
        )
    }

    return (
        <div ref={containerRef} className={`${isDeleting ? 'opacity-0 scale-95' : 'opacity-100 scale-100'} group w-full h-full rounded-md overflow-hidden relative transition-all duration-300 ease-in-out`}>

            <YouTube
                videoId={video.video_id}
                opts={opts}
                onReady={onReady}
                onStateChange={onStateChange}
                onError={onError}
                className={`${isFullyLoaded ? 'opacity-100' : 'opacity-0'} w-full h-full`}
                style={{ transition: 'opacity 0.3s ease-in-out' }}
            />
            {!isFullyLoaded && <LoadingState />}

            {isFullyLoaded && (
                <div className="z-50 grid grid-cols-1 absolute gap-2 right-4 top-1/2 transform -translate-y-1/2 translate-x-14 group-hover:translate-x-0 transition-all duration-300 ease-in-out">

                    <Button
                        variant="secondary"
                        className="p-0 h-fit bg-gray-700/60 backdrop-blur-sm hover:bg-gray-700/80 text-gray-300 transition-all duration-300 ease-in-out hover:animate-bounce-subtle"
                        onClick={handleDelete}>
                        <div className='p-2 flex justify-center items-center'>
                            <X style={{ width: 18, height: 18 }} strokeWidth={2} />
                        </div>
                    </Button>

                    <Button
                        variant="secondary"
                        className="p-0 h-fit bg-gray-700/60 backdrop-blur-sm hover:bg-gray-700/80 text-gray-300 transition-all duration-300 ease-in-out hover:animate-bounce-subtle"
                        onClick={handleFavorite}>
                        <div className='p-2 flex justify-center items-center'>
                            {favorites.length > 0 && favorites.some((fav: Video) => fav.id === video.id) ? <HeartOff style={{ width: 18, height: 18 }} strokeWidth={2} /> : <Heart style={{ width: 18, height: 18 }} strokeWidth={2} />}
                        </div>

                    </Button>
                </div>
            )}

        </div>
    )
}

export default React.memo(NewsVideo);