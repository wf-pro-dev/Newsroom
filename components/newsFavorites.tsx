import { Article } from '@/utils/types';
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
    <div className="min-h-screen w-screen xl:px-20 2xl:px-40 bg-black/[.05] backdrop-blur-sm  backdrop-contrast-125">

      {favorites.length > 0 && (
        <div className='pt-20 justify-items-center' >
          <h1 className="text-3xl leading-normal mb-10 text-center text-gray-300">
            Your Favorite News
            <h1 className="text-4xl leading-normal text-center font-bold bg-gradient-to-r from-blue-300 to-blue-700 text-transparent bg-clip-text">
              {"Articles"}
            </h1>
          </h1>
          <div className=" grid gap-6 md:grid-cols-2 lg:grid-cols-4 ">

            {favorites.map((article, index) => (
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
          </div>
        </div>
      )}

      {(!favorites.length || favorites.length == 0) && (
        <div className="flex h-screen justify-center items-center">
          <div className="aspect-square p-8 h-fit flex flex-col items-center justify-center text-center rounded-full bg-gray-700/50 backdrop-blur-sm">
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
            <p className="text-gray-400">Start adding articles to your favorites </p>
            <p className="text-gray-400">to see them here.</p>
          </div>
        </div>
      )}
    </div>
  )
}

export default NewsFavorites;