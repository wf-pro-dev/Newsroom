import { useState, useCallback, useRef, useEffect, useMemo } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { Favourite } from "@/utils/types";
import { useGlobalState } from "@/src/contexts/GlobalStateContext";
import { createCollection, deleteCollection } from "@/utils/api";
import { X } from "lucide-react";

interface SidebarProps {
    favourites: Favourite[];
    isDraggableMode: boolean;
    onToggleDraggableMode: (bool: boolean | null) => void;
    onAddToCollection: () => void;
    selectedCollection: number | null;
    setSelectedCollection: (collection: number | null) => void;
}

function Sidebar({ favourites, isDraggableMode, selectedCollection, setSelectedCollection, onToggleDraggableMode, onAddToCollection }: SidebarProps) {

    const { collections, setCollections } = useGlobalState();
    const [showNewCollectionForm, setShowNewCollectionForm] = useState(false);
    const [newCollectionName, setNewCollectionName] = useState('');
    const [sidebarOpen, setSidebarOpen] = useState(true);
    const isFirstRender = useRef(true);

    const handleCreateCollection = async () => {
        if (newCollectionName.trim()) {

            createCollection(newCollectionName)
                .then((newCollection) => {
                    setCollections([newCollection, ...collections]);
                })
                .catch((error) => {
                    console.error('Failed to create collection:', error);
                })
                .finally(() => {
                    setNewCollectionName('');
                    setShowNewCollectionForm(false);
                });
        }
    };

    const handleDeleteCollection = (collectionId: number) => {
        deleteCollection(collectionId)
            .then(() => {
                setCollections(collections.filter(collection => collection.id !== collectionId));
            })
            .catch((error) => {
                console.error('Failed to delete collection:', error);
            });
    };

    const CollectionButton = useCallback(() => {
        const sorted_collections = collections.sort((a, b) => a.name.localeCompare(b.name))

        return (
            sorted_collections.map((collection, index) => {
                return (
                    <motion.button
                        key={collection.id}
                        onClick={() => { setSelectedCollection(collection.id); onToggleDraggableMode(true) }}
                        className={`w-full overflow-hidden p-3 text-left rounded-lg transition-all ${selectedCollection === collection.id
                            ? `bg-blue-500/20 border-blue-500/50 text-blue-300 border`
                            : 'bg-gray-800/50 hover:bg-gray-700/50 text-gray-300 hover:text-white'
                            }`}
                        whileHover={{ scale: 1.02, x: 5 }}
                        whileTap={{ scale: 0.98 }}
                        initial={isFirstRender.current ? { x: -20, opacity: 0 } : false}
                        animate={isFirstRender.current ? { x: 0, opacity: 1 } : false}
                        transition={{ delay: 0.7 + index * 0.1 }}
                        onAnimationComplete={() => {
                            isFirstRender.current = false;
                        }}
                    >
                        <div className="flex items-center justify-between">
                            <div className="flex items-center space-x-3">
                                <motion.div
                                    className={`w-3 h-3 rounded-full bg-blue-500`}
                                    animate={{ rotate: [0, 360] }}
                                    transition={{ duration: 20, repeat: Infinity, ease: "linear" }}
                                />
                                <span className="font-medium truncate">{collection.name}</span>
                            </div>
                            <motion.span
                                initial={{ x: 0 }}
                                animate={selectedCollection === collection.id ? { x: -25 } : { x: 0 }}
                                exit={{ x: 0 }}
                                transition={{ duration: 0.2 }}
                                className={`px-2 py-1  text-xs rounded-full relative ${selectedCollection === collection.id
                                    ? `bg-blue-500/30`
                                    : 'bg-gray-600/50'
                                    }`}>
                                {collection.items ? collection.items.length : 0}
                                <motion.div
                                    className="absolute top-0 -right-[30px] flex items-center justify-center"
                                    onClick={() => handleDeleteCollection(collection.id)}
                                   
                                    whileHover={{ scale: 1.1 }}
                                    whileTap={{ scale: 0.9 }}
                                >
                                    <X className="w-5 h-5 text-white" />
                                </motion.div>
                            </motion.span>
                        </div>
                    </motion.button>
                )
            })
        )
    }, [collections, selectedCollection, setSelectedCollection, onToggleDraggableMode])

    const NewCollectionForm = () => (
        <motion.div 
            className="p-4 border border-slate-600/30 rounded-xl bg-slate-800/50 backdrop-blur-sm shadow-lg shadow-slate-900/20"
            initial={{ opacity: 0, y: -10 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0, y: -10 }}
            transition={{ duration: 0.2 }}
        >
            <input
                type="text"
                value={newCollectionName}
                onChange={(e) => setNewCollectionName(e.target.value)}
                placeholder="Collection name..."
                className="w-full p-2.5 mb-3 text-white bg-slate-700/50 border border-slate-600/50 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500/50 focus:border-transparent transition-all duration-300"
                onKeyPress={(e) => e.key === 'Enter' && handleCreateCollection()}
            />
            <div className="flex space-x-3">
                <button
                    onClick={handleCreateCollection}
                    className="px-4 py-2 text-sm text-white bg-gradient-to-r from-blue-600 to-blue-700 rounded-lg hover:from-blue-500 hover:to-blue-600 transition-all duration-300 shadow-lg shadow-blue-500/20"
                >
                    Create
                </button>
                <button
                    onClick={() => {
                        setShowNewCollectionForm(false);
                        setNewCollectionName('');
                    }}
                    className="px-4 py-2 text-sm text-slate-300 bg-slate-700/50 rounded-lg hover:bg-slate-600/50 transition-all duration-300"
                >
                    Cancel
                </button>
            </div>
        </motion.div>
    );

    const NewCollectionButton = () => (
        <motion.button
            onClick={() => setShowNewCollectionForm(true)}
            className="flex items-center justify-center p-3 text-slate-400 transition-all duration-300 border-2 border-slate-600/50 border-dashed rounded-xl hover:text-white hover:border-slate-500/50 hover:bg-slate-700/20"
            whileHover={{ scale: 1.02 }}
            whileTap={{ scale: 0.98 }}
        >
            <svg className="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 4v16m8-8H4" />
            </svg>
            New Collection
        </motion.button>
    );

    const NewCollection = () => (
        <AnimatePresence mode="wait">
            {showNewCollectionForm ? (
                <NewCollectionForm key="form" />
            ) : (
                <NewCollectionButton key="button" />
            )}
        </AnimatePresence>
    );

    return (
        <motion.div
            className={`transition-all duration-300 ${sidebarOpen ? 'w-80' : 'w-16'} bg-gray-900/90 backdrop-blur-md border-r border-gray-700/50 flex flex-col`}
            initial={{ x: -320 }}
            animate={{ x: 0 }}
            transition={{ type: "spring", stiffness: 200, damping: 25 }}
        >
            {/* Sidebar Header */}
            <div className="p-4 border-b border-gray-700/50">
                <div className="flex items-center justify-between">
                    <AnimatePresence>
                        {sidebarOpen && (
                            <motion.h2
                                className="text-xl font-bold text-white"
                                initial={{ opacity: 0, x: -20 }}
                                animate={{ opacity: 1, x: 0 }}
                                exit={{ opacity: 0, x: -20 }}
                                transition={{ duration: 0.2 }}
                            >
                                Collections
                            </motion.h2>
                        )}
                    </AnimatePresence>
                    <motion.button
                        onClick={() => setSidebarOpen(!sidebarOpen)}
                        className="p-2 text-gray-400 transition-colors rounded-lg hover:text-white hover:bg-gray-700/50"
                        whileHover={{ scale: 1.1 }}
                        whileTap={{ scale: 0.9 }}
                    >
                        <motion.div
                            animate={{ rotate: sidebarOpen ? 0 : 180 }}
                            transition={{ duration: 0.3 }}
                        >
                            {sidebarOpen ? (
                                <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M11 19l-7-7 7-7m8 14l-7-7 7-7" />
                                </svg>
                            ) : (
                                <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M13 5l7 7-7 7M5 5l7 7-7 7" />
                                </svg>
                            )}
                        </motion.div>
                    </motion.button>
                </div>
            </div>

            {/* Sidebar Content */}
            <AnimatePresence>
                {sidebarOpen && (
                    <motion.div
                        className="flex flex-col flex-1 p-4 space-y-4"
                        initial={{ opacity: 0 }}
                        animate={{ opacity: 1 }}
                        exit={{ opacity: 0 }}
                        transition={{ duration: 0.2, delay: 0.1 }}
                    >
                        {/* View Mode Toggle */}
                        <motion.div
                            className="p-3 border border-gray-600 rounded-lg bg-gray-800/50"
                            initial={{ y: -20, opacity: 0 }}
                            animate={{ y: 0, opacity: 1 }}
                            transition={{ delay: 0.1 }}
                        >
                            <div className="flex items-center justify-between mb-2">
                                <span className="text-sm font-medium text-gray-300">View Mode</span>
                            </div>
                            <div className="flex space-x-2">
                                <motion.button
                                    onClick={() => !isDraggableMode && onToggleDraggableMode(false)}
                                    className={`flex-1 px-3 py-2 text-xs rounded-lg transition-colors ${!isDraggableMode
                                        ? 'bg-blue-500/30 border border-blue-500/50 text-blue-300'
                                        : 'bg-gray-700/50 text-gray-400 hover:bg-gray-600/50 hover:text-white'
                                        }`}
                                    whileHover={{ scale: 1.02 }}
                                    whileTap={{ scale: 0.98 }}
                                >
                                    <div className="flex items-center justify-center space-x-1">
                                        <svg className="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zM14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zM14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z" />
                                        </svg>
                                        <span>Grid</span>
                                    </div>
                                </motion.button>
                                <motion.button
                                    onClick={() => isDraggableMode && onToggleDraggableMode(true)}
                                    className={`flex-1 px-3 py-2 text-xs rounded-lg transition-colors ${isDraggableMode
                                        ? 'bg-green-500/30 border border-green-500/50 text-green-300'
                                        : 'bg-gray-700/50 text-gray-400 hover:bg-gray-600/50 hover:text-white'
                                        }`}
                                    whileHover={{ scale: 1.02 }}
                                    whileTap={{ scale: 0.98 }}
                                >
                                    <div className="flex items-center justify-center space-x-1">
                                        <svg className="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M7 16V4m0 0L3 8m4-4l4 4m6 0v12m0 0l4-4m-4 4l-4-4" />
                                        </svg>
                                        <span>Free</span>
                                    </div>
                                </motion.button>
                            </div>
                        </motion.div>

                        {/* All Favorites */}
                        <motion.button
                            onClick={() => { setSelectedCollection(null); onToggleDraggableMode(false) }}
                            className={`p-3 text-left rounded-lg transition-all ${selectedCollection === null
                                ? 'bg-blue-500/30 border border-blue-500/50 text-blue-300'
                                : 'bg-gray-800/50 hover:bg-gray-700/50 text-gray-300 hover:text-white'
                                }`}
                            whileHover={{ scale: 1.02, x: 5 }}
                            whileTap={{ scale: 0.98 }}
                            initial={{ x: -20, opacity: 0 }}
                            animate={{ x: 0, opacity: 1 }}
                            transition={{ delay: 0.2 }}
                        >
                            <div className="flex items-center justify-between">
                                <div className="flex items-center space-x-3">
                                    <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z" />
                                    </svg>
                                    <span className="font-medium">All Favorites</span>
                                </div>
                                <motion.span
                                    className="px-2 py-1 text-xs text-blue-300 rounded-full bg-blue-500/20"
                                    animate={{ scale: [1, 1.1, 1] }}
                                    transition={{ duration: 2, repeat: Infinity }}
                                >
                                    {favourites.length}
                                </motion.span>
                            </div>
                        </motion.button>

                        {/* Collections List */}
                        <motion.div
                            className="space-y-2"
                            initial={{ y: 20, opacity: 0 }}
                            animate={{ y: 0, opacity: 1 }}
                            transition={{ delay: 0.3 }}
                        >
                            <CollectionButton />
                        </motion.div>

                        {/* Add Content to Collection Button */}
                        <motion.button
                            onClick={onAddToCollection}
                            className="flex items-center justify-center p-3 text-green-400 transition-colors border-2 border-green-600 border-dashed rounded-lg hover:text-white hover:border-green-500 hover:bg-green-500/10"
                            whileHover={{ scale: 1.02 }}
                            whileTap={{ scale: 0.98 }}
                        >
                            <svg className="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 6v6m0 0v6m0-6h6m-6 0H6" />
                            </svg>
                            Add to Collections
                        </motion.button>

                        {/* Add New Collection */}
                        <NewCollection />
                    </motion.div>
                )}
            </AnimatePresence>
        </motion.div>
    )
}

export default Sidebar;