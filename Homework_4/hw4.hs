{-# LANGUAGE GADTs, KindSignatures #-}

import Control.Applicative
import Control.Monad


-- problem 1
fmap' :: Applicative f => (a -> b) -> f a -> f b
fmap' f fs = pure f <*> fs 

-- problem 2
myAp :: Applicative f => f (a -> b) -> f a -> f b
myAp fab fa = liftA2 (\ g a -> g a) fab fa  

liftA2' :: Applicative f => (a -> b -> c) -> f a -> f b -> f c
liftA2' f a b = (fmap f a) <*> b

-- problem 3
join' :: Monad m => m (m a) -> m a
join' a = a >>= id

bind' :: Monad m => m a -> (a -> m b) -> m b
bind' a f = join (liftM f a)
