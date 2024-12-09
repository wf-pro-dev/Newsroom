import Image from 'next/image'
import dynamic from 'next/dynamic'

const DynamicImage = dynamic(() => import('next/image').then((mod) => {
  return ({ folder,src, ...props }) => (
    <mod.default
      src={require(`@/Backend/data/${folder}/${src}`)} 
      {...props} 
    />
  )
}), { ssr: false })

export default DynamicImage