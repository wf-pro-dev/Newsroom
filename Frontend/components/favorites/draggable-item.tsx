import { Article, Item, Video } from "@/utils/types";
import NewsArticle from "../core/newsarticle";
import Thumbnail from "../core/thumbnail";
import { motion } from 'framer-motion';
import { useRef, useState } from "react";
import { useGlobalState } from "@/src/contexts/GlobalStateContext";
import Draggable, { DraggableData, DraggableEvent } from 'react-draggable';

interface DraggableItemProps {
    id: string;
    item: Item;
    position: { x: number; y: number };
    onDrag: (id: string, position: { x: number; y: number }) => void;
    showFavorites: boolean;
    showDelete: React.Dispatch<React.SetStateAction<boolean>>;
    showAdd: React.Dispatch<React.SetStateAction<boolean>>;
    scale: number;
}

const DraggableItem = ({

    item,
    position,
    onDrag,
    showFavorites,
    showDelete,
    showAdd,
    scale
}: DraggableItemProps) => {
    const { favourites } = useGlobalState();
    const [isDragging, setIsDragging] = useState(false);
    const itemRef = useRef<HTMLDivElement>(null);

    const handleDrag = (_e: DraggableEvent, data: DraggableData) => {
        onDrag(item.content_type + item.content_id, {
            x: position.x + data.deltaX / scale,
            y: position.y + data.deltaY / scale
        });
    };

    const content = favourites.find(favourite => favourite.id === item.content_id);

    return (
        <Draggable
            position={position}
            onDrag={handleDrag}
            onStart={() => setIsDragging(true)}
            onStop={() => setIsDragging(false)}
            bounds="parent"
            grid={[10, 10]}
            scale={scale}
            defaultClassName="w-fit"
        >
            <div
                ref={itemRef}
                className={`relative ${isDragging ? 'shadow-2xl' : 'shadow-lg'} transition-shadow duration-200`}
                style={{
                    cursor: isDragging ? 'grabbing' : 'grab'
                }}
            >
                <div className={`relative ${content?.type === 'video' ? 'w-96 h-64' : 'w-80 h-96'}`}>
                    {/* Drag handle */}
                    <motion.div
                        className="absolute z-20 p-1 rounded-lg top-2 right-2 bg-gray-800/80 backdrop-blur-sm"
                        animate={{
                            opacity: isDragging ? 1 : 0.7,
                            scale: isDragging ? 1.1 : 1
                        }}
                        transition={{ duration: 0.2 }}
                    >
                        <svg className="w-4 h-4 text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M7 16V4m0 0L3 8m4-4l4 4m6 0v12m0 0l4-4m-4 4l-4-4" />
                        </svg>
                    </motion.div>

                    {/* Content */}
                    <div className="w-full h-full">
                        {content?.type === "article" ? (
                            <NewsArticle
                                article={content as Article}
                                showFavorites={showFavorites}
                                showDelete={showDelete}
                                showAdd={showAdd}
                            />
                        ) : (
                            <Thumbnail
                                video={content as Video}
                                showFavorites={showFavorites}
                                showDelete={showDelete}
                                showAdd={showAdd}
                            />
                        )}
                    </div>
                </div>
            </div>
        </Draggable>
    );
};

export default DraggableItem;
