import '@/styles/newsmain.css';
import '@/styles/page.css';

import { useGlobalState } from '@/src/contexts/GlobalStateContext'
import FavoriteMain from './favorites/main';
import Sidebar from './favorites/sidebar';
import DraggableContent from './favorites/draggable-content';
import { useState } from 'react';

function NewsFavorites({ showFavorites, showDelete, showAdd }:
  {
    showFavorites: boolean,
    showDelete: React.Dispatch<React.SetStateAction<boolean>>,
    showAdd: React.Dispatch<React.SetStateAction<boolean>>
  }) {

  const { favourites, items } = useGlobalState()
  const [isDraggableMode, setIsDraggableMode] = useState(false);
  

  const handleToggleDraggableMode = () => {
    setIsDraggableMode(!isDraggableMode);
  };

  return (
    <div className="flex w-screen min-h-screen bg-black/60 backdrop-blur-sm backdrop-contrast-125">

      {/* Sidebar */}
      <Sidebar 
        favourites={favourites} 
        isDraggableMode={isDraggableMode}
        onToggleDraggableMode={handleToggleDraggableMode}
        onAddToCollection={() => {}}
        selectedCollection={null}
        setSelectedCollection={() => {}}
      />

      {/* Main Content */}
      {isDraggableMode ? (
        <DraggableContent
          items={items}
          showFavorites={showFavorites}
          showDelete={showDelete}
          showAdd={showAdd}
        />
      ) : (
        <FavoriteMain
          favourites={favourites}
          showFavorites={showFavorites}
          showDelete={showDelete}
          showAdd={showAdd}
          showAddToCollection={false}
          setShowAddToCollection={() => {}}
          selectedCollection={null}
          setSelectedCollection={() => {}}
          selectedItems={[]}
          setSelectedItems={() => {}}
        />
      )}

    </div>
  )
}

export default NewsFavorites;