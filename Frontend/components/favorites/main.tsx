import { Favourite, Article, Video } from "@/utils/types";
import NewsArticle from "../core/newsarticle";
import NewsVideo from "../core/newsvideo";
import { DayPicker, getDefaultClassNames } from "react-day-picker";
import "react-day-picker/style.css";
import { useState } from "react";
import { Checkbox } from "@/components/ui/checkbox";
import { Label } from "@/components/ui/label";
import { Card } from "@/components/ui/card";
import { Separator } from "@/components/ui/separator";
import { Button } from "@/components/ui/button";
import { cn } from "@/lib/utils";
import { motion } from "framer-motion";
import Thumbnail from "../core/thumbnail";

function FavoriteMain(
    { favourites, showFavorites, showDelete, showAdd, setShowAddToCollection, selectedItems, setSelectedItems }:
        {
            favourites: Favourite[],
            showFavorites: boolean,
            showDelete: React.Dispatch<React.SetStateAction<boolean>>,
            showAdd: React.Dispatch<React.SetStateAction<boolean>>,
            showAddToCollection: boolean,
            setShowAddToCollection: React.Dispatch<React.SetStateAction<boolean>>,
            selectedCollection: number | null,
            setSelectedCollection: React.Dispatch<React.SetStateAction<number | null>>,
            selectedItems: string[],
            setSelectedItems: React.Dispatch<React.SetStateAction<string[]>>
        }) {

    const [isContentSelectable, setIsContentSelectable] = useState<boolean>(false);
    const [selectedDate, setSelectedDate] = useState<Date>(new Date());

    const defaultClassNames = getDefaultClassNames();
    const formatDateHeader = (dateString: string) => {
        const date = new Date(dateString);
        const today = new Date();
        const yesterday = new Date(today);
        yesterday.setDate(yesterday.getDate() - 1);

        if (date.toDateString() === today.toDateString()) {
            return "Today";
        } else if (date.toDateString() === yesterday.toDateString()) {
            return "Yesterday";
        } else {
            return date.toLocaleDateString('en-US', {
                weekday: 'long',
                year: 'numeric',
                month: 'long',
                day: 'numeric'
            });
        }
    };

    const toggleItemSelection = (itemId: string) => {
        setSelectedItems(prev =>
            prev.includes(itemId)
                ? prev.filter(id => id !== itemId)
                : [...prev, itemId]
        );
    };

    // Get dates with content
    const datesWithContent = favourites.map(fav => new Date(fav.favAt || new Date()));

    // Filter favorites for selected date
    const selectedDateFavorites = favourites.filter(fav => {
        const favDate = new Date(fav.favAt || new Date());
        return favDate.toDateString() === selectedDate.toDateString();
    });

    return (
        <div className="flex-1 xl:px-24 2xl:px-40">
            {/* Add to Collection Modal */}


            {favourites.length > 0 ? (
                <div className="flex flex-col gap-8 py-12">
                    {/* Header Section */}
                    <div className="flex items-center justify-between">

                        <div className="relative flex justify-center"
                        >
                            {/* Professional Blue halo layers - Darker tones */}
                            <div className="absolute inset-0 flex items-center justify-center">
                                <h2
                                    className="text-3xl font-bold tracking-tight text-slate-400/60 blur-sm"
                                    style={{
                                        filter: 'blur(6px)',
                                    }}
                                >
                                    {formatDateHeader(selectedDate.toDateString())}
                                </h2>
                            </div>

                            <div className="absolute inset-0 flex items-center justify-center">
                                <h2
                                    className="text-3xl font-bold tracking-tight text-blue-700/40 blur-md"
                                    style={{
                                        filter: 'blur(10px)',
                                    }}
                                >
                                    {formatDateHeader(selectedDate.toDateString())}
                                </h2>
                            </div>

                            <div className="absolute inset-0 flex items-center justify-center">
                                <h2
                                    className="text-3xl font-bold tracking-tight text-slate-600/30"
                                    style={{
                                        filter: 'blur(16px)',
                                    }}
                                >
                                    {formatDateHeader(selectedDate.toDateString())}
                                </h2>
                            </div>

                            <div className="absolute inset-0 flex items-center justify-center">
                                <h2
                                    className="text-3xl font-bold tracking-tight text-blue-800/25"
                                    style={{
                                        filter: 'blur(24px)',
                                    }}
                                >
                                    {formatDateHeader(selectedDate.toDateString())}
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
                                    {formatDateHeader(selectedDate.toDateString())}
                                </span>
                            </h2>
                        </div>
                        <div className="flex items-center space-x-4">
                            <Card className="bg-gray-900/50 border-gray-700/30 backdrop-blur-sm p-4">
                                <div className="flex items-center justify-between">
                                    <div className="flex items-center space-x-4">
                                        <div className="flex items-center space-x-3">
                                            <Checkbox
                                                id="content-selectable"
                                                checked={isContentSelectable}
                                                onCheckedChange={(checked) => setIsContentSelectable(checked === true)}
                                                className="h-5 w-5 rounded border-gray-600 bg-gray-800 hover:bg-gray-700 data-[state=checked]:bg-blue-600 data-[state=checked]:border-blue-600 focus-visible:ring-blue-500"
                                            />
                                            <Label
                                                htmlFor="content-selectable"
                                                className="text-sm font-medium text-gray-300 cursor-pointer select-none"
                                            >
                                                Enable content selection
                                            </Label>
                                        </div>
                                        {isContentSelectable && selectedItems.length > 0 && (
                                            <div className="px-3 py-1 text-xs font-medium text-blue-300 border rounded-full bg-blue-900/30 border-blue-700/50">
                                                {selectedItems.length} selected
                                            </div>
                                        )}
                                    </div>
                                    {isContentSelectable && selectedItems.length > 0 && (
                                        <Button
                                            onClick={() => setShowAddToCollection(true)}
                                            className="bg-blue-600 hover:bg-blue-700 text-white transition-colors"
                                        >
                                            Add to Collection
                                        </Button>
                                    )}
                                </div>
                            </Card>
                            <div className="flex items-center space-x-2">
                                <div className="px-3 py-1 text-sm font-medium text-blue-300 border rounded-full bg-blue-900/30 border-blue-700/50">
                                    {selectedDateFavorites.length} {selectedDateFavorites.length === 1 ? 'item' : 'items'}
                                </div>
                            </div>
                        </div>
                    </div>




                    <Separator className="bg-gradient-to-r from-transparent via-blue-400/50 to-transparent shadow-lg shadow-blue-500/20" />

                    {/* Favorites Grid */}
                    <div className="grid grid-cols-3 gap-6">

                        <Card className="bg-gray-900/50 border-gray-700/30 backdrop-blur-sm col-span-1 row-span-1 min-h-[410px] p-4">
                            <DayPicker
                                animate
                                required
                                mode="single"
                                selected={selectedDate}
                                onSelect={setSelectedDate}



                                className="text-white text-sm "

                                classNames={{


                                    selected: "font-bold",
                                    day: "text-sm",
                                    day_button: "p-2",
                                    chevron: "fill-white",

                                }}

                                modifiers={{
                                    hasContent: datesWithContent
                                }}
                                modifiersStyles={{
                                    hasContent: { color: 'rgb(59 130 246)' }
                                }}




                            />
                        </Card>

                        {selectedDateFavorites.map((obj: Favourite, index) => {
                            const itemId = `${obj.type}-${obj.id}`;
                            const isSelected = selectedItems.includes(itemId);
                            const isArticle = obj.type === "article";

                            if (isArticle) {
                                return (
                                    <div
                                        key={itemId}
                                        className={cn(
                                            "relative transition-all duration-300",
                                            isContentSelectable && "cursor-pointer hover:scale-[1.02]",
                                            isSelected && "ring-2 ring-blue-500"
                                        )}
                                        onClick={isContentSelectable ? () => toggleItemSelection(itemId) : undefined}
                                    >
                                        <NewsArticle
                                            key={`${index}`}
                                            article={obj as Article}
                                            showFavorites={showFavorites}
                                            showDelete={showDelete}
                                            showAdd={showAdd}
                                        />
                                        {isContentSelectable && isSelected && (
                                            <div className="absolute p-1 bg-blue-600 rounded-full top-2 right-2">
                                                <svg className="w-4 h-4 text-white" fill="currentColor" viewBox="0 0 20 20">
                                                    <path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd" />
                                                </svg>
                                            </div>
                                        )}
                                    </div>
                                )
                            } else {
                                return (
                                    <div
                                        key={itemId}
                                        className={cn(
                                            "relative col-span-2 h-[400px] transition-all duration-300",
                                            isContentSelectable && "cursor-pointer hover:scale-[1.02]",
                                            isSelected && "ring-2 ring-blue-500"
                                        )}
                                        onClick={isContentSelectable ? () => toggleItemSelection(itemId) : undefined}
                                    >
                                        <div className="w-full h-full">
                                            <NewsVideo
                                                video={obj as Video}
                                                showFavorites={showFavorites}
                                                showDelete={showDelete}
                                                showAdd={showAdd}
                                            />
                                        </div>
                                        {isContentSelectable && isSelected && (
                                            <div className="absolute p-1 bg-blue-600 rounded-full top-2 right-2">
                                                <svg className="w-4 h-4 text-white" fill="currentColor" viewBox="0 0 20 20">
                                                    <path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd" />
                                                </svg>
                                            </div>
                                        )}
                                    </div>
                                )
                            }
                        })}
                    </div>
                </div>
            ) : (
                <div className="flex items-center justify-center h-screen">
                    <Card className="flex flex-col items-center justify-center p-8 text-center bg-gray-900/50 border-gray-700/30 backdrop-blur-sm">
                        <svg className="w-16 h-16 mb-4 text-gray-400 animate-pulse" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z">
                                <animate
                                    attributeName="stroke"
                                    values="#9333ea;#3b82f6;#ef4444;#9333ea"
                                    dur="4s"
                                    repeatCount="indefinite"
                                />
                            </path>
                        </svg>
                        <h3 className="mb-2 text-xl font-semibold text-gray-200">No Favorites Yet</h3>
                        <p className="text-gray-400">Start adding articles to your favorites</p>
                        <p className="text-gray-400">to see them here.</p>
                    </Card>
                </div>
            )}
        </div>
    )
}

export default FavoriteMain;