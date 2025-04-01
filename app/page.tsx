import App from "@/components/app";
import { GlobalStateProvider } from '@/components/context/GlobalStateContext';

export default function Page() {
    return (
        <GlobalStateProvider>
            <App />
        </GlobalStateProvider>
    );
}

