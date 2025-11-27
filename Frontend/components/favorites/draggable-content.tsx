'use client';

import { useState, useEffect, useRef } from 'react';
import { motion } from 'framer-motion';
import { Item } from '@/utils/types';
import DraggableItem from './draggable-item';

interface ItemPositions {
  [key: string]: { x: number; y: number };
}

interface DraggableContentProps {
  items: Item[];
  showFavorites: boolean;
  showDelete: React.Dispatch<React.SetStateAction<boolean>>;
  showAdd: React.Dispatch<React.SetStateAction<boolean>>;
}

const DraggableContent = ({ items, showFavorites, showDelete, showAdd }: DraggableContentProps) => {
  const [positions, setPositions] = useState<ItemPositions>({});
  const [scale, setScale] = useState(1 / 3);
  const [views, setViews] = useState([]);
  const [currentView, setCurrentView] = useState(0);
  const containerRef = useRef<HTMLDivElement>(null);

  // Generate grid positions for new items
  const generateGridPosition = (index: number) => {
    const itemsPerRow = 3;
    const itemWidth = 320;
    const itemHeight = 400;
    const padding = 50;

    const row = Math.floor(index / itemsPerRow);
    const col = index % itemsPerRow;

    return {
      x: padding + col * (itemWidth + 40),
      y: padding + row * (itemHeight + 40)
    };
  };

  // Load positions from localStorage on mount
  useEffect(() => {
    const savedPositions = localStorage.getItem('favorites-positions');
    if (savedPositions) {
      try {
        const parsed = JSON.parse(savedPositions);
        // Initialize positions with saved positions
        const initialPositions: ItemPositions = { ...parsed };

        // Add any new items that aren't in the saved positions
        items.forEach((item) => {
          const itemId = item.content_type + item.content_id;
          if (!initialPositions[itemId]) {
            initialPositions[itemId] = { x: 0, y: 0 }; // Set default position to (0,0)
          }
        });

        setPositions(initialPositions);
      } catch (error) {
        console.error('Error parsing saved positions:', error);
        initializePositions();
      }
    } else {
      initializePositions();
    }
  }, [items]);

  const initializePositions = () => {
    const initialPositions: ItemPositions = {};
    items.forEach((item) => {
      const itemId = item.content_type + item.content_id;
      initialPositions[itemId] = { x: 0, y: 0 }; // Set default position to (0,0)
    });
    setPositions(initialPositions);
  };

  // Save positions to localStorage whenever they change
  useEffect(() => {
    if (Object.keys(positions).length > 0) {
      localStorage.setItem('favorites-positions', JSON.stringify(positions));
    }
  }, [positions]);

  const handleDrag = (itemId: string, newPosition: { x: number; y: number }) => {
    setPositions(prev => ({
      ...prev,
      [itemId]: newPosition
    }));
  };

  const resetPositions = () => {
    const resetPositions: ItemPositions = {};
    items.forEach((item, itemIndex) => {
      const itemId = item.content_type + item.content_id;
      resetPositions[itemId] = generateGridPosition(itemIndex);
    });
    setPositions(resetPositions);
    localStorage.removeItem('favorites-positions');
  };

  const toggleScale = () => {
    setScale(prev => prev === 1 ? 1 / 3 : 1);
  };

  if (items.length === 0) {
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
    <div ref={containerRef}
      style={{
        transformOrigin: 'center',
        background: `
            radial-gradient(circle at 2px 2px, rgba(255,255,255,0.2) 1px, transparent 0),
            linear-gradient(135deg, rgba(59, 130, 246, 0.05) 0%, rgba(139, 92, 246, 0.05) 100%)
          `,
        backgroundSize: '25px 25px',
      }}
      className="relative flex flex-1 w-full h-screen overflow-hidden justify-center items-center">

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
          {items.length} {items.length === 1 ? 'item' : 'items'}
        </motion.div>
        <motion.div
          className="px-3 py-2 text-sm font-medium text-green-300 border rounded-lg bg-green-900/30 border-green-700/50 backdrop-blur-sm"
          whileHover={{ scale: 1.05 }}
          transition={{ type: "spring", stiffness: 400, damping: 10 }}
        >
          {scale === 1 ? '1x' : '3x'} Scale
        </motion.div>
        <motion.button
          onClick={toggleScale}
          className={`px-3 py-2 text-sm font-medium transition-colors border rounded-lg backdrop-blur-sm ${scale === 3
            ? 'text-orange-300 bg-orange-800/50 border-orange-600/50 hover:bg-orange-700/50'
            : 'text-purple-300 bg-purple-800/50 border-purple-600/50 hover:bg-purple-700/50'
            }`}
          whileHover={{ scale: 1.05 }}
          whileTap={{ scale: 0.95 }}
          transition={{ type: "spring", stiffness: 400, damping: 10 }}
        >
          {scale === 1 ? 'Zoom 3x' : 'Zoom 1x'}
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
        💡 Drag items to organize • Toggle scale with button
      </motion.div>

      <div
        style={{
          position: 'absolute',
          top: '50%',
          left: '50%',
          transform: `translate(-50%, -50%) scale(${scale})`,
          width: '300%',
          height: '300%',
        }}
        className="grid grid-cols-3 grid-rows-3 gap-4">
        {Array.from({ length: 9 }).map((_, index) => {
          return (
            <div key={index} className="border-2 border-blue-500 w-full h-full">
              <div

                className="relative w-full h-full"
              >
                {items.map((item, index) => {
                  const itemId = item.content_type + item.content_id;
                  const position = positions[itemId] || generateGridPosition(index);

                  return (
                    <DraggableItem
                      key={itemId}
                      id={itemId}
                      item={item}
                      position={position}
                      onDrag={handleDrag}
                      showFavorites={showFavorites}
                      showDelete={showDelete}
                      showAdd={showAdd}
                      scale={scale}
                    />
                  );
                })}
              </div>
            </div>
          )
        })}

      </div>

      {/* Draggable Container */}


    </div>
  );
};

export default DraggableContent; 