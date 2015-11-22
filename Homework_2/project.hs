{-# LANGUAGE GADTs, KindSignatures #-}
-- second project

import Data.List

data Pizza :: * where
   Pizza :: Crust -> [Topping] -> Size -> Pizza

showList' :: Show a => [a] -> String
showList' = intercalate ", " . map show 

instance Show Pizza where
    show (Pizza c t s) = "You ordered a " ++
                         show(s) ++ " pizza with " ++
                         show(c) ++ " crust.\n" ++ 
                         "It has toppings of " ++ showList' t  ++ "."
    
data Crust = Thin | Chicago | Stuffed | HandTossed
    deriving (Enum, Show)

data Topping = 
      Cheese 
    | Pepperoni 
    | Anchovies
    | Pineapples
    | Sausage
    | Veggies
    | Pepper 
    | Olives
    | Tomatoes
    | Mushrooms
    | Ham
    | Salami
    | Chicken
    | Bacon
    | Hamburger
    deriving (Enum, Show)

data Size = Small | Medium | Large
    deriving (Enum, Show)

