// React 
import { useState, useEffect } from 'react';

/* Hooks */
import { useGlobalState } from './context/GlobalStateContext';

// Components
import { Input } from './ui/input';
import { Label } from '@radix-ui/react-label';
import { Button } from './ui/button';
import { Card } from "@/components/ui/card";
import { LogIn, User2, DotIcon } from 'lucide-react';
import { AnimatePresence, motion } from "framer-motion";

//API
import { fetchUser, login, register } from '@/utils/api';

//STYLES
import '@/styles/heroglobe.css'

export default function Auth() {

  const { csrftoken, user, setUser, isLoadingUser } = useGlobalState()

  const [isVisible, setVisible] = useState(false)
  const [isLogin, setisLogin] = useState(true)

  const [username, setUsername] = useState("")
  const [email, setEmail] = useState("")
  const [password, setPassword] = useState("")
  const [hasMINLength, setHasMINLength] = useState(false)
  const [hasUpper, setHasUpper] = useState(false)
  const [hasLower, setHasLower] = useState(false)
  const [hasNum, setHasNum] = useState(false)
  const [isValidPasswordState, setIsValidPasswordState] = useState(false)
  const [isValidUsernameState, setIsValidUsernameState] = useState(false)
  const [isValidEmailState, setIsValidEmailState] = useState(false)
  const [isError, setisError] = useState(false)
  const [error, setError] = useState("An account is already registered with that email")

  // Use useEffect to validate password whenever it changes
  useEffect(() => {
    // Check minimum length
    setHasMINLength(password.length >= 8);

    // Check for uppercase, lowercase, and number
    const hasUpperCase = /[A-Z]/.test(password);
    setHasUpper(hasUpperCase);

    const hasLowerCase = /[a-z]/.test(password);
    setHasLower(hasLowerCase);

    const hasNumber = /[0-9]/.test(password);
    setHasNum(hasNumber);

    // Set overall password validity
    setIsValidPasswordState(
      password.length >= 8 && hasUpperCase && hasLowerCase && hasNumber
    );
  }, [password]);

  useEffect(() => {
    setIsValidUsernameState(username.length > 2);
  }, [username]);

  useEffect(() => {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    setIsValidEmailState(emailRegex.test(email));
  }, [email]);

  useEffect(() => {
    console.log("isLoadingUser :", isLoadingUser)
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
  }

  const onLogin = async () => {
    login(email, password, csrftoken!)
      .then(() => {
        fetchUser()
          .then((user) => {
            setUser(user)
            setVisible(false)
          })
      })
      .catch(() => {
        setisError(true)
        setError("Email and/or password invalid")
        setTimeout(() => setisError(false), 5000)
      })
  }

  const PasswordRequirements = ({ enable, text }: { enable: boolean, text: string }) => {
    return (
      <p
        className={`flex flex-row text-xs items-center transition-all duration-300 ${enable ? "text-blue-400" : "text-gray-500"}`}

      >
        <DotIcon size={18} /> {text}
      </p>
    )
  }

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
                  <Label className="text-sm text-gray-400" htmlFor="Password">Password</Label>
                  <Input
                    type="password"
                    id="Password"
                    placeholder="Enter your password"
                    className="text-white transition-all duration-300 border-gray-600 bg-gray-700/50"
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                  />

                  {/* Password Requirements - Only visible when registering */}
                  <motion.div
                    initial={{ height: 0, opacity: 0 }}
                    animate={{
                      height: isLogin ? 0 : 'auto',
                      opacity: isLogin ? 0 : 1
                    }}
                    transition={{ duration: 0.6, ease: "easeInOut" }}
                    style={{ overflow: 'hidden' }}
                    className="space-y-1 pt-2"
                  >
                    <PasswordRequirements enable={hasMINLength} text={"8 characters minimum"} />
                    <PasswordRequirements enable={hasUpper} text={"At least 1 Uppercase"} />
                    <PasswordRequirements enable={hasLower} text={"At least 1 lowercase"} />
                    <PasswordRequirements enable={hasNum} text={"At least 1 number"} />
                  </motion.div>
                </div>
              </motion.div>

              {/* Error Message */}
              <motion.div
                className="flex items-center justify-center"
                initial={{ height: 0, opacity: 0 }}
                animate={{
                  height: isError ? 'auto' : 0,
                  opacity: isError ? 1 : 0
                }}
                transition={{ duration: 0.6, ease: "easeInOut" }}
                style={{ overflow: 'hidden' }}
              >
                <p className="text-center text-sm text-red-400">{error}</p>
              </motion.div>

              {/* Buttons */}
              <motion.div
                className="flex gap-4"
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 0.4 }}
              >
                <Button
                  disabled={!(isValidUsernameState && isValidEmailState && isValidPasswordState) && !isLogin}
                  onClick={onRegister}
                  className="flex-1 text-white transition-all duration-300 border bg-gradient-to-r from-blue-500/40 via-blue-600/40 to-blue-500/40 border-blue-500/30 hover:shadow-lg hover:shadow-blue-500/20 disabled:opacity-50 disabled:cursor-not-allowed"
                >
                  <span className="font-medium">SIGN UP</span>
                  <User2 className="ml-2" size={18} />
                </Button>

                <Button
                  disabled={!(isValidEmailState && isValidPasswordState) && isLogin}
                  onClick={isLogin ? onLogin : () => { setisLogin(true) }}
                  className="flex-1 text-white transition-all duration-300 border border-gray-600 bg-gray-700/50 hover:bg-gray-600/50 disabled:opacity-50 disabled:cursor-not-allowed"
                >
                  <span className="font-medium">LOG IN</span>
                  <LogIn className="ml-2" size={18} />
                </Button>
              </motion.div>
            </Card>
          </motion.div>
        </motion.div>
      )}
    </AnimatePresence>
  )
}