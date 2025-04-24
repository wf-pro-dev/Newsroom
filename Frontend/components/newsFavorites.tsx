import { Article, Video } from '@/utils/types';
import NewsArticle from './core/newsarticle';
import NewsVideo from './core/newsvideo';
import { useEffect, useState } from 'react';

import '@/styles/newsmain.css';
import { Separator } from './ui/separator';

import { useGlobalState } from '@/components/context/GlobalStateContext'
import { id_to_obj, mixArray } from '@/lib/utils';


function NewsFavorites({ showFavorites, showDelete, showAdd }:
  {

    showFavorites: boolean,
    showDelete: React.Dispatch<React.SetStateAction<boolean>>,
    showAdd: React.Dispatch<React.SetStateAction<boolean>>
  }) {

  const { favourites, setFavourites, videos, articles } = useGlobalState()

  
  const {favArticles,favVideos} = id_to_obj(favourites,articles,videos)
  const [mix_array, setMix_Array] = useState(mixArray(favArticles,favVideos,4))

  useEffect(()=>{
    const {favArticles,favVideos} = id_to_obj(favourites,articles,videos)
    setMix_Array(mixArray(favArticles,favVideos,4))
  },[favourites])

  return (

    <div className="min-h-screen w-screen xl:px-24 2xl:px-40 bg-black/60 backdrop-blur-sm  backdrop-contrast-125">

      {mix_array.length > 0 && (
        <div className='justify-items-center py-12' >

          <Separator className="separator" />

          <h1 className="text-2xl leading-normal mb-8 text-center text-gray-300">
            Your Favorite News
            <p className="text-4xl leading-normal text-center font-bold bg-gradient-to-r from-blue-300 to-blue-700 text-transparent bg-clip-text">
              Articles
            </p>
          </h1>

          <div className=" grid gap-6 md:grid-cols-2 w-full lg:grid-cols-4 ">

            {mix_array.map((obj: Article | Video, index) => {
              if (obj.type === "article") {
                return (
                  <div key={Object.keys(obj).includes("type") ? "article" : "video" + obj.id} >
                    <NewsArticle
                      key={index}
                      article={obj as Article}
                      favourites={favourites}
                      showFavorites={showFavorites}
                      setFavourites={setFavourites}
                      showDelete={showDelete}
                      showAdd={showAdd}
                    />
                  </div>
                )
              }
              else {
                return (
                  <div key={Object.keys(obj).includes("type") ? "article" : "video" + obj.id} className="col-span-2 h-[400px]">
                    <div className="w-full h-full">
                      <NewsVideo
                        video={obj as Video}
                        favourites={favourites}
                        setFavourites={setFavourites}
                        showFavorites={showFavorites}
                        showDelete={showDelete}
                        showAdd={showAdd}
                      />
                    </div>
                  </div>
                )
              }
            }
            )}
          </div>
        </div>
      )}

      {(mix_array.length == 0) && (
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