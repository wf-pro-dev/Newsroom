import { Video } from "@/utils/types";
import { useEffect, useRef, useState } from "react";
import YouTube from "react-youtube"

function NewsVideo({ video }: { video: Video }) {

    var containerRef = useRef(null)
    const [dimensions, setDimensions] = useState({ width: 0, height: 0 });
    const [opts, setOpts] = useState({})




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

        return () => observer.disconnect();

    }, [])

    useEffect(() => {
        setOpts(
            {
                height: dimensions.height,
                width: dimensions.width,
                playerVars: {
                    autoplay: 0,
                },

            }
        )
    }, [dimensions])




    return (
        <div id="parent" ref={containerRef} className="w-full h-full rounded-md border-2 border-gray-700 overflow-hidden">
            <YouTube videoId={video.video_id}
                opts={opts} />
        </div>
    )
}

export default NewsVideo