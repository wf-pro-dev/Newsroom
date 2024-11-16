import { Video } from "@/utils/types";
import YouTube from "react-youtube"

function NewsVideo({ video }: { video: Video }) {
    const opts = {
        height: "390",
        width: "640",
        playerVars: {
            autoplay: 0,
        },
    };

    return (
        <div className="rounded-md border-2 border-gray-700 overflow-hidden">
            <YouTube videoId={video.video_id}
                opts={opts} />
        </div>
    )
}

export default NewsVideo