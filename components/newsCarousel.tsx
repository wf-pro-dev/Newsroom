import React from "react";
import { Article, Question } from "@/utils/types";
import { Carousel, CarouselContent, CarouselItem, type CarouselApi } from "./ui/carousel";
import Autoplay from "embla-carousel-autoplay"
import Image from 'next/image'
import { useState } from "react";

export default function NewsCarousel({ questions, articles }: {
    questions: Question[],
    articles: Article[]
}) {

    const [text_question, setQuestion] = useState(questions[0])
    const [text_head, setHead] = useState(articles.filter((article) => article.question_id == text_question.id.toString())[0])

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


    }, [api])

    React.useEffect(() => {

        setQuestion(questions[current])
        setHead(articles.filter((article) => article.question_id == questions[current].id.toString())[0])

    }, [current])


    return (
        <div>

            <h1 className="text-2xl leading-normal mb-8 text-center text-gray-300">
                Today's Question about
                <p className="text-4xl leading-normal text-center font-bold bg-gradient-to-r from-blue-300 to-blue-700 text-transparent bg-clip-text">
                    {text_question.topic}
                </p>
            </h1>

            <div className="flex 2xl:h-[315px] xl:h-[275px] overflow-hidden">

                <div className="flex-1 px-6 2xl:h-[315px] xl:h-[275px]">

                    <div className="mb-6">
                        <h2 className="text-2xl line-clamp-3 overflow-hidden ... font-medium">{text_question.question}</h2>
                    </div>

                    <div className="mb-2">
                        <h3 className="text-xl">{text_head.title}</h3>
                    </div>

                    <div>
                        <p className="line-clamp-3 text-gray-400">{text_head.description}</p>
                    </div>

                </div>

                <div className="flex-1 relative ">
                    {questions.map((question, index) => {
                        return (
                            <div key={index} style={{ left: index * 130, zIndex: (2 - index), scale: 1 - (index * 0.2),opacity:1 - (index * 0.2) }} className={`absolute 2xl:ml-12 border-[.5px] border-gray-400 rounded-md overflow-hidden`}>
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

                                    <CarouselContent className="2xl:h-[315px] 2xl:max-w-[545px] xl:h-[275px] xl:w-[475px]" >

                                        {questions.map((question,index) => {


                                            var qst_head = articles.filter((article) => article.question_id == question.id.toString())[0]

                                            return (

                                                <CarouselItem key={index} className="flex-none 2xl:h-[315px] 2xl:min-w-[545px] xl:h-[275px] xl:w-[475px] pl-0 overflow-hidden">
                                                    {qst_head.urlToImage && (
                                                        <div className="flex-none 2xl:h-[315px] 2xl:min-w-[545px] xl:h-[275px] xl:w-[475px]" >
                                                            <Image
                                                                src={qst_head.urlToImage}
                                                                alt={`Illustration for ${qst_head.title}`}
                                                                width={200}
                                                                height={200}
                                                                style={{ width: "100%", height: "100%" }}
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