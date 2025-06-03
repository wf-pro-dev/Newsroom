'use client';

import { useState, useEffect, useRef } from 'react';
import { motion, PanInfo, useMotionValue } from 'framer-motion';
import { Favourite, Article, Video } from '@/utils/types';
import NewsArticle from '../core/newsarticle';
import NewsVideo from '../core/newsvideo';

interface DraggableItemProps {
  item: Favourite;
  position: { x: number; y: number };
  onDrag: (id: string, position: { x: number; y: number }) => void;
  showFavorites: boolean;
  showDelete: React.Dispatch<React.SetStateAction<boolean>>;
  showAdd: React.Dispatch<React.SetStateAction<boolean>>;
  scale: number;
}

interface Position {
  x: number;
  y: number;
}

interface ItemPositions {
  [key: string]: Position;
}

const DraggableItem = ({ item, position, onDrag, showFavorites, showDelete, showAdd, scale }: DraggableItemProps) => {
  const [isDragging, setIsDragging] = useState(false);

  const handleDragStart = () => {
    setIsDragging(true);
  };

  const handleDragEnd = () => {
    setIsDragging(false);
  };

  const handleDragMove = (event: MouseEvent | TouchEvent | PointerEvent, info: PanInfo) => {
    const newPosition = {
      x: position.x + info.delta.x / scale,
      y: position.y + info.delta.y / scale,
    };
    onDrag(item.type + item.id, newPosition);
  };

  return (
    <motion.div
      drag
      dragMomentum={false}
      dragElastic={0.1}
      onDragStart={handleDragStart}
      onDragEnd={handleDragEnd}
      onDrag={handleDragMove}
      initial={{ x: position.x, y: position.y }}
      animate={{ 
        x: position.x, 
        y: position.y,
        scale: isDragging ? 1.05 : 1,
        rotate: isDragging ? 2 : 0,
        zIndex: isDragging ? 50 : 10
      }}
      transition={{ 
        type: "spring", 
        stiffness: 300, 
        damping: 30,
        mass: 0.8
      }}
      whileHover={{ 
        scale: 1.02,
        transition: { duration: 0.2 }
      }}
      style={{
        position: 'absolute',
        cursor: isDragging ? 'grabbing' : 'grab'
      }}
      className={`${isDragging ? 'shadow-2xl' : 'shadow-lg'} transition-shadow duration-200`}
    >
      <div className={`relative ${item.type === 'video' ? 'w-96 h-64' : 'w-80 h-96'}`}>
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
          {item.type === "article" ? (
            <NewsArticle
              article={item as Article}
              showFavorites={showFavorites}
              showDelete={showDelete}
              showAdd={showAdd}
            />
          ) : (
            <NewsVideo
              video={item as Video}
              showFavorites={showFavorites}
              showDelete={showDelete}
              showAdd={showAdd}
            />
          )}
        </div>
      </div>
    </motion.div>
  );
};

interface DraggableContentProps {
  favourites: Favourite[];
  showFavorites: boolean;
  showDelete: React.Dispatch<React.SetStateAction<boolean>>;
  showAdd: React.Dispatch<React.SetStateAction<boolean>>;
}

const DraggableContent = ({ favourites, showFavorites, showDelete, showAdd }: DraggableContentProps) => {
  const [positions, setPositions] = useState<ItemPositions>({});
  const [scale, setScale] = useState(1);
  const [panX, setPanX] = useState(0);
  const [panY, setPanY] = useState(0);
  const containerRef = useRef<HTMLDivElement>(null);

  // Framer Motion values for smooth zoom and pan
  const scaleMotionValue = useMotionValue(1);
  const panXMotionValue = useMotionValue(0);
  const panYMotionValue = useMotionValue(0);

  // Generate grid positions for new items
  const generateGridPosition = (index: number): Position => {
    const itemsPerRow = 3;
    const itemWidth = 320; // Width + margin
    const itemHeight = 400; // Height + margin
    const startX = 0;
    const startY = 0;

    const row = Math.floor(index / itemsPerRow);
    const col = index % itemsPerRow;

    return {
      x: startX + col * itemWidth,
      y: startY + row * itemHeight,
    };
  };

  // Load positions from localStorage on mount
  useEffect(() => {
    const savedPositions = localStorage.getItem('draggable-favorites-positions');
    if (savedPositions) {
      setPositions(JSON.parse(savedPositions));
    } else {
      // Initialize positions for items that don't have saved positions
      const initialPositions: ItemPositions = {};
      favourites.forEach((item, index) => {
        const itemId = item.type + item.id;
        initialPositions[itemId] = generateGridPosition(index);
      });
      setPositions(initialPositions);
    }
  }, []);

  // Update positions for new items
  useEffect(() => {
    const newPositions = { ...positions };
    let hasNewItems = false;

    favourites.forEach((item, index) => {
      const itemId = item.type + item.id;
      if (!newPositions[itemId]) {
        newPositions[itemId] = generateGridPosition(index);
        hasNewItems = true;
      }
    });

    if (hasNewItems) {
      setPositions(newPositions);
    }
  }, [favourites]);

  // Save positions to localStorage whenever they change
  useEffect(() => {
    if (Object.keys(positions).length > 0) {
      localStorage.setItem('draggable-favorites-positions', JSON.stringify(positions));
    }
  }, [positions]);

  // Handle mouse wheel zoom
  useEffect(() => {
    const handleWheel = (e: WheelEvent) => {
      if (e.ctrlKey || e.metaKey) {
        e.preventDefault();
        const delta = e.deltaY > 0 ? 0.9 : 1.1;
        const newScale = Math.max(0.1, Math.min(3, scale * delta));
        setScale(newScale);
        scaleMotionValue.set(newScale);
      }
    };

    const container = containerRef.current;
    if (container) {
      container.addEventListener('wheel', handleWheel, { passive: false });
      return () => container.removeEventListener('wheel', handleWheel);
    }
  }, [scale, scaleMotionValue]);

  // Handle touch pinch-to-zoom
  useEffect(() => {
    let initialDistance = 0;
    let initialScale = 1;

    const getTouchDistance = (touches: TouchList) => {
      const touch1 = touches[0];
      const touch2 = touches[1];
      return Math.sqrt(
        Math.pow(touch2.clientX - touch1.clientX, 2) + 
        Math.pow(touch2.clientY - touch1.clientY, 2)
      );
    };

    const handleTouchStart = (e: TouchEvent) => {
      if (e.touches.length === 2) {
        initialDistance = getTouchDistance(e.touches);
        initialScale = scale;
      }
    };

    const handleTouchMove = (e: TouchEvent) => {
      if (e.touches.length === 2) {
        e.preventDefault();
        const currentDistance = getTouchDistance(e.touches);
        const scaleRatio = currentDistance / initialDistance;
        const newScale = Math.max(0.1, Math.min(3, initialScale * scaleRatio));
        setScale(newScale);
        scaleMotionValue.set(newScale);
      }
    };

    const container = containerRef.current;
    if (container) {
      container.addEventListener('touchstart', handleTouchStart, { passive: false });
      container.addEventListener('touchmove', handleTouchMove, { passive: false });
      return () => {
        container.removeEventListener('touchstart', handleTouchStart);
        container.removeEventListener('touchmove', handleTouchMove);
      };
    }
  }, [scale, scaleMotionValue]);

  const handleDrag = (itemId: string, newPosition: Position) => {
    setPositions(prev => ({
      ...prev,
      [itemId]: newPosition,
    }));
  };

  const resetPositions = () => {
    const resetPositions: ItemPositions = {};
    favourites.forEach((item, index) => {
      const itemId = item.type + item.id;
      resetPositions[itemId] = generateGridPosition(index);
    });
    setPositions(resetPositions);
    localStorage.removeItem('draggable-favorites-positions');
  };

  const resetZoom = () => {
    setScale(1);
    setPanX(0);
    setPanY(0);
    scaleMotionValue.set(1);
    panXMotionValue.set(0);
    panYMotionValue.set(0);
  };

  const handleCanvasPan = (event: MouseEvent | TouchEvent | PointerEvent, info: PanInfo) => {
    const newPanX = panX + info.delta.x;
    const newPanY = panY + info.delta.y;
    setPanX(newPanX);
    setPanY(newPanY);
    panXMotionValue.set(newPanX);
    panYMotionValue.set(newPanY);
  };

  if (favourites.length === 0) {
    return (
      <motion.div 
        className="flex items-center justify-center flex-1 h-screen"
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.5 }}
      >
        <div className="flex flex-col items-center justify-center p-8 text-center h-fit feature-card">
          <motion.svg 
            className="w-16 h-16 mb-4 text-gray-400" 
            fill="none" 
            stroke="currentColor" 
            viewBox="0 0 24 24"
            animate={{ 
              scale: [1, 1.1, 1],
              opacity: [0.5, 1, 0.5]
            }}
            transition={{ 
              duration: 2,
              repeat: Infinity,
              ease: "easeInOut"
            }}
          >
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z" />
          </motion.svg>
          <h3 className="mb-2 text-xl font-semibold text-gray-200">No Favorites Yet</h3>
          <p className="text-gray-400">Start adding articles to your favorites to see them here.</p>
          <p className="text-gray-400">You&apos;ll be able to drag them around to organize your collection!</p>
        </div>
      </motion.div>
    );
  }

  return (
    <div className="relative flex-1 overflow-hidden">
      {/* Control Panel */}
      <motion.div 
        className="absolute z-30 flex space-x-2 top-4 right-4"
        initial={{ opacity: 0, y: -20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.5, delay: 0.2 }}
      >
        <motion.div 
          className="px-3 py-2 text-sm font-medium text-blue-300 border rounded-lg bg-blue-900/30 border-blue-700/50 backdrop-blur-sm"
          whileHover={{ scale: 1.05 }}
          transition={{ type: "spring", stiffness: 400, damping: 10 }}
        >
          {favourites.length} {favourites.length === 1 ? 'item' : 'items'}
        </motion.div>
        <motion.div 
          className="px-3 py-2 text-sm font-medium text-green-300 border rounded-lg bg-green-900/30 border-green-700/50 backdrop-blur-sm"
          whileHover={{ scale: 1.05 }}
          transition={{ type: "spring", stiffness: 400, damping: 10 }}
        >
          {Math.round(scale * 100)}%
        </motion.div>
        <motion.button
          onClick={resetZoom}
          className="px-3 py-2 text-sm font-medium text-purple-300 transition-colors border rounded-lg bg-purple-800/50 border-purple-600/50 backdrop-blur-sm hover:bg-purple-700/50"
          whileHover={{ scale: 1.05 }}
          whileTap={{ scale: 0.95 }}
          transition={{ type: "spring", stiffness: 400, damping: 10 }}
        >
          Reset Zoom
        </motion.button>
        <motion.button
          onClick={resetPositions}
          className="px-3 py-2 text-sm font-medium text-gray-300 transition-colors border rounded-lg bg-gray-800/50 border-gray-600/50 backdrop-blur-sm hover:bg-gray-700/50"
          whileHover={{ scale: 1.05 }}
          whileTap={{ scale: 0.95 }}
          transition={{ type: "spring", stiffness: 400, damping: 10 }}
        >
          Reset Layout
        </motion.button>
      </motion.div>

      {/* Instructions */}
      <motion.div 
        className="absolute z-30 px-4 py-2 text-sm text-gray-300 border rounded-lg top-4 left-4 bg-gray-800/50 border-gray-600/50 backdrop-blur-sm"
        initial={{ opacity: 0, x: -20 }}
        animate={{ opacity: 1, x: 0 }}
        transition={{ duration: 0.5, delay: 0.1 }}
      >
        💡 Drag items • Ctrl+Scroll to zoom • Pinch to zoom • Drag canvas to pan
      </motion.div>

      {/* Draggable Canvas Container */}
      <motion.div
        ref={containerRef}
        className="relative w-full min-h-screen overflow-hidden"
        style={{ 
          height: '100vh',
          background: `
            radial-gradient(circle at 1px 1px, rgba(255,255,255,0.5) 1px, transparent 0),
            linear-gradient(135deg, rgba(0,0,0,0.1) 0%, rgba(0,0,0,0.3) 100%)
          `,
          backgroundSize: '20px 20px'
        }}
        drag
        dragConstraints={false}
        dragElastic={0.05}
        onDrag={handleCanvasPan}
        whileDrag={{ cursor: 'grabbing' }}
      >
        {/* Zoomable Content Container */}
        <motion.div
          style={{
            scale: scaleMotionValue,
            x: panXMotionValue,
            y: panYMotionValue,
            transformOrigin: 'center center'
          }}
          className="relative w-full h-full"
          animate={{
            scale: scale,
            x: panX,
            y: panY
          }}
          transition={{
            type: "spring",
            stiffness: 300,
            damping: 30
          }}
        >
          {favourites.map((item, index) => {
            const itemId = item.type + item.id;
            const position = positions[itemId] || { x: 0, y: 0 };

            return (
              <motion.div
                key={itemId}
                initial={{ opacity: 0, scale: 0.8 }}
                animate={{ opacity: 1, scale: 1 }}
                transition={{ 
                  duration: 0.4,
                  delay: index * 0.1,
                  type: "spring",
                  stiffness: 200,
                  damping: 20
                }}
              >
                <DraggableItem
                  item={item}
                  position={position}
                  onDrag={handleDrag}
                  showFavorites={showFavorites}
                  showDelete={showDelete}
                  showAdd={showAdd}
                  scale={scale}
                />
              </motion.div>
            );
          })}
        </motion.div>
      </motion.div>
    </div>
  );
};

export default DraggableContent; 