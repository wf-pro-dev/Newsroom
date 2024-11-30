import App from "@/components/app";
import { GlobalStateProvider } from '@/components/context/GlobalStateContext';

export default function Page({ Component, pageProps }) {
    return (
        <GlobalStateProvider>
            <App {...pageProps} />
        </GlobalStateProvider>
    );
}

