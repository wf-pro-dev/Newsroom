'use client'
import { HeartIcon } from "lucide-react";

function Notification({ message,color }: { message: string,color: string }) {
    return (
      <div className={ `fixed flex flex-column align-items-center z-50 top-4 left-1/2 transform -translate-x-1/2 bg-${color}-700/70 backdrop-blur-sm text-white px-4 py-2 rounded-md shadow-lg animate-fade-in-up`}>
        <HeartIcon className="w-5 h-5 text-gray-200 mr-2"  />        
        {message}
      </div>
    );

}

export default Notification;