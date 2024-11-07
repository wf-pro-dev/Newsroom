import { Article, HandleNotification } from '@/utils/types';
import NewsArticle from './newsarticle';

function NewsFavorites({ favorites, setFavorites, showFavorites, showDelete, showAdd }:
  {
    favorites: Article[],
    setFavorites: React.Dispatch<React.SetStateAction<Article[]>>,
    showFavorites: boolean,
    showDelete: React.Dispatch<React.SetStateAction<boolean>>,
    showAdd: React.Dispatch<React.SetStateAction<boolean>>
  }) {

  return (
    <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-4">
      {favorites.length > 0 && favorites.map((article, index) => (
        <NewsArticle
          key={index}
          article={article}
          favorites={favorites}
          showFavorites={showFavorites}
          setFavorites={setFavorites}
          showDelete={showDelete}
          showAdd={showAdd}
        />
      ))}
      {(!favorites.length || favorites.length == 0) && (
        <div className="col-span-full flex justify-center">
          <div className="flex flex-col items-center justify-center text-center p-8 rounded-lg bg-gray-800/40 backdrop-blur-sm">
            <svg className="w-16 h-16 text-gray-400 mb-4 animate-pulse" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z">
                <animate
                  attributeName="stroke"
                  values="#9333ea;#3b82f6;#ef4444;#9333ea"
                  dur="4s"
                  repeatCount="indefinite"
                />
              </path>
            </svg>
            <h3 className="text-xl font-semibold text-gray-200 mb-2">No Favorites Yet</h3>
            <p className="text-gray-400">Start adding articles to your favorites to see them here.</p>
          </div>
        </div>
      )}
    </div>
  )
}

export default NewsFavorites;