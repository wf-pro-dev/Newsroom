import { withNextVideo } from "next-video/process";
/** @type {import('next').NextConfig} */
const nextConfig = {

  images: {
  remotePatterns: [

      {
        hostname: "**",
      },

    ],
  },
};



export default withNextVideo(nextConfig);