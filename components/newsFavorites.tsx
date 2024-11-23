import { Article, Video } from '@/utils/types';
import NewsArticle from './newsarticle';
import NewsVideo from './newsvideo';
import { useEffect, useState } from 'react';

function NewsFavorites({ Afavorites, setAFavorites, Vfavorites, setVFavorites, videos, setVideos, showFavorites, showDelete, showAdd }:
  {
    Afavorites: Article[],
    setAFavorites: React.Dispatch<React.SetStateAction<Article[]>>,
    Vfavorites: Video[],
    setVFavorites: React.Dispatch<React.SetStateAction<Video[]>>,
    videos: Video[],
    setVideos: React.Dispatch<React.SetStateAction<Video[]>>,
    showFavorites: boolean,
    showDelete: React.Dispatch<React.SetStateAction<boolean>>,
    showAdd: React.Dispatch<React.SetStateAction<boolean>>
  }) {

  const [mix_array, setMix_array] = useState([])

  function mixArray(arr: Array<any>, arr2: Array<any>, chunkSize: number) {
    const result = [];
    let j = 0;
    for (let i = 0; i < arr.length || j < arr2.length; i++) {

      if (arr2[j] && ((i > 0 && i % chunkSize == 0) || i >= arr.length)) { arr2[j]["type"] = "video"; result.push(arr2[j]); j++ }
      if (arr[i]) { arr[i]["type"] = "article"; result.push(arr[i]); }


    }
    return result;
  }

  useEffect(() => {
    setMix_array(mixArray(Afavorites, Vfavorites, 4))
  }, [Afavorites, Vfavorites])


  return (

    <div className="min-h-screen w-screen xl:px-20 2xl:px-32 bg-black/[.05] backdrop-blur-sm  backdrop-contrast-125">

      {mix_array.length > 0 && (
        <div className='py-24 justify-items-center' >
          <h1 className="text-2xl leading-normal mb-8 text-center text-gray-300">
            Your Favorite News
            <p className="text-4xl leading-normal text-center font-bold bg-gradient-to-r from-blue-300 to-blue-700 text-transparent bg-clip-text">
              Articles
            </p>
          </h1>

          <div className=" grid gap-6 md:grid-cols-2 lg:grid-cols-4 ">

            {mix_array.map((obj: Article | Video, index) => {
              if (obj["type"] == "article") {
                return (
                  <div key={obj.type + obj.id} className="col-span-2 h-[400px]">
                    <NewsArticle
                      key={index}
                      article={obj}
                      favorites={Afavorites}
                      showFavorites={showFavorites}
                      setFavorites={setAFavorites}
                      showDelete={showDelete}
                      showAdd={showAdd}
                    />
                  </div>
                )
              }
              else {
                return (
                  <div key={obj.type + obj.id} className="col-span-2 h-[400px]">
                    <div className="w-full h-full">
                      <NewsVideo
                        video={obj}
                        videos={videos}
                        setVideos={setVideos}
                        favorites={Vfavorites}
                        setFavorites={setVFavorites}
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