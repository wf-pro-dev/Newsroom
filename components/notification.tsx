'use client'
import { HeartIcon } from "lucide-react";
import {  useEffect, useState } from "react";

function Notification({ message,color,show,setShow }: { message: string,color: string,show:boolean,setShow:any }) {
  
  const bgcolor : any = {
    "red" : "bg-red-700/60",
    "green" : "bg-green-400/50",
  }

  const [Anim,setAnim] = useState(false)

  useEffect(()=>{

    setAnim(true)
    
    setTimeout(()=>{
      setAnim(false)
    },2000)

    setTimeout(()=>{
      setShow(false)
    },4000)

  },[show])

    if (show) return (
      <div className={ `fixed flex opacity-${Anim ? 1 : 0} flex-column align-items-center z-50 top-4 left-1/2 transform -translate-x-1/2 ${bgcolor[color]} backdrop-blur-sm text-white px-4 py-2 rounded-full transition-all duration-800 ease-in-out`}>
        <HeartIcon className="w-5 h-5 text-gray-200 mr-2"  />        
        {message}
      </div>
    );

}

export default Notification;