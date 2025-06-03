import { useState, useEffect } from 'react';
import { Input } from '@/components/ui/input';
import { Label } from '@radix-ui/react-label';
import { Button } from '@/components/ui/button';
import { Card } from "@/components/ui/card";
import { LogIn, User2, DotIcon } from 'lucide-react';
import { AnimatePresence, motion } from "framer-motion";
import { fetchUser, login, register } from '@/src/lib/api';
import { useGlobalState } from '@/src/contexts/GlobalStateContext';
import '@/src/styles/components/hero-globe.css';
import { PASSWORD_REQUIREMENTS } from '@/src/lib/constants';

export default function Auth() {
  const { csrftoken, user, setUser, isLoadingUser } = useGlobalState();

  const [isVisible, setVisible] = useState(false);
  const [isLogin, setisLogin] = useState(true);

  const [username, setUsername] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [hasMINLength, setHasMINLength] = useState(false);
  const [hasUpper, setHasUpper] = useState(false);
  const [hasLower, setHasLower] = useState(false);
  const [hasNum, setHasNum] = useState(false);
  const [isValidPasswordState, setIsValidPasswordState] = useState(false);
  const [isValidUsernameState, setIsValidUsernameState] = useState(false);
  const [isValidEmailState, setIsValidEmailState] = useState(false);
  const [isError, setisError] = useState(false);
  const [error, setError] = useState("An account is already registered with that email");

  // Use useEffect to validate password whenever it changes
  useEffect(() => {
    // Check minimum length
    setHasMINLength(password.length >= PASSWORD_REQUIREMENTS.MIN_LENGTH);

    // Check for uppercase, lowercase, and number
    const hasUpperCase = PASSWORD_REQUIREMENTS.PATTERNS.UPPERCASE.test(password);
    setHasUpper(hasUpperCase);

    const hasLowerCase = PASSWORD_REQUIREMENTS.PATTERNS.LOWERCASE.test(password);
    setHasLower(hasLowerCase);

    const hasNumber = PASSWORD_REQUIREMENTS.PATTERNS.NUMBER.test(password);
    setHasNum(hasNumber);

    // Set overall password validity
    setIsValidPasswordState(
      password.length >= PASSWORD_REQUIREMENTS.MIN_LENGTH && 
      hasUpperCase && 
      hasLowerCase && 
      hasNumber
    );
  }, [password]);

  useEffect(() => {
    setIsValidUsernameState(username.length > 2);
  }, [username]);

  useEffect(() => {
    setIsValidEmailState(PASSWORD_REQUIREMENTS.PATTERNS.EMAIL.test(email));
  }, [email]);

  useEffect(() => {
    console.log("isLoadingUser :", isLoadingUser);
    // Only update visibility after initial auth check
    if (!isLoadingUser || user) {
      setVisible(!user);
    }
  }, [user, isLoadingUser]);

  const onRegister = async () => {
    if (isLogin) {
      setisLogin(false);
    } else {
      try {
        const response = await register(username, email, password, csrftoken!);
        if (response.ok) onLogin();
      } catch {
        setisError(true);
        setError("An account is already registered with that email");
        setTimeout(() => setisError(false), 5000);
      }
    }
  };

  const onLogin = async () => {
    login(email, password, csrftoken!)
      .then(() => {
        fetchUser()
          .then((user) => {
            setUser(user);
            setVisible(false);
          });
      })
      .catch(() => {
        setisError(true);
        setError("Email and/or password invalid");
        setTimeout(() => setisError(false), 5000);
      });
  };

  const PasswordRequirements = ({ enable, text }: { enable: boolean, text: string }) => {
    return (
      <p
        className={`flex flex-row text-xs items-center transition-all duration-300 ${enable ? "text-blue-400" : "text-gray-500"}`}
      >
        <DotIcon size={18} /> {text}
      </p>
    );
  };

  if (isLoadingUser) return null;

  return (
    <AnimatePresence initial={false}>
      {isVisible && (
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ duration: 0.5 }}
          className="fixed inset-0 z-50 flex items-center justify-center"
        >
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.5, delay: 0.5 }}
            className="container max-w-md px-4 py-12 mx-auto"
          >
            <Card className="p-8 space-y-3 border shadow-2xl bg-gray-800/30 backdrop-blur-xl border-blue-500/20 shadow-blue-500/10">
              {/* Header */}
              <motion.div
                className="space-y-2 text-center"
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                transition={{ delay: 0.2 }}
              >
                <h1 className="text-3xl font-semibold tracking-tight text-transparent bg-clip-text bg-gradient-to-r from-blue-400 to-blue-600">
                  The NewsRoom
                </h1>
                <p className="text-gray-400">
                  Explore breaking news from around the world
                </p>
              </motion.div>

              {/* Form Fields */}
              <motion.div
                className="space-y-4"
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 0.3 }}
              >
                {/* Username Field - Only visible when registering */}
                <motion.div
                  className="space-y-2"
                  initial={{ height: 0, opacity: 0 }}
                  animate={{
                    height: isLogin ? 0 : 'auto',
                    opacity: isLogin ? 0 : 1,
                    overflow: isLogin ? 'hidden' : 'visible'
                  }}
                  transition={{ duration: 0.6, ease: "easeInOut" }}
                >
                  <Label className="text-sm text-gray-400" htmlFor="username">Username</Label>
                  <Input
                    type="username"
                    id="username"
                    placeholder="Enter your username"
                    className="text-white transition-all duration-300 border-gray-600 bg-gray-700/50"
                    value={username}
                    onChange={(e) => setUsername(e.target.value)}
                  />
                </motion.div>

                {/* Email Field */}
                <div className="space-y-2">
                  <Label className="text-sm text-gray-400" htmlFor="email">Email</Label>
                  <Input
                    type="email"
                    id="email"
                    placeholder="Enter your email"
                    className="text-white transition-all duration-300 border-gray-600 bg-gray-700/50"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                  />
                </div>

                {/* Password Field */}
                <div className="space-y-2">
                  <Label className="text-sm text-gray-400" htmlFor="password">Password</Label>
                  <Input
                    type="password"
                    id="password"
                    placeholder="Enter your password"
                    className="text-white transition-all duration-300 border-gray-600 bg-gray-700/50"
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                  />

                  {/* Password Requirements - Only visible when registering */}
                  <motion.div
                    className="space-y-1"
                    initial={{ height: 0, opacity: 0 }}
                    animate={{
                      height: isLogin ? 0 : 'auto',
                      opacity: isLogin ? 0 : 1,
                      overflow: isLogin ? 'hidden' : 'visible'
                    }}
                    transition={{ duration: 0.6, ease: "easeInOut" }}
                  >
                    <PasswordRequirements enable={hasMINLength} text="At least 8 characters" />
                    <PasswordRequirements enable={hasUpper} text="One uppercase letter" />
                    <PasswordRequirements enable={hasLower} text="One lowercase letter" />
                    <PasswordRequirements enable={hasNum} text="One number" />
                  </motion.div>
                </div>

                {/* Error Message */}
                <motion.div
                  initial={{ opacity: 0, height: 0 }}
                  animate={{
                    opacity: isError ? 1 : 0,
                    height: isError ? 'auto' : 0
                  }}
                  transition={{ duration: 0.3 }}
                  className="overflow-hidden"
                >
                  <p className="text-sm text-red-400">
                    {error}
                  </p>
                </motion.div>

                {/* Buttons */}
                <div className="space-y-3">
                  <Button
                    onClick={isLogin ? onLogin : onRegister}
                    disabled={isLogin ? !isValidEmailState : (!isValidPasswordState || !isValidUsernameState || !isValidEmailState)}
                    className="w-full transition-all duration-300 bg-gradient-to-r from-blue-500 to-blue-600 hover:from-blue-600 hover:to-blue-700 disabled:opacity-50 disabled:cursor-not-allowed"
                  >
                    <div className="flex items-center justify-center space-x-2">
                      {isLogin ? <LogIn size={18} /> : <User2 size={18} />}
                      <span>{isLogin ? "Sign In" : "Create Account"}</span>
                    </div>
                  </Button>

                  <div className="relative">
                    <div className="absolute inset-0 flex items-center">
                      <div className="w-full border-t border-gray-600"></div>
                    </div>
                    <div className="relative flex justify-center text-sm">
                      <span className="px-2 text-gray-400 bg-gray-800">or</span>
                    </div>
                  </div>

                  <Button
                    variant="outline"
                    onClick={() => setisLogin(!isLogin)}
                    className="w-full text-gray-300 transition-all duration-300 border-gray-600 hover:bg-gray-700/50"
                  >
                    {isLogin ? "Need an account? Sign up" : "Already have an account? Sign in"}
                  </Button>
                </div>
              </motion.div>
            </Card>
          </motion.div>
        </motion.div>
      )}
    </AnimatePresence>
  );
} 