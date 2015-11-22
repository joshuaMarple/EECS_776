--first project
import Data.Char

h x = if x == 32 then ' ' else ['A'..'Z'] !! x
rot13 x = map h $ map (\z -> if z == ' ' then 32 else mod ((ord z) - 52) 26) x

main :: IO ()
main = do 
print $ rot13 "BURRITO"
print $ rot13 $ rot13 "BURRITO"
print $ rot13 "MY NAME IS INIGO MONTOYA"
print $ rot13 $ rot13 "MY NAME IS INIGO MONTOYA"
 
