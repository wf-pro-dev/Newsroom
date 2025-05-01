// React 
import { useState, useEffect } from 'react';

/* Hooks */
import { useGlobalState } from './context/GlobalStateContext';

// Components
import { Input } from './ui/input';
import { Label } from '@radix-ui/react-label';
import { Button } from './ui/button';
import { LogIn, User2, DotIcon } from 'lucide-react';

//API
import { fetchUser, login, register } from '@/utils/api';

//STYLES
import '@/styles/heroglobe.css'

export default function Auth() {
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

  const { csrftoken, user,setUser } = useGlobalState()

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

  useEffect(()=>{
    setVisible(!user)
  },[user])

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
      <p className={`flex flex-row text-xs items-center ${enable ? "" : "opacity-50"}`}>
        <DotIcon size={18} /> {text}
      </p>
    )
  }

  return (
    <div className='header-container pointer-events-auto z-50'
      style={{
        scale: isVisible ? 1 : 0,
        opacity: isVisible ? 1 : 0,
        transition: 'scale 0.4s ease-in-out, opacity 0.4s ease-in-out',
      }}
    >
      <div  className={`header`}>
        <div>
          <h1 className="header-title"
          >
            The NewsRoom
          </h1>
          <p className="header-description">
            Explore breaking news from around the world
          </p>
        </div>

        <div className='flex flex-col gap-y-4'>

          <div
            className="grid w-full max-w-sm items-center gap-1.5"
            style={{
              zIndex:0,
              height: isLogin ? `0px` : '100%',
              opacity: isLogin ? 0 : 1,
              transition: 'height 0.6s ease-in-out, opacity 0.6s ease-in-out',
            }}
          >
            <Label className='text-sm' htmlFor="username">Username</Label>
            <Input
              type="username"
              id="username"
              placeholder="username"
              className='bg-transparent'
              value={username}
              onChange={(e) => setUsername(e.target.value)}
            />
          </div>
          <div className="z-10 grid w-full max-w-sm items-center gap-1.5">
            <Label className='text-sm' htmlFor="email">Email</Label>
            <Input
              type="email"
              id="email"
              placeholder="email"
              className='bg-transparent'
              value={email}
              onChange={(e) => setEmail(e.target.value)}
            />
          </div>

          <div className="grid w-full max-w-sm items-center gap-1.5">
            <Label className='text-sm' htmlFor="Password">Password</Label>
            <Input
              type='password'
              id="Password"
              placeholder="password"
              className='bg-transparent'
              value={password}
              onChange={(e) => setPassword(e.target.value)}
            />
            <div
              style={{
                height: isLogin ? `0px` : '100%',
                opacity: isLogin ? 0 : 1,
                transition: 'height 0.6s ease-in-out, opacity 0.6s ease-in-out',
                overflow: 'hidden'
              }}
            >
              <PasswordRequirements enable={hasMINLength} text={"8 characters minimum"} />
              <PasswordRequirements enable={hasUpper} text={"At least 1 Uppercase"} />
              <PasswordRequirements enable={hasLower} text={"At least 1 lowercase"} />
              <PasswordRequirements enable={hasNum} text={"At least 1 number"} />
            </div>
          </div>
        </div>


        <div
          className='items-center'
          style={{
            height: isError ? `20px` : '0px',
            opacity: isError ? 1 : 0,
            transition: 'height 0.6s ease-in-out, opacity 0.6s ease-in-out',
            overflow: 'hidden'
          }}
        >
          <p className='text-center text-sm text-red-600'>{error}</p>
        </div>


        <div className='flex justify-between gap-x-1'>
          <Button
            disabled={!(isValidUsernameState && isValidEmailState && isValidPasswordState) && !isLogin}
            variant="outline"
            className="form-button flex-1"
            onClick={onRegister}
          >
            <p className='font-medium'>SIGN UP</p> <User2 />
          </Button>

          <Button
            disabled={!(isValidEmailState && isValidPasswordState) && isLogin}
            variant={"secondary"}
            className="flex-1"
            onClick={isLogin ? onLogin : () => { setisLogin(true) }}
          >
            <p className='font-medium'>LOG IN</p>  < LogIn />
          </Button>
        </div>

      </div>
    </div>
  )
}