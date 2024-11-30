import React from "react";
import { Article, Question, Topic, Video } from "@/utils/types";
import { Carousel, CarouselContent, CarouselItem, type CarouselApi } from "./ui/carousel";
import Autoplay from "embla-carousel-autoplay"
import Image from 'next/image'
import { useState } from "react";
import { Separator } from "./ui/separator";

export default function NewsCarousel({ topic,questions, videos }: {
    topic : string
    questions: Question[],
    videos: Video[]
}) {

    const [api, setApi] = React.useState<CarouselApi>()
    const [current, setCurrent] = React.useState(0)
    const [count, setCount] = React.useState(0)

    


    React.useEffect(() => {
        if (!api) {
            return
        }

        setCount(api.scrollSnapList().length)
        
        setCurrent(api.selectedScrollSnap())

        api.on("select", () => {
            setCurrent(api.selectedScrollSnap())
        })

        console.log(current,questions[current])


    }, [api])

    
    return (
        <div>

            <h1 className="text-2xl leading-normal text-center text-gray-300">
                Today's Question about
                <p className="text-4xl leading-normal text-center font-bold bg-gradient-to-r from-blue-300 to-blue-700 text-transparent bg-clip-text">
                    {topic}
                </p>
                
            </h1>

            <div className="h-[1px] justify-self-center  min-w-[20em] bg-gray-700 mt-6 mb-12" />

            

            <div className="flex 2xl:h-[315px] xl:h-[275px] overflow-hidden">

                <div className="flex-1 px-6 2xl:h-[315px] xl:h-[275px]">
                 
                    <div className="mb-6">
                        <h2 className="text-xl line-clamp-3 overflow-hidden ... font-medium">{questions[current].text}</h2>
                    </div>
                    {/*
                    <div className="mb-2">
                        <h3 className="text-xl">{text_head.title}</h3>
                    </div>

                    <div>
                        <p className="line-clamp-3 text-gray-400">{text_head.description}</p>
                    </div> */}

                </div>

                <div className="flex-1 relative ">
                    {questions.map((question, index) => {
                        return (
                            <div key={index} style={{ left: index * 125, zIndex: (2 - index), scale: 1 - (index * 0.25), opacity: 1 - (index * 0.2) }} className={`absolute 2xl:ml-12   rounded-md overflow-hidden`}>
                                <Carousel
                                    setApi={index == 0 ? setApi : undefined}
                                    opts={{
                                        loop: true,
                                        startIndex: index,
                                        watchDrag: false
                                    }}
                                    plugins={[
                                        Autoplay({
                                            delay: 5000,
                                            stopOnInteraction: false
                                        }),
                                    ]}

                                >

                                    <CarouselContent className="2xl:h-[315px] xl:h-[275px] m-0  max-w-fit aspect-video" >

                                        {questions.map((question, index) => {

                                            
                                            var carousel_item = videos.filter((video) => video.question_id == question.id)[0]

                                            return (

                                                <CarouselItem key={index} className="flex-none 2xl:h-[315px] xl:h-[275px] aspect-video pl-0 overflow-hidden">
                                                    {carousel_item.thumbnail && (
                                                        <div className="flex-none 2xl:h-[315px] xl:h-[275px] aspect-video" >
                                                            <Image
                                                                src={carousel_item.thumbnail}
                                                                alt={`Illustration for carousel-${carousel_item.thumbnail}`}
                                                                width={300}
                                                                height={315}
                                                                style={{ height: "100%", width: "100%" }}
                                                                quality={100}
                                                                priority={true}
                                                                className="object-cover"
                                                            />
                                                        </div>
                                                    )}

                                                </CarouselItem>



                                            )
                                        })}



                                    </CarouselContent>

                                </Carousel>
                            </div>
                        )
                    })

                    }

                </div>
            </div>
        </div>

    )
}