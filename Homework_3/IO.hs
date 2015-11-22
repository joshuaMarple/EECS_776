import Data.Char

main :: IO ()
main = ask 

ask :: IO ()
ask = do
        putStrLn "How many bottles of irn bru are on the wall?"
        xs <- getLine
        loop (read xs)

{-
        putStrLn "How many bottles of irn bru are on the wall?" >>
        getLine >>= \ xs -> 
        loop (read xs)
-}
loop :: Int -> IO ()
loop i = do
        putStrLn (show i ++ " bottles of irn bru")
        if i == 0
         then pure ()
         else loop (i-1) 

