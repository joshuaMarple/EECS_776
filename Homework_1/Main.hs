--first project
import Data.Char

chars = ['A'..'Z']

g :: Char -> Int
g ' ' = 32
g x = mod ((ord x ) - 65 + 13) 26

f :: [Char] -> [Int]
f xs = map g xs

h :: Int -> Char
h 32 = ' '
h x = chars !! x

rot13 :: [Char] -> [Char]
rot13 x = map h $ f x

main :: IO ()
main = do 
print $ rot13 "BURRITO"
print $ rot13 $ rot13 "BURRITO"
print $ rot13 "MY NAME IS INIGO MONTOYA"
print $ rot13 $ rot13 "MY NAME IS INIGO MONTOYA"
 
