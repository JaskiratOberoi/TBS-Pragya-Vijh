/** @type {import('next').NextConfig} */
const nextConfig = {
  output: "standalone",
  images: {
    remotePatterns: [
      {
        protocol: "https",
        hostname: "bm3.bad.myftpupload.com",
        pathname: "/wp-content/uploads/**",
      },
    ],
  },
};

export default nextConfig;
