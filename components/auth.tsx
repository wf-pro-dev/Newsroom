// React
import { useEffect, useState } from 'react';

// Components
import { Input } from './ui/input';
import { Label } from '@radix-ui/react-label';

//API
import { fetchCsrfToken, fetchUser, login, register } from '@/utils/api';
import { Button } from './ui/button';
import { LogIn, User2 } from 'lucide-react';

//STYLES
import '@/styles/heroglobe.css'

export default function Auth () {
    
    const [isVisible,setVisible] = useState(true)
    const [ csrftoken, setCSRFtoken ] = useState("")
    const [ email, setEmail ] = useState("")
    const [ password, setPassword ] = useState("")

    useEffect(() => {
        const getCSRFtoken = async () => {
          const token = await fetchCsrfToken()
          setCSRFtoken(token)
        }
        getCSRFtoken()
    },[] )

    const onRegister = async () => {
        const response = await register(email, password, csrftoken)
    }
    
    const onLogin = async () => {
        const response = await login(email, password, csrftoken)
        const user = await fetchUser(response.csrf_token)
    }

    return (
        <div className='header-container'
        style={{
          scale: isVisible ? 1 :0 ,
          opacity: isVisible ? 1 : 0,
          transition: 'scale 0.4s ease-in-out, opacity 0.4s ease-in-out',
        }}
        >
          <div className={`header`}>
            <div>
              <h1 className="header-title">
                The NewsRoom
              </h1>
              <p className="header-description">
                Explore breaking news from around the world
              </p>
            </div>

            <div className='flex flex-col gap-y-4'>
              <div className="grid w-full max-w-sm items-center gap-1.5">
                <Label className='text-sm' htmlFor="email">Email</Label>
                <Input 
                  type="email"
                  id="email"
                  placeholder="Email"
                  className='bg-transparent'
                  value={email}
                  onChange={(e)=>setEmail(e.target.value)}
                />
              </div>

              <div className="grid w-full max-w-sm items-center gap-1.5">
                <Label className='text-sm'  htmlFor="Password">Password</Label>
                <Input
                  type='password'
                  id="Password"
                  placeholder="Password"
                  className='bg-transparent'
                  value={password}
                  onChange={(e)=>setPassword(e.target.value)}
                />
              </div>
            </div>
            <div className='flex justify-between gap-x-1'>
          <Button
            variant="outline"
            className="form-button flex-1"
            onClick={()=>setVisible(false)}
          >
            <p className='font-medium'>SIGN UP</p> <User2 />
            </Button>

            <Button
            variant={"secondary"}
            className="flex-1"
            onClick={onLogin}
          >
           <p className='font-medium'>LOG IN</p>  < LogIn/> 
          </Button>
          </div>
          </div>
        </div>
    )
}