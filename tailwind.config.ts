import type { Config } from "tailwindcss";
const plugin = require('tailwindcss/plugin')

const rotateX = plugin(function ({ addUtilities }) {
	addUtilities({
	  '.rotate-x-20': {
		transform: 'rotateX(20deg)',
	  }
	})
})

const z_index = plugin(function ({ addUtilities }) {
	addUtilities({
	  'zIndex': {
		'20': '20',
	  }
	})
})

const config: Config = {
    darkMode: ["class"],
    content: [
    "./pages/**/*.{js,ts,jsx,tsx,mdx}",
    "./components/**/*.{js,ts,jsx,tsx,mdx}",
    "./app/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
  	extend: {
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
  			}
  		},
		'@keyframes fadeInUp': {
			from: {
			  opacity: '0',
			  transform: 'translateY(20px)',
			},	
			to :{
			  opacity: '1',
			  transform: 'translateY(0)',
			}
		  },
		  
		'.animate-fade-in-up': {
			animation: 'fadeInUp 0.3s ease-out',
		},
  		animation: {
  			'fade-pulse': 'fade-pulse 4s ease-in-out infinite',
  			'fade-pulse-delayed': 'fade-pulse 4s ease-in-out 2s infinite',
  			marquee: 'marquee 10s linear infinite',
  			'bounce-subtle': 'bounce-subtle 0.3s ease-in-out',
  		},
  	},
  	plugins: [require("tailwindcss-animate"),rotateX,z_index]
}
}

export default config;
