{-# LANGUAGE GADTs, KindSignatures #-}


import Control.Applicative
import Control.Monad
import Data.IORef

simple_fac :: Int -> Int
simple_fac 0 = 1
simple_fac n = (simple_fac (n - 1)) * n

real_loop :: Int -> IO ()
real_loop 0 = putStrLn $ show 0
                      
real_loop n = do 
                     putStrLn $ show $ real_loop (n-1);
                     

main2 :: IO ()
main2 = do
    r <- newIORef 0
    loop2 r

loop2 :: IORef Int -> IO ()
loop2 0 = 
