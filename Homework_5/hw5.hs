{-# LANGUAGE GADTs, KindSignatures #-}

import Control.Concurrent.STM
import Control.Concurrent

import Data.IORef

main = do
        
        chopstick0 <- newTVarIO (1::Int) 
        chopstick1 <- newTVarIO (1::Int) 
        chopstick2 <- newTVarIO (1::Int) 
        chopstick3 <- newTVarIO (1::Int) 
        chopstick4 <- newTVarIO (1::Int)
        let chops = [chopstick0,chopstick1, chopstick2,chopstick3,chopstick4]

        let loop phil_id = do
            --phil_id <- readTVarIO my_id
            atomically $ take_chopstick (phil_id -1) chops 
            atomically $ take_chopstick phil_id chops
            eat phil_id
            atomically $ release_chopstick (phil_id - 1) chops
            atomically $ release_chopstick phil_id chops
            loop phil_id
 
        forkIO $ loop 1 
        forkIO $ loop 2
        forkIO $ loop 3
        forkIO $ loop 4
        forkIO $ loop 5

-- take_both_chopsticks :: Int -> [TVar Int] -> STM ()

take_chopstick :: Int -> [TVar Int] -> STM ()
take_chopstick i chops = do
  if i == 0
    then 
  chopup <- readTVarIO (chops !! i) 
  if (chopup == 1) 
    then writeTVar chopup 

release_chopstick :: Int -> [TVar Int] -> STM ()
release_chopstick (-1) chops = writeTVar (chops !! 4) 1
release_chopstick i chops = writeTVar (chops !! i) 1

eat :: Int -> IO ()
eat id = print ("I'm philosopher ", id, " and I'm eating now.")
