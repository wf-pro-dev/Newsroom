import { Video } from "@/utils/types";

import React from "react";

import Image from "next/image";

import "@/styles/newsmain.css"




function Thumbnail(video : Video) {

    return (
        <div className="flex flex-col items-center justify-center w-full h-full gap-2 border border-gray-700 rounded-md">
            <div className="w-full h-full I">
                <Image
                    src={video.thumbnail}
                    alt="Video thumbnail"
                    layout="fill"
                    objectFit="cover"
                    draggable={false}

                />
            </div>
        </div>
    );
}

export default React.memo(Thumbnail);