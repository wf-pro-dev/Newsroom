import { Video } from "@/utils/types";
import React, { useEffect, useRef, useState } from "react";
import YouTube from "react-youtube"

function NewsVideo({ video }: { video: Video }) {
    const containerRef = useRef(null)
    const playerRef = useRef(null)
    const [dimensions, setDimensions] = useState({ width: 0, height: 0 });
    const [opts, setOpts] = useState({})
    const [isFullyLoaded, setIsFullyLoaded] = useState(false)
    const [playerState, setPlayerState] = useState(-1)
    const bufferingTimeoutRef = useRef(null);

    useEffect(() => {
        const observer = new ResizeObserver(entries => {
            for (let entry of entries) {
                const { width, height } = entry.contentRect;
                setDimensions({ width, height });
            }
        });

        if (containerRef.current) {
            observer.observe(containerRef.current);
        }

        return () => {
            observer.disconnect();
            if (bufferingTimeoutRef.current) {
                clearTimeout(bufferingTimeoutRef.current);
            }
        };
    }, [])

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
            })
        }
    }, [dimensions])

    const onReady = (event) => {
        console.log("Player ready:", event);
        playerRef.current = event.target;
        
        // Instead of playing, just cue the video
        event.target.cueVideoById({
            videoId: video.video_id,
            suggestedQuality: 'medium'
        });
    }

    const onStateChange = (event) => {
        console.log("Player state changed:", event.data);
        setPlayerState(event.data);

        if (bufferingTimeoutRef.current) {
            clearTimeout(bufferingTimeoutRef.current);
        }

        // State 5 means video is cued and ready to play
        if (event.data === 5) {
            setIsFullyLoaded(true);
            if (bufferingTimeoutRef.current) {
                clearTimeout(bufferingTimeoutRef.current);
            }
        }

        // Fallback: if we get to any of these states, show the video
        if (event.data === 1 || event.data === 2 || event.data === -1) {
            setIsFullyLoaded(true);
        }

        // Handle persistent buffering
        if (event.data === 3) {
            bufferingTimeoutRef.current = setTimeout(() => {
                if (playerRef.current && !isFullyLoaded) {
                    setIsFullyLoaded(true);
                }
            }, 3000);
        }
    }

    const onError = (event) => {
        console.error("YouTube player error:", event);
        setIsFullyLoaded(true);
    }

    function LoadingState() {
        // Show thumbnail while loading for better UX
        return (
            <div className="absolute top-0 left-0 w-full h-full bg-stone-800  flex flex-col items-center justify-center gap-2">
                <img 
                    src={`https://img.youtube.com/vi/${video.video_id}/mqdefault.jpg`}
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
        <div ref={containerRef} className="w-full h-full rounded-md overflow-hidden relative">
            <YouTube 
                videoId={video.video_id} 
                opts={opts}
                onReady={onReady}
                onStateChange={onStateChange}
                onError={onError}
                className={isFullyLoaded ? 'opacity-100' : 'opacity-0'}
                style={{ transition: 'opacity 0.3s ease-in-out' }}
            />
            {!isFullyLoaded && <LoadingState />}
        </div>
    )
}

export default React.memo(NewsVideo)