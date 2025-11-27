import React, { useEffect, useState, useMemo, useCallback } from "react";
import { Question, Topic } from "@/utils/types";
import { Carousel, CarouselContent, CarouselItem } from "./ui/carousel";
import Autoplay from "embla-carousel-autoplay";
import { useGlobalState } from "../src/contexts/GlobalStateContext";
import { Globe, Heart, Newspaper, ChevronLeft, ChevronRight } from "lucide-react";
import Image from "next/image";
import { motion } from "framer-motion";
import { Roboto_Mono } from 'next/font/google'

/* STYLES */
import "../styles/newsmain.css";
import "../styles/page.css";

const roboto = Roboto_Mono({
    subsets: ['latin'],
    weight: ['400', '500', '700'],
    display: 'swap'
})

function NewsCarousel({
    topic_title,
    questions,
    activeTab,
    setActiveTab,
    availableTabs
}: {
    topic_title: string;
    questions: Question[];
    activeTab: string;
    setActiveTab: (tab: string) => void;
    availableTabs: string[];
}) {

    const { topics } = useGlobalState();

    // Debug: Log when component mounts/unmounts
    useEffect(() => {
        console.log(`NewsCarousel mounted for topic: ${topic_title}`);
        return () => {
            console.log(`NewsCarousel unmounting for topic: ${topic_title}`);
        };
    }, [topic_title]);

    const navigateToTab = (direction: 'prev' | 'next') => {
        const currentIndex = availableTabs.indexOf(activeTab);
        let newIndex;

        if (direction === 'prev') {
            newIndex = currentIndex > 0 ? currentIndex - 1 : availableTabs.length - 1;
        } else {
            newIndex = currentIndex < availableTabs.length - 1 ? currentIndex + 1 : 0;
        }

        setActiveTab(availableTabs[newIndex]);
    };

    const IconSwitcher = React.memo(({ index }: { index: number }) => {
        const [currentIconIndex, setCurrentIconIndex] = useState(index);
        const icons = useMemo(() => [
            { Icon: Heart, color: "text-blue-300" },
            { Icon: Globe, color: "text-cyan-300" },
            { Icon: Newspaper, color: "text-blue-400" }
        ], []);

        useEffect(() => {
            const intervalId = setInterval(() => {
                setCurrentIconIndex((prevIndex) =>
                    (prevIndex + 1) % icons.length
                );
            }, 200);

            return () => clearInterval(intervalId);
        }, [icons.length]);

        const { Icon, color } = icons[currentIconIndex];

        return (
            <div className="flex items-center justify-center w-full">
                <motion.div
                    className="p-2 transition-all duration-300 ease-in-out transform border rounded-full shadow-lg bg-white/5 backdrop-blur-sm border-blue-400/40 shadow-blue-500/50"
                    whileHover={{ scale: 1.05, rotate: 3 }}
                    transition={{ duration: 0.2 }}
                >
                    <Icon
                        strokeWidth={2.5}
                        style={{ width: 24, height: 24 }}
                        className={`${color} transition-all duration-300`}
                    />
                </motion.div>
            </div>
        );
    });
    IconSwitcher.displayName = 'IconSwitcher';

    const KeywordHighlighter = React.memo(({ text, keywords }: { text: string; keywords: string }) => {
        const highlightKeyword = useCallback((word: string) => {
            const cleanWord = word.replace(/[^a-zA-Z0-9]/g, '');
            return keywords.includes(cleanWord)
                ? 'bg-gradient-to-r from-blue-300 via-cyan-300 to-blue-400 text-transparent bg-clip-text font-bold'
                : '';
        }, [keywords]);

        const words = useMemo(() => text.split(' '), [text]);

        return (
            <div className="w-full max-w-4xl mx-auto p-6">
                {/* Question Label */}
                <div className="mb-4 flex items-center justify-center">
                    <div className="flex items-center space-x-2 text-blue-300/70 text-sm font-medium uppercase tracking-wider">
                        <div className="w-8 h-px bg-gradient-to-r from-transparent to-blue-300/50"></div>
                        <span>Exploring</span>
                        <div className="w-8 h-px bg-gradient-to-l from-transparent to-blue-300/50"></div>
                    </div>
                </div>

                {/* Enhanced Text Container */}
                <div className="relative">
                    {/* Background decoration */}
                    <div className="absolute inset-0 bg-gradient-to-br from-blue-900/10 via-transparent to-purple-900/10 rounded-2xl blur-xl"></div>

                    {/* Main text container */}
                    <div className="relative bg-black/20 backdrop-blur-sm border border-white/10 rounded-2xl p-4 shadow-2xl">
                        <div className={`text-center leading-relaxed ${roboto.className}`}>
                            {words.map((word, index) => (
                                <span
                                    key={index}
                                    className={`
                                    ${highlightKeyword(word)} 
                                    text-xs md:text-sm font-medium text-gray-100
                                    mr-1 mb-1
                                    inline-block
                                    transition-all duration-300 ease-out
                                    hover:scale-105 hover:text-white
                                    ${highlightKeyword(word) ? 'drop-shadow-lg' : ''}
                                `}
                                >
                                    {word}
                                </span>
                            ))}
                        </div>

                        {/* Subtle bottom accent */}
                        <div className="mt-4 flex justify-center">
                            <div className="w-16 h-px bg-gradient-to-r from-transparent via-blue-400/50 to-transparent"></div>
                        </div>
                    </div>
                </div>


            </div>
        );
    });
    KeywordHighlighter.displayName = 'KeywordHighlighter';



    return (
        <div className="flex flex-col w-screen h-screen items-center justify-center pb-6 px-12 via-blue-950/30 to-black/60 relative">
            {/* Simplified Navigation */}
            <motion.div
                className="absolute left-8 top-1/2 transform -translate-y-1/2 z-20"
                whileHover={{ scale: 1.05 }}
                whileTap={{ scale: 0.95 }}
            >
                <div
                    onClick={() => navigateToTab('prev')}
                    className="group relative w-12 h-12 cursor-pointer flex items-center justify-center"
                >
                    {/* Simplified Container */}
                    <div className="absolute inset-1 rounded-full bg-slate-900/40 backdrop-blur-sm border border-slate-600/30 transition-all duration-200 group-hover:bg-slate-800/60 group-hover:border-slate-500/50" />

                    {/* Main icon */}
                    <ChevronLeft
                        className="relative w-6 h-6 text-slate-200 group-hover:text-white transition-colors duration-200 z-10"
                        strokeWidth={2}
                    />
                </div>
            </motion.div>

            <motion.div
                className="absolute right-8 top-1/2 transform -translate-y-1/2 z-20"
                whileHover={{ scale: 1.05 }}
                whileTap={{ scale: 0.95 }}
            >
                <div
                    onClick={() => navigateToTab('next')}
                    className="group relative w-12 h-12 cursor-pointer flex items-center justify-center"
                >
                    {/* Simplified Container */}
                    <div className="absolute inset-1 rounded-full bg-slate-900/40 backdrop-blur-sm border border-slate-600/30 transition-all duration-200 group-hover:bg-slate-800/60 group-hover:border-slate-500/50" />

                    {/* Main icon */}
                    <ChevronRight
                        className="relative w-6 h-6 text-slate-200 group-hover:text-white transition-colors duration-200 z-10"
                        strokeWidth={2}
                    />
                </div>
            </motion.div>

            {/* Tab Indicators */}
            <div className="absolute top-6 left-1/2 transform -translate-x-1/2 z-20 flex space-x-3">
                {availableTabs.map((tab) => (
                    <div
                        key={tab}
                        className={`w-3 h-3 rounded-full transition-all duration-300 ${tab === activeTab
                            ? 'bg-slate-400 shadow-lg shadow-slate-400/60 scale-125'
                            : 'bg-slate-600/50 hover:bg-slate-500/60'
                            }`}
                    />
                ))}
            </div>

            <div>
                {/* Header Container */}
                <header className="relative z-10 w-full border-b border-slate-600/30 px-28 pb-6 mb-8">
                    <div className="flex items-center justify-between">
                        {/* Left section: Subtitle and lead text */}
                        <div className="flex items-center space-x-4">
                            <div

                            >
                                <p className="text-sm font-medium tracking-[0.25em] text-slate-300 uppercase drop-shadow-md"
                                    style={{
                                        textShadow: `
                                               0 0 15px rgba(100, 116, 139, 0.6),
                                               0 0 30px rgba(100, 116, 139, 0.3)
                                           `
                                    }}>
                                    Today&apos;s Insights
                                </p>
                            </div>

                            {/* Separator */}
                            <motion.div
                                initial={{ opacity: 0, scale: 0 }}
                                animate={{ opacity: 1, scale: 1 }}
                                transition={{ delay: 0.3, duration: 0.4 }}
                                className="w-px h-6 bg-gradient-to-b from-transparent via-slate-400/60 to-transparent"
                            />

                            <motion.div
                                initial={{ opacity: 0, y: -20, scale: 0.95 }}
                                animate={{ opacity: 1, y: 0, scale: 1 }}
                                transition={{ delay: 0.6, duration: 0.8 }}
                                className="relative flex-1 flex justify-center"
                            >
                                {/* Simplified glow effect */}
                                <div className="absolute inset-0 flex items-center justify-center">
                                    <h2 className="text-3xl font-bold tracking-tight text-blue-600/40 blur-sm">
                                        {topic_title}
                                    </h2>
                                </div>

                                {/* Main title text */}
                                <h2 className="relative text-3xl font-bold leading-none tracking-tight text-center">
                                    <span className="text-transparent bg-gradient-to-r from-white via-slate-100 to-gray-100 bg-clip-text font-bold">
                                        {topic_title}
                                    </span>
                                </h2>
                            </motion.div>
                        </div>

                        {/* Center section: Main title */}


                        {/* Right section: Decorative elements */}
                        <div className="flex items-center space-x-4">
                            {/* Simplified dots */}
                            <motion.div
                                className="flex items-center space-x-2"
                                initial={{ opacity: 0, x: 20 }}
                                animate={{ opacity: 1, x: 0 }}
                                transition={{ delay: 1.2, duration: 0.4 }}
                            >
                                {[0, 1, 2].map((i) => (
                                    <div
                                        key={i}
                                        className="w-1.5 h-1.5 rounded-full bg-slate-400/70"
                                    />
                                ))}
                            </motion.div>
                        </div>
                    </div>

                    {/* Professional elegant underline - now spans the full width */}
                    <div
                        className="flex justify-center mt-4"

                    >
                        <motion.div
                            className="relative"
                            initial={{ width: 0 }}
                            animate={{ width: "12rem" }}
                            transition={{
                                delay: 1.2,
                                duration: 1,
                                ease: "easeOut"
                            }}
                        >
                            {/* Professional glowing underline */}
                            <div
                                className="h-px bg-gradient-to-r from-transparent via-slate-400/80 to-transparent"
                                style={{
                                    boxShadow: `
                                            0 0 10px rgba(100, 116, 139, 0.7),
                                            0 0 20px rgba(100, 116, 139, 0.4),
                                            0 0 30px rgba(51, 65, 85, 0.3)
                                        `
                                }}
                            />
                            {/* Subtle additional glow layer */}
                            <div
                                className="absolute top-0 left-0 w-full h-px bg-gradient-to-r from-transparent via-blue-700/60 to-transparent blur-sm"
                                style={{
                                    boxShadow: `
                                            0 0 15px rgba(29, 78, 216, 0.5)
                                        `
                                }}
                            />
                        </motion.div>
                    </div>
                </header>


                <div className="w-full">


                    {/* Enhanced Cards Grid - More compact */}
                    <div className="px-20">
                        <div className="grid grid-cols-3 gap-8">
                            {[1, 2, 3].map((_, index) => {
                                const topic: Topic | undefined = topics.find((tpc) => tpc.title === topic_title);
                                return (
                                    <motion.div
                                        key={`${topic_title}-card-${index}`}
                                        className="relative col-span-1 group h-full"
                                        initial={{ opacity: 0, y: 30 }}
                                        animate={{ opacity: 1, y: 0 }}
                                        transition={{ duration: 0.4, delay: 0.6 + index * 0.1 }}
                                        whileHover={{
                                            y: -4,
                                            scale: 1.01,
                                            transition: { duration: 0.2 }
                                        }}
                                    >
                                        <div className="relative h-full overflow-hidden transition-all duration-300 border-1 shadow-xl bg-gray-800/50 backdrop-blur-sm border-gray-500/50 rounded-xl hover:shadow-blue-500/30 group-hover:border-blue-400/70 group-hover:bg-gray-700/60">
                                            {/* Simplified effects */}
                                            <div className="absolute inset-0 transition-opacity duration-300 opacity-0 bg-gradient-to-br from-blue-400/10 via-transparent to-cyan-400/10 rounded-xl group-hover:opacity-100" />

                                            <Carousel
                                                opts={{
                                                    loop: true,
                                                    startIndex: index,
                                                    watchDrag: false
                                                }}
                                                plugins={[
                                                    Autoplay({
                                                        delay: 8000,
                                                        stopOnInteraction: true
                                                    }),
                                                ]}
                                            >
                                                <div className="relative z-10 flex flex-col h-full">
                                                    {/* Optimized Image Carousel */}
                                                    <div className="relative flex-[3]">

                                                        <div className="z-20 absolute w-full h-full flex items-center justify-center " >
                                                            <motion.div
                                                                whileHover={{ scale: 1.1, rotate: 5 }}
                                                                transition={{ duration: 0.4, type: "spring", stiffness: 300 }}
                                                                className="relative"
                                                            >
                                                                {/* Icon glow effect */}
                                                                <div className="absolute inset-0 bg-blue-400/20 rounded-full blur-lg scale-150"></div>
                                                                <div className="relative bg-gradient-to-br from-blue-500/20 to-purple-500/20 p-4 rounded-full border border-white/20 backdrop-blur-sm">
                                                                    <IconSwitcher key={`${topic_title}-icon-${index}`} index={index} />
                                                                </div>
                                                            </motion.div>
                                                        </div>

                                                        <CarouselContent className="h-full m-0">
                                                            {topic!.images.map((url, idx) => {
                                                                return (
                                                                    <CarouselItem key={idx} className="h-full pl-0">
                                                                        <div className="relative w-full h-full overflow-hidden rounded-lg">
                                                                            <Image
                                                                                src={url}
                                                                                alt={`Illustration for topic_${topic!.id}_${idx}.webp`}
                                                                                width={400}
                                                                                height={400}
                                                                                style={{ width: "100%", height: "100%", objectFit: "cover" }}
                                                                                className="transition-transform duration-300 group-hover:scale-125"
                                                                                quality={85}
                                                                                priority={index === 0}
                                                                                loading="eager"
                                                                            />
                                                                            {/* Simplified overlay */}
                                                                            <div className="absolute inset-0 bg-gradient-to-t from-black/30 via-transparent to-transparent" />
                                                                        </div>
                                                                    </CarouselItem>
                                                                )
                                                            })}
                                                        </CarouselContent>



                                                    </div>

                                                    {/* Enhanced Content Section - Takes 35% of height */}
                                                    <div className="flex flex-col items-center justify-center flex-[2]">



                                                        {/* Enhanced text section with staggered animation */}
                                                        <motion.div
                                                            key={`${topic_title}-text-${index}`}
                                                            className="w-full flex-1 flex items-center justify-center"
                                                            initial={{ opacity: 0, y: 20 }}
                                                            animate={{ opacity: 1, y: 0 }}
                                                            transition={{
                                                                delay: 1.2 + index * 0.1,
                                                                duration: 0.8,
                                                                ease: "easeOut"
                                                            }}
                                                        >
                                                            <KeywordHighlighter
                                                                text={questions[index].text}
                                                                keywords={questions[index].keywords}
                                                            />
                                                        </motion.div>
                                                    </div>
                                                </div>
                                            </Carousel>
                                        </div>
                                    </motion.div>
                                );
                            })}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
}

export default NewsCarousel;