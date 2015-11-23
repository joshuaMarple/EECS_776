{-# LANGUAGE GADTs, KindSignatures #-}

import Control.Monad
import Control.Concurrent.STM
import Control.Concurrent
import Control.Monad.IO.Class


import Data.IORef

main = do
        
        chopstick0 <- newTVarIO (1::Int) 
        chopstick1 <- newTVarIO (1::Int) 
        chopstick2 <- newTVarIO (1::Int) 
        chopstick3 <- newTVarIO (1::Int) 
        chopstick4 <- newTVarIO (1::Int)
        let chops = [chopstick0,chopstick1, chopstick2,chopstick3,chopstick4]

        forkIO $ loop 0 chops
        forkIO $ loop 1 chops
        forkIO $ loop 2 chops
        forkIO $ loop 3 chops
        loop 4 chops


-- take_both_chopsticks :: Int -> [TVar Int] -> STM ()
loop :: Int -> [TVar Int] -> IO ()
loop phil_id chops = do
      

      
      atomically $ take_chopstick (phil_id - 1) phil_id chops 
      atomically $ take_chopstick phil_id phil_id chops
      left <- if (phil_id == 4)
        then 0
        else (phil_id - 1)
      right <- if (phil_id == 0)
                then 4
                else phil_id
      when (chops !! left == phil_id && chops !! right == phil_id ) (eat phil_id)
      
      atomically $ release_chopstick (phil_id - 1) chops
      atomically $ release_chopstick phil_id chops
      threadDelay(10000)
      loop phil_id chops

   

take_chopstick :: Int -> Int -> [TVar Int] -> STM ()
take_chopstick i id chops = do
  chopup <- if (i == (-1))
    then readTVar (chops !! 4) 
    else readTVar (chops !! i) 
  if (chopup == (-1)) 
    then if i == (-1) then writeTVar (chops !! 4) id else writeTVar (chops !! i) id 
    else return ()

release_chopstick :: Int -> [TVar Int] -> STM ()
release_chopstick (-1) chops = writeTVar (chops !! 4) (-1)
release_chopstick i chops = writeTVar (chops !! i) (-1)

eat :: Int -> IO ()
eat id = print("I'm philosopher " , id , " and I'm eating now.")
