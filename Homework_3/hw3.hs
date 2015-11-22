import Data.Char
import System.Random

main :: IO ()
main = do
    y <- randomRIO (1, 10)
    ask y

ask :: Int -> IO ()
ask x = do
    putStrLn "Guess a number?"
    x' <- getLine
    if x == (read x' :: Int)   
        then putStrLn "You get a cookie!"
    else
        do
            if x < (read x' :: Int)
              then putStrLn "Too high!"
            else 
            putStrLn "Too low!"
        ask x
        

{- First Class Effects are being combined by putting together effects from 3 different monads.
 - The first monad is the randomRIO monad, which has the effect of generating a new random number 
 - every time that the function is called. 
 - The second monad is reading in from STDIN, from which we get our value of x'. 
 - The third monad is putting to STDOUT, which tells the user whether they have the right value 
 - or not. 
 -}
