import React, { useEffect, useState } from "react";
import { Question, Topic } from "@/utils/types";
import { Carousel, CarouselContent, CarouselItem } from "./ui/carousel";
import Autoplay from "embla-carousel-autoplay";
import { useGlobalState } from "../src/contexts/GlobalStateContext";
import { Globe, Heart, Newspaper, ChevronLeft, ChevronRight } from "lucide-react";
import Image from "next/image";
import { motion } from "framer-motion";

/* STYLES */
import "../styles/newsmain.css";
import "../styles/page.css";

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

    const IconSwitcher = ({ index }: { index: number }) => {
        const [currentIconIndex, setCurrentIconIndex] = useState(index);
        const icons = [
            { Icon: Heart, color: "text-blue-300" },
            { Icon: Globe, color: "text-cyan-300" },
            { Icon: Newspaper, color: "text-blue-400" }
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
            <div className="flex items-center justify-center w-full">
                <motion.div
                    className="p-2 transition-all duration-500 ease-in-out transform border rounded-full shadow-lg bg-white/5 backdrop-blur-sm border-blue-400/40 shadow-blue-500/50"
                    whileHover={{ scale: 1.1, rotate: 5 }}
                    transition={{ duration: 0.3 }}
                >
                    <Icon
                        strokeWidth={2.5}
                        style={{ width: 24, height: 24 }}
                        className={`${color} drop-shadow-lg transition-all duration-500`}
                    />
                </motion.div>
            </div>
        );
    };

    function KeywordHighlighter({ text, keywords }: { text: string; keywords: string }) {
        const highlightKeyword = (word: string) => {
            word = word.replace(/[^a-zA-Z0-9]/g, '');
            return keywords.includes(word)
                ? 'bg-gradient-to-r from-blue-300 via-cyan-300 to-blue-400 text-transparent bg-clip-text font-bold'
                : '';
        };

        return (
            <div className="w-full px-3">
                <div className="inline-block text-center break-words whitespace-normal">
                    {text.split(' ').map((word, index) => (
                        <span
                            key={index}
                            className={`
                                ${highlightKeyword(word)} 
                                text-base font-medium text-center text-gray-100
                                mr-1
                                inline-block
                                break-words 
                                overflow-wrap-normal
                                transition-all duration-300
                                drop-shadow-sm
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
        <div className="flex flex-col w-screen h-screen items-center justify-center pb-6 px-12 via-blue-950/30 to-black/60 relative">
            {/* Ultra-Modern Icon-Centric Navigation */}
            <motion.div
                className="absolute left-8 top-1/2 transform -translate-y-1/2 z-20"
                whileHover={{ scale: 1.1 }}
                whileTap={{ scale: 0.9 }}
            >
                <div
                    onClick={() => navigateToTab('prev')}
                    className="group relative w-16 h-16 cursor-pointer flex items-center justify-center"
                >
                    {/* Layered Icon Background Effects */}
                    <motion.div
                        className="absolute inset-0"
                        animate={{ rotate: 360 }}
                        transition={{ duration: 20, repeat: Infinity, ease: "linear" }}
                    >
                        <ChevronLeft
                            className="w-16 h-16 text-slate-700/20 absolute inset-0"
                            strokeWidth={0.5}
                        />
                    </motion.div>

                    <motion.div
                        className="absolute inset-0"
                        animate={{ rotate: -360 }}
                        transition={{ duration: 15, repeat: Infinity, ease: "linear" }}
                    >
                        <ChevronLeft
                            className="w-14 h-14 text-blue-900/30 absolute inset-1"
                            strokeWidth={0.8}
                        />
                    </motion.div>

                    {/* Orbital Elements */}
                    <motion.div
                        className="absolute inset-0"
                        animate={{ rotate: 360 }}
                        transition={{ duration: 8, repeat: Infinity, ease: "linear" }}
                    >
                        <div className="absolute w-1 h-1 bg-blue-400/60 rounded-full top-0 left-1/2 transform -translate-x-1/2"
                            style={{ filter: 'blur(0.5px)' }} />
                        <div className="absolute w-1 h-1 bg-cyan-400/40 rounded-full bottom-0 left-1/2 transform -translate-x-1/2"
                            style={{ filter: 'blur(0.5px)' }} />
                    </motion.div>

                    <motion.div
                        className="absolute inset-0"
                        animate={{ rotate: -360 }}
                        transition={{ duration: 12, repeat: Infinity, ease: "linear" }}
                    >
                        <div className="absolute w-0.5 h-0.5 bg-blue-300/80 rounded-full top-1/4 right-0"
                            style={{ filter: 'blur(0.3px)' }} />
                        <div className="absolute w-0.5 h-0.5 bg-cyan-300/60 rounded-full bottom-1/4 left-0"
                            style={{ filter: 'blur(0.3px)' }} />
                    </motion.div>

                    {/* Central Glass Morphism Container */}
                    <motion.div
                        className="absolute inset-2 rounded-full bg-slate-900/20 backdrop-blur-md border border-slate-600/20"
                        whileHover={{
                            scale: 1.1,
                            backgroundColor: "rgba(15, 23, 42, 0.4)",
                            borderColor: "rgba(100, 116, 139, 0.4)"
                        }}
                        transition={{ duration: 0.3 }}
                    >
                        {/* Inner glow effect */}
                        <motion.div
                            className="absolute inset-0 rounded-full bg-gradient-to-br from-blue-500/10 via-transparent to-cyan-500/10"
                            whileHover={{ opacity: 1 }}
                            initial={{ opacity: 0 }}
                            transition={{ duration: 0.3 }}
                        />
                    </motion.div>

                    {/* Primary Icon with Advanced Effects */}
                    <motion.div
                        className="relative z-10"
                        whileHover={{
                            scale: 1.2,
                            x: -2
                        }}
                        transition={{ duration: 0.3, ease: "easeOut" }}
                    >
                        {/* Icon shadow/blur layer */}
                        <ChevronLeft
                            className="absolute w-8 h-8 text-blue-400/40 blur-sm"
                            strokeWidth={3}
                        />

                        {/* Main icon */}
                        <ChevronLeft
                            className="relative w-8 h-8 text-slate-200 group-hover:text-white transition-all duration-300"
                            strokeWidth={2.5}
                            style={{
                                filter: 'drop-shadow(0 0 12px rgba(59, 130, 246, 0.6)) drop-shadow(0 0 4px rgba(148, 163, 184, 0.8))',
                            }}
                        />

                        {/* Icon highlight layer */}
                        <motion.div
                            className="absolute inset-0"
                            whileHover={{ opacity: 1 }}
                            initial={{ opacity: 0 }}
                            transition={{ duration: 0.3 }}
                        >
                            <ChevronLeft
                                className="w-8 h-8 text-cyan-300/60"
                                strokeWidth={1.5}
                            />
                        </motion.div>
                    </motion.div>

                    {/* Hover Ripple Effect */}
                    <motion.div
                        className="absolute inset-0 rounded-full border-2 border-blue-400/0"
                        whileHover={{
                            scale: [1, 1.5, 1],
                            borderColor: ["rgba(59, 130, 246, 0)", "rgba(59, 130, 246, 0.6)", "rgba(59, 130, 246, 0)"]
                        }}
                        transition={{ duration: 0.6 }}
                    />
                </div>
            </motion.div>

            <motion.div
                className="absolute right-8 top-1/2 transform -translate-y-1/2 z-20"
                whileHover={{ scale: 1.1 }}
                whileTap={{ scale: 0.9 }}
            >
                <div
                    onClick={() => navigateToTab('next')}
                    className="group relative w-16 h-16 cursor-pointer flex items-center justify-center"
                >
                    {/* Layered Icon Background Effects */}
                    <motion.div
                        className="absolute inset-0"
                        animate={{ rotate: 360 }}
                        transition={{ duration: 20, repeat: Infinity, ease: "linear" }}
                    >
                        <ChevronRight
                            className="w-16 h-16 text-slate-700/20 absolute inset-0"
                            strokeWidth={0.5}
                        />
                    </motion.div>

                    <motion.div
                        className="absolute inset-0"
                        animate={{ rotate: -360 }}
                        transition={{ duration: 15, repeat: Infinity, ease: "linear" }}
                    >
                        <ChevronRight
                            className="w-14 h-14 text-blue-900/30 absolute inset-1"
                            strokeWidth={0.8}
                        />
                    </motion.div>

                    {/* Orbital Elements */}
                    <motion.div
                        className="absolute inset-0"
                        animate={{ rotate: 360 }}
                        transition={{ duration: 8, repeat: Infinity, ease: "linear" }}
                    >
                        <div className="absolute w-1 h-1 bg-blue-400/60 rounded-full top-0 left-1/2 transform -translate-x-1/2"
                            style={{ filter: 'blur(0.5px)' }} />
                        <div className="absolute w-1 h-1 bg-cyan-400/40 rounded-full bottom-0 left-1/2 transform -translate-x-1/2"
                            style={{ filter: 'blur(0.5px)' }} />
                    </motion.div>

                    <motion.div
                        className="absolute inset-0"
                        animate={{ rotate: -360 }}
                        transition={{ duration: 12, repeat: Infinity, ease: "linear" }}
                    >
                        <div className="absolute w-0.5 h-0.5 bg-blue-300/80 rounded-full top-1/4 right-0"
                            style={{ filter: 'blur(0.3px)' }} />
                        <div className="absolute w-0.5 h-0.5 bg-cyan-300/60 rounded-full bottom-1/4 left-0"
                            style={{ filter: 'blur(0.3px)' }} />
                    </motion.div>

                    {/* Central Glass Morphism Container */}
                    <motion.div
                        className="absolute inset-2 rounded-full bg-slate-900/20 backdrop-blur-md border border-slate-600/20"
                        whileHover={{
                            scale: 1.1,
                            backgroundColor: "rgba(15, 23, 42, 0.4)",
                            borderColor: "rgba(100, 116, 139, 0.4)"
                        }}
                        transition={{ duration: 0.3 }}
                    >
                        {/* Inner glow effect */}
                        <motion.div
                            className="absolute inset-0 rounded-full bg-gradient-to-br from-blue-500/10 via-transparent to-cyan-500/10"
                            whileHover={{ opacity: 1 }}
                            initial={{ opacity: 0 }}
                            transition={{ duration: 0.3 }}
                        />
                    </motion.div>

                    {/* Primary Icon with Advanced Effects */}
                    <motion.div
                        className="relative z-10"
                        whileHover={{
                            scale: 1.2,
                            x: 2
                        }}
                        transition={{ duration: 0.3, ease: "easeOut" }}
                    >
                        {/* Icon shadow/blur layer */}
                        <ChevronRight
                            className="absolute w-8 h-8 text-blue-400/40 blur-sm"
                            strokeWidth={3}
                        />

                        {/* Main icon */}
                        <ChevronRight
                            className="relative w-8 h-8 text-slate-200 group-hover:text-white transition-all duration-300"
                            strokeWidth={2.5}
                            style={{
                                filter: 'drop-shadow(0 0 12px rgba(59, 130, 246, 0.6)) drop-shadow(0 0 4px rgba(148, 163, 184, 0.8))',
                            }}
                        />

                        {/* Icon highlight layer */}
                        <motion.div
                            className="absolute inset-0"
                            whileHover={{ opacity: 1 }}
                            initial={{ opacity: 0 }}
                            transition={{ duration: 0.3 }}
                        >
                            <ChevronRight
                                className="w-8 h-8 text-cyan-300/60"
                                strokeWidth={1.5}
                            />
                        </motion.div>
                    </motion.div>

                    {/* Hover Ripple Effect */}
                    <motion.div
                        className="absolute inset-0 rounded-full border-2 border-blue-400/0"
                        whileHover={{
                            scale: [1, 1.5, 1],
                            borderColor: ["rgba(59, 130, 246, 0)", "rgba(59, 130, 246, 0.6)", "rgba(59, 130, 246, 0)"]
                        }}
                        transition={{ duration: 0.6 }}
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
                                {/* Professional Blue halo layers - Darker tones */}
                                <div className="absolute inset-0 flex items-center justify-center">
                                    <h2
                                        className="text-3xl font-bold tracking-tight text-slate-400/60 blur-sm"
                                        style={{
                                            filter: 'blur(6px)',
                                        }}
                                    >
                                        {topic_title}
                                    </h2>
                                </div>
                                
                                <div className="absolute inset-0 flex items-center justify-center">
                                    <h2
                                        className="text-3xl font-bold tracking-tight text-blue-700/40 blur-md"
                                        style={{
                                            filter: 'blur(10px)',
                                        }}
                                    >
                                        {topic_title}
                                    </h2>
                                </div>
                                <div className="absolute inset-0 flex items-center justify-center">
                                    <h2
                                        className="text-3xl font-bold tracking-tight text-slate-600/30"
                                        style={{
                                            filter: 'blur(16px)',
                                        }}
                                    >
                                        {topic_title}
                                    </h2>
                                </div>
                                <div className="absolute inset-0 flex items-center justify-center">
                                    <h2
                                        className="text-3xl font-bold tracking-tight text-blue-800/25"
                                        style={{
                                            filter: 'blur(24px)',
                                        }}
                                    >
                                        {topic_title}
                                    </h2>
                                </div>

                                {/* Professional main title text */}
                                <h2 className="relative text-3xl font-bold leading-none tracking-tight text-center">
                                    <span
                                        className="text-transparent bg-gradient-to-r from-white via-slate-100 to-gray-100 bg-clip-text font-bold"
                                        style={{
                                            textShadow: `
                                                0 0 15px rgba(51, 65, 85, 0.7),
                                                0 0 30px rgba(51, 65, 85, 0.4),
                                                0 0 45px rgba(30, 58, 138, 0.3),
                                                0 0 60px rgba(30, 58, 138, 0.2)
                                            `,
                                            filter: 'drop-shadow(0 0 20px rgba(51, 65, 85, 0.6)) drop-shadow(0 0 40px rgba(30, 58, 138, 0.3))'
                                        }}
                                    >
                                        {topic_title}
                                    </span>
                                </h2>
                            </motion.div>
                        </div>

                        {/* Center section: Main title */}


                        {/* Right section: Decorative elements */}
                        <div className="flex items-center space-x-4">
                            {/* Professional minimalist dots */}
                            <motion.div
                                className="flex items-center space-x-2"
                                initial={{ opacity: 0, x: 20 }}
                                animate={{ opacity: 1, x: 0 }}
                                transition={{ delay: 1.4, duration: 0.6 }}
                            >
                                {[0, 1, 2].map((i) => (
                                    <motion.div
                                        key={i}
                                        className="w-1.5 h-1.5 rounded-full bg-slate-400/70"
                                        animate={{
                                            scale: [1, 1.3, 1],
                                            opacity: [0.5, 0.8, 0.5]
                                        }}
                                        transition={{
                                            duration: 4,
                                            repeat: Infinity,
                                            delay: i * 0.5,
                                            ease: "easeInOut"
                                        }}
                                        style={{
                                            boxShadow: `
                                                    0 0 8px rgba(100, 116, 139, 0.6),
                                                    0 0 16px rgba(51, 65, 85, 0.4)
                                                `
                                        }}
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
                                        className="relative col-span-1 group  h-full"
                                        initial={{ opacity: 0, y: 50 }}
                                        animate={{ opacity: 1, y: 0 }}
                                        transition={{ duration: 0.6, delay: 0.8 + index * 0.2 }}
                                        whileHover={{
                                            y: -8,
                                            scale: 1.02,
                                            transition: { duration: 0.3 }
                                        }}
                                    >
                                        <div className="relative h-full overflow-hidden transition-all duration-500 border-2 shadow-2xl bg-gray-800/50 backdrop-blur-3xl border-gray-500/50 rounded-xl hover:shadow-blue-500/50 group-hover:border-blue-400/70 group-hover:bg-gray-700/60">
                                            {/* Enhanced holographic effects */}
                                            <div className="absolute inset-0 transition-opacity duration-500 opacity-0 bg-gradient-to-br from-blue-400/20 via-cyan-400/10 to-purple-400/20 rounded-xl group-hover:opacity-100" />
                                            <div className="absolute inset-0 bg-gradient-to-t from-blue-500/20 via-transparent to-white/5 rounded-xl" />

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
                                                <div className="relative z-10 flex flex-col h-full px-4 py-4 space-y-4">
                                                    {/* Enhanced Image Carousel - Takes 65% of height */}
                                                    <div className="relative flex-[3] overflow-hidden transition-all duration-500 border-2 shadow-xl rounded-lg bg-gray-900/60 backdrop-blur-sm border-blue-400/40 group-hover:shadow-blue-500/60 group-hover:border-cyan-400/60">
                                                        <CarouselContent className="h-full m-0">
                                                            {topic!.images.map((url, idx) => {
                                                                return (
                                                                    <CarouselItem key={idx} className="h-full pl-0">
                                                                        <div className="relative w-full h-full overflow-hidden rounded-lg">
                                                                            <Image
                                                                                src={url}
                                                                                alt={`Illustration for topic_${topic!.id}_${idx}.webp`}
                                                                                width={500}
                                                                                height={500}
                                                                                style={{ width: "100%", height: "100%", objectFit: "cover" }}
                                                                                className="transition-transform duration-700 group-hover:scale-105"
                                                                                quality={100}
                                                                                priority={true}
                                                                            />
                                                                            {/* Enhanced image overlay for better contrast */}
                                                                            <div className="absolute inset-0 bg-gradient-to-t from-black/40 via-transparent to-transparent" />
                                                                            <div className="absolute inset-0 bg-gradient-to-br from-blue-500/10 via-transparent to-cyan-500/10" />
                                                                        </div>
                                                                    </CarouselItem>
                                                                )
                                                            })}
                                                        </CarouselContent>
                                                    </div>

                                                    {/* Enhanced Content Section - Takes 35% of height */}
                                                    <div className="flex flex-col items-center justify-center flex-[2] space-y-3">
                                                        <motion.div
                                                            whileHover={{ scale: 1.05 }}
                                                            transition={{ duration: 0.3 }}
                                                        >
                                                            <IconSwitcher key={`${topic_title}-icon-${index}`} index={index} />
                                                        </motion.div>

                                                        <motion.div
                                                            key={`${topic_title}-text-${index}`}
                                                            className="text-center"
                                                            initial={{ opacity: 0 }}
                                                            animate={{ opacity: 1 }}
                                                            transition={{ delay: 1.2 + index * 0.1 }}
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