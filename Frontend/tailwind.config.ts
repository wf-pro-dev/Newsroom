import type { Config } from "tailwindcss";
import plugin from 'tailwindcss/plugin';
import * as tailwind_animate from 'tailwindcss-animate'

/** @type {import('tailwindcss').Config} */

const rotateX = plugin(function ({ addUtilities }: { addUtilities: (utilities: Record<string, Record<string, string>>) => void }) {
  addUtilities({
    '.rotate-x-20': {
      transform: 'rotateX(20deg)',
    }
  });
});

const z_index = plugin(function ({ addUtilities }: { addUtilities: (utilities: Record<string, Record<string, string>>) => void }) {
  addUtilities({
    '.z-20': {
      'z-index': '20',
    }
  });
});

const config: Config = {
  darkMode: ["class"],
  content: [
    "./pages/**/*.{js,ts,jsx,tsx,mdx}",
    "./components/**/*.{js,ts,jsx,tsx,mdx}",
    "./app/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['var(--font-inter)'],
        serif: ['var(--font-playfair)'],
      },
      colors: {
        background: 'hsl(var(--background))',
        foreground: 'hsl(var(--foreground))',
        card: {
          DEFAULT: 'hsl(var(--card))',
          foreground: 'hsl(var(--card-foreground))'
        },
        popover: {
          DEFAULT: 'hsl(var(--popover))',
          foreground: 'hsl(var(--popover-foreground))'
        },
        primary: {
          DEFAULT: 'hsl(var(--primary))',
          foreground: 'hsl(var(--primary-foreground))'
        },
        secondary: {
          DEFAULT: 'hsl(var(--secondary))',
          foreground: 'hsl(var(--secondary-foreground))'
        },
        muted: {
          DEFAULT: 'hsl(var(--muted))',
          foreground: 'hsl(var(--muted-foreground))'
        },
        accent: {
          DEFAULT: 'hsl(var(--accent))',
          foreground: 'hsl(var(--accent-foreground))'
        },
        destructive: {
          DEFAULT: 'hsl(var(--destructive))',
          foreground: 'hsl(var(--destructive-foreground))'
        },
        border: 'hsl(var(--border))',
        input: 'hsl(var(--input))',
        ring: 'hsl(var(--ring))',
        chart: {
          '1': 'hsl(var(--chart-1))',
          '2': 'hsl(var(--chart-2))',
          '3': 'hsl(var(--chart-3))',
          '4': 'hsl(var(--chart-4))',
          '5': 'hsl(var(--chart-5))'
        }
      },
      borderRadius: {
        lg: 'var(--radius)',
        md: 'calc(var(--radius) - 2px)',
        sm: 'calc(var(--radius) - 4px)'
      },
      keyframes: {
        'fade-pulse': {
          '0%, 100%': { opacity: "0.25" },
          '50%': { opacity: "0.8" },
        },
        marquee: {
          '0%': { transform: 'translateX(0%)' },
          '100%': { transform: 'translateX(-100%)' },
        },
        'bounce-subtle': {
          '0%, 100%': { transform: 'scale(1)' },
          '50%': { transform: 'scale(1.15)' },
        },
        'fadeInUp': {
          from: {
            opacity: '0',
            transform: 'translateY(20px)',
          },
          to: {
            opacity: '1',
            transform: 'translateY(0)',
          },
        },
        'animate-gradient': {
          '0%': { 'background-position': '0% 50%' },
          '50%': { 'background-position': '100% 50%' },
          '100%': { 'background-position': '0% 50%' },
        }
      },
      animation: {
        'fade-pulse': 'fade-pulse 4s ease-in-out infinite',
        'fade-pulse-delayed': 'fade-pulse 4s ease-in-out 2s infinite',
        marquee: 'marquee 10s linear infinite',
        'bounce-subtle': 'bounce-subtle 0.3s ease-in-out',
        'fade-in-up': 'fadeInUp 0.3s ease-out',
        'animate-gradient': 'animate-gradient 6s ease infinite'
      },
    },
  },
  plugins: [
    tailwind_animate,
    rotateX,
    z_index
  ]
};

export default config;