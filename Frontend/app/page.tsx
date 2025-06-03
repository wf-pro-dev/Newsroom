import App from "@/components/app";
import { GlobalStateProvider } from '@/src/contexts/GlobalStateContext';

export default function Page() {
    return (
        <GlobalStateProvider>
            <App />
        </GlobalStateProvider>
    );
}

