import React, { useEffect, useState } from "react";
import { Question, Topic } from "@/utils/types";
import { Carousel, CarouselContent, CarouselItem } from "./ui/carousel";
import Autoplay from "embla-carousel-autoplay";
import { useGlobalState } from "./context/GlobalStateContext";
import { Globe, Heart, Newspaper } from "lucide-react";
import Image from "next/image";

/* STYLES */
import "../styles/newsmain.css";

function NewsCarousel({ topic_title, questions }: {
    topic_title: string;
    questions: Question[];
}) {

    const { topics } = useGlobalState();

    const IconSwitcher = ({ index }: { index: number }) => {
        const [currentIconIndex, setCurrentIconIndex] = useState(index);
        const icons = [
            { Icon: Heart, color: "text-blue-300" },
            { Icon: Globe, color: "text-blue-400" },
            { Icon: Newspaper, color: "text-blue-500" }
        ];

        useEffect(() => {
            const intervalId = setInterval(() => {
                setCurrentIconIndex((prevIndex) =>
                    (prevIndex + 1) % icons.length
                );
            }, 100);

            return () => clearInterval(intervalId);
        }, [icons.length]);

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

    function KeywordHighlighter({ text, keywords }: { text: string; keywords: string }) {
        const highlightKeyword = (word: string) => {
            word = word.replace(/[^a-zA-Z0-9]/g, '');
            return keywords.includes(word)
              ? 'bg-gradient-to-l from-blue-300 to-blue-600 text-transparent bg-clip-text animated-gradient'
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
            <h1 className="text-3xl leading-normal text-center  font-medium
            
            text-gray-300">
                Today&apos;s Question about
                <p className="text-5xl leading-normal text-center font-semibold bg-gradient-to-l from-blue-300 to-blue-600 text-transparent bg-clip-text animated-title-gradient">
                    {topic_title}
                </p>
            </h1>

            <div className="h-[1px] justify-self-center min-w-[20em] bg-gray-700 mt-6 mb-12" />

            <div className="flex ">
                <div className="flex-1 grid grid-cols-3 gap-2">
                    {[1, 2, 3].map((_, index) => {
                        const topic : Topic | undefined = topics.find((tpc) => tpc.title === topic_title);
                        return (
                            <div key={index} className="col-span-1 rounded-md">
                                <Carousel
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
                                    <div className="flex-column">
                                        <CarouselContent className="m-0">
                                            {topic!.images.map((url, idx) => { 
                                                return (
                                                <CarouselItem key={idx} className="pl-0 aspect-video border border-gray-700">
                                                    <div className="w-full h-full">
                                                        <Image
                                                            src={url}
                                                            alt={`Illustration for topic_${topic!.id}_${idx}.webp`}
                                                            width={100}
                                                            height={100}
                                                            style={{ width: "100%", height:"100%" }}
                                                            quality={100}
                                                            priority={true}
                                                        />
                                                                                  
                                                    </div>
                                                </CarouselItem>)}
                                            )}
                                        </CarouselContent>
                                        <div className="w-full grid-col-1 justify-items-center px-4">
                                            <IconSwitcher index={index} />
                                            <KeywordHighlighter text={questions[index].text} keywords={questions[index].keywords} />
                                        </div>
                                    </div>
                                </Carousel>
                            </div>
                        );
                    })}
                </div>
            </div>
        </div>
    );
}

export default React.memo(NewsCarousel, (prevProps, nextProps) => {
    return (
      prevProps.topic_title === nextProps.topic_title &&
      prevProps.questions === nextProps.questions
    );
})