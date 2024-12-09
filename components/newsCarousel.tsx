import React, { useEffect, useState } from "react";
import { Article, Question, Topic, Video } from "@/utils/types";
import { Carousel, CarouselContent, CarouselItem, type CarouselApi } from "./ui/carousel";
import Autoplay from "embla-carousel-autoplay"
import Image from 'next/image'
import { useGlobalState } from "./context/GlobalStateContext";
import { Globe, Heart, Newspaper } from "lucide-react";
import DynamicImage from "./core/dynamicimage";


export default function NewsCarousel({ topic, questions, videos }: {
    topic: string
    questions: Question[],
    videos: Video[]
}) {

    const [api, setApi] = React.useState<CarouselApi>()
    const [current, setCurrent] = React.useState(0)
    const [count, setCount] = React.useState(0)

    const { topics } = useGlobalState()

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


const IconSwitcher = ({index}:{index:number}) => {
  const [currentIconIndex, setCurrentIconIndex] = useState(index);
  
  // Array of icons to cycle through
  const icons = [
    { Icon: Heart, color: "text-blue-300" },
    { Icon: Globe, color: "text-blue-400" },
    { Icon: Newspaper, color: "text-blue-500" }
  ];

  useEffect(() => {
    // Set up an interval to cycle through icons every 1 second
    const intervalId = setInterval(() => {
      setCurrentIconIndex((prevIndex) => 
        (prevIndex + 1) % icons.length
      );
    }, 100);

    // Clean up the interval when the component unmounts
    return () => clearInterval(intervalId);
  }, []);

  const { Icon, color } = icons[currentIconIndex];

  return (
    <div className="flex items-center justify-center mb-8 mt-16 w-full">
      <div className="transition-all duration-300 ease-in-out transform">
        <Icon 
          strokeWidth={2} 
          style={{ width: 36, height: 36 }}
          className={`${color} animate-pulse`}
        />
      </div>
    </div>
  );
};



    function KeywordHighlighter({ text, keywords }) {
        const highlightKeyword = (word) => {
          return keywords.includes(word.toLowerCase()) 
            ? 'bg-gradient-to-r from-blue-300 to-blue-500 text-transparent bg-clip-text' 
            : '';
        };
      
        return (
          <div className="w-full">
            <div className="inline-block text-center whitespace-normal break-words">
              {text.split(' ').map((word, index) => (
                <span 
                  key={index} 
                  className={`
                    ${highlightKeyword(word)} 
                    text-lg font-medium text-center
                    mr-1
                    inline-block
                    break-words 
                    overflow-wrap-normal
                  `}
                >
                  {word}
                </span>
              ))}
            </div>
          </div>
        );
      }

    return (
        <div>

            <h1 className="text-2xl leading-normal text-center text-gray-300">
                Today's Question about
                <p className="text-4xl leading-normal text-center font-bold bg-gradient-to-r from-blue-300 to-blue-700 text-transparent bg-clip-text">
                    {topic}
                </p>

            </h1>

            <div className="h-[1px] justify-self-center  min-w-[20em] bg-gray-700 mt-6 mb-12" />



            <div className="flex overflow-hidden">


                <div className="flex-1 grid grid-cols-3 gap-2 ">
                    {[1, 2, 3].map((_, index) => {
                        return (
                            <div key={index} className={`col-span-1 overflow-hidden  rounded-md overflow-hidden`}>
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
                                    <div className="flex-column overflow-hidden h-full">
                                        <CarouselContent className="m-0 max-w-fit h-full" >

                                            {[1,2,3].map((_, index) => {

                                              var topic_i = topics.find((tpc) => tpc.title == topic)?.id

                                                return (

                                                    <CarouselItem key={index} className="flex-none  2xl:h-[315px] xl:h-[275px] aspect-video pl-0 overflow-hidden">

                                                        <div className="flex-none w-full h-full aspect-video" >
                                                            <DynamicImage
                                                                src={`topic_${topic_i}_${index}.webp`}
                                                                folder={"topic_img"}
                                                                alt={`Illustration for topic_${topic_i}_${index}.webp`}
                                                                width={300}
                                                                height={315}
                                                                style={{ height: "100%", width: "100%" }}
                                                                quality={100}
                                                                priority={true}
                                                                className="object-cover"
                                                            />
                                                        </div>


                                                    </CarouselItem>



                                                )
                                            })}

                                        </CarouselContent>
                                        <div className="w-full grid-col-1 justify-items-center px-4">
                                            <IconSwitcher index={index} />
                                            <KeywordHighlighter text={questions[index].text} keywords={questions[index].keywords} />
                                        </div>
                                    </div>

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