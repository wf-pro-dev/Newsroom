import dynamic from 'next/dynamic';
import { ImageProps } from 'next/image';

interface DynamicImageProps extends Omit<ImageProps, 'src'> {
  folder: string;
  src: string;
}

// Using named function to provide display name
const DynamicImageComponent = dynamic(() => 
  import('next/image').then((mod) => {
    const Component = ({ folder, src, ...props }: DynamicImageProps) => {
      // Using import path as string instead of require()
      const imageSrc = `/home/will/Newsroom/Backend/data/${folder}/${src}`;
      return <mod.default src={imageSrc} {...props} />;
    };
    
    Component.displayName = 'DynamicImageInner';
    return Component;
  }),
  { ssr: false }
);

// Set display name for the dynamic component
DynamicImageComponent.displayName = 'DynamicImage';

export default DynamicImageComponent;
