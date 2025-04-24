import { Button } from "@/components/ui/button"
import { HeartIcon, Sparkles } from "lucide-react"

function Header({ toggleFavorites, showFavorites }: { toggleFavorites: () => void, showFavorites: boolean }) {
  return (
    <header className="text-center my-12 relative">
    <div className="flex justify-between items-center">
      <div className="flex-1">
        
      </div>
      <h1 className="text-4xl font-bold bg-gradient-to-r from-blue-300 to-blue-700 text-transparent bg-clip-text">
        {"Today's Top Stories"}
      </h1>
      <div className="flex-1 flex justify-end">
       
        <Button
          variant="outline"
          className="bg-gray-800/50 text-gray-300 hover:scale-95 transition-all ease-in-out"
          onClick={toggleFavorites}
        >
          <HeartIcon className="w-5 h-5 mr-2" />
          {showFavorites ? 'Back to News' : 'Favorites'}
        </Button>

      </div>
    </div>
    <div className="flex items-center justify-center text-lg text-gray-300 mt-4">
      <Sparkles className="w-5 h-5 mr-2 text-yellow-500" />
      <p>
        {"AI-curated questions unveiling the day's most crucial developments"}
      </p>
    </div>
  </header>
  )
}

export default Header;