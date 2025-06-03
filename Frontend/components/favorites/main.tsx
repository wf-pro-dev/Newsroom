import { Favourite, Article, Video } from "@/utils/types";
import NewsArticle from "../core/newsarticle";
import NewsVideo from "../core/newsvideo";

function FavoriteMain(
    { favourites, showFavorites, showDelete, showAdd }:
        {
            favourites: Favourite[],
            showFavorites: boolean,
            showDelete:
            React.Dispatch<React.SetStateAction<boolean>>,
            showAdd: React.Dispatch<React.SetStateAction<boolean>>
        }) {

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

    // Group favorites by date
    const groupFavoritesByDate = (favorites: Favourite[]) => {
        const grouped: { [key: string]: Favourite[] } = {};

        favorites.forEach((favorite) => {
            // Parse the favAt date
            const favDate = favorite.favAt ? new Date(favorite.favAt) : new Date();
            const dateKey = favDate.toDateString(); // e.g., "Mon Dec 09 2024"

            if (!grouped[dateKey]) {
                grouped[dateKey] = [];
            }
            grouped[dateKey].push(favorite);
        });

        // Sort dates in descending order (most recent first)
        const sortedDates = Object.keys(grouped).sort((a, b) => {
            return new Date(b).getTime() - new Date(a).getTime();
        });

        return sortedDates.map(date => ({
            date,
            favorites: grouped[date]
        }));
    };



    const groupedFavorites = groupFavoritesByDate(favourites);

    return (
        <div className="flex-1 xl:px-24 2xl:px-40">
            {favourites.length > 0 && (
                <div className='py-12 justify-items-center' >
                    <div className="w-full space-y-12">
                        {groupedFavorites.map(({ date, favorites }, groupIndex) => (
                            <div key={date} className="w-full">
                                {/* Enhanced Date Header */}
                                <div className="mb-8">
                                    <div className="flex items-center justify-between mb-4">
                                        <h2 className="text-3xl font-bold text-transparent bg-gradient-to-r from-blue-300 to-blue-700 bg-clip-text">
                                            {formatDateHeader(date)}
                                        </h2>
                                        <div className="flex items-center space-x-2">
                                            <div className="px-3 py-1 text-sm font-medium text-blue-300 border rounded-full bg-blue-900/30 border-blue-700/50">
                                                {favorites.length} {favorites.length === 1 ? 'item' : 'items'}
                                            </div>
                                        </div>
                                    </div>

                                    {/* Decorative separator line */}
                                    <div className="my-4 separator" />

                                </div>

                                {/* Favorites Grid for this date */}
                                <div className="grid w-full grid-cols-3 gap-6">
                                    {favorites.map((obj: Favourite, index) => {
                                        if (obj.type === "article") {
                                            return (
                                                <div key={obj.type + obj.id} >
                                                    <NewsArticle
                                                        key={`${groupIndex}-${index}`}
                                                        article={obj as Article}
                                                        showFavorites={showFavorites}
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
                                                            video={obj as Video}
                                                            showFavorites={showFavorites}
                                                            showDelete={showDelete}
                                                            showAdd={showAdd}
                                                        />
                                                    </div>
                                                </div>
                                            )
                                        }
                                    })}
                                </div>
                            </div>
                        ))}
                    </div>
                </div>
            )}

            {(favourites.length == 0) && (
                <div className="flex items-center justify-center h-screen">
                    <div className="flex flex-col items-center justify-center p-8 text-center h-fit feature-card">
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
                        <p className="text-gray-400">Start adding articles to your favorites </p>
                        <p className="text-gray-400">to see them here.</p>
                    </div>
                </div>
            )}
        </div>
    )
}

export default FavoriteMain;