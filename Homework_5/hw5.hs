{-# LANGUAGE GADTs, KindSignatures #-}

import Control.Concurrent.STM
import Control.Concurrent

import Data.IORef

main = do
        id <- newTVarIO (0::Int)
        
        chopstick0 <- newTVarIO (1::Int) 
        chopstick1 <- newTVarIO (1::Int) 
        chopstick2 <- newTVarIO (1::Int) 
        chopstick3 <- newTVarIO (1::Int) 
        chopstick4 <- newTVarIO (1::Int)
        let chops = [chopstick0,chopstick1, chopstick2,chopstick3,chopstick4]

        let loop phil_id = do
            --phil_id <- readTVarIO my_id
            -- atomically $ take_chopstick (phil_id -1) chops 
            -- atomically $ take_chopstick phil_id chops
            -- eat phil_id
            eat 1
            -- atomically $ release_chopstick (phil_id - 1) chops
            -- atomically $ release_chopstick phil_id chops
            loop phil_id

        let takeID = do
            my_id <- readTVarIO id
            
            atomically $ writeTVar id $ my_id + 1
            loop my_id
        
        forkIO $ takeID 
        forkIO $ takeID
        forkIO $ takeID
        forkIO $ takeID
        forkIO $ takeID

-- take_both_chopsticks :: Int -> [TVar Int] -> STM ()

take_chopstick :: Int -> [TVar Int] -> STM ()
take_chopstick (-1) chops = writeTVar (chops !! 4) 0
take_chopstick i chops = writeTVar (chops !! i) 0  

release_chopstick :: Int -> [TVar Int] -> STM ()
release_chopstick (-1) chops = writeTVar (chops !! 4) 1
release_chopstick i chops = writeTVar (chops !! i) 1

eat :: Int -> IO ()
eat id = print ("I'm philosopher ", id, " and I'm eating now.")
