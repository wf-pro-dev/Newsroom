'use client'
import { HeartIcon } from "lucide-react";
import { useEffect, useState } from "react";
import '@/styles/page.css'

type NotificationColors = "red" | "green";

function Notification({ 
  message, 
  color, 
  show, 
  setShow 
}: { 
  message: string, 
  color: NotificationColors, 
  show: boolean, 
  setShow: React.Dispatch<React.SetStateAction<boolean>> 
}) {
  
  const bgcolor: Record<NotificationColors, string> = {
    "red": "bg-red-700/60",
    "green": "bg-green-400/60",
  }

  const [Anim, setAnim] = useState(false)

  useEffect(() => {
    setAnim(true)
    
    setTimeout(() => {
      setAnim(false)
    }, 2000)

    setTimeout(() => {
      setShow(false)
    }, 4500)

  }, [show, setShow])

  if (show) return (
    <div className={`${Anim ? 'opacity-1' : 'opacity-0'} ${bgcolor[color]} notification`}>
      <HeartIcon className="w-5 h-5 text-gray-200 mr-2" />        
      {message}
    </div>
  );

  return null;
}

export default Notification;