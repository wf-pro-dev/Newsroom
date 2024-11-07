import { Button } from "@/components/ui/button"
import { Article } from "@/utils/types";
import { HeartIcon, Sparkles } from "lucide-react"

function GlobeSlider({ articles }: { articles: Article[] }) {
    return (
        <div className="grid gap-4 lg:grid-cols-1">
            {articles.map((article: Article, index: number) => (
                <NewsArticle
                    key={index}
                    article={article}
                    favorites={favorites}
                    showFavorites={showFavorites}
                    setFavorites={setFavorites}
                    showDelete={showDelete}
                    showAdd={showAdd}
                    questions={questions}
                    newsData={newsData}
                    setNewsData={setNewsData}
                />
            ))}
        </div>
    )
}

export default GlobeSlider;