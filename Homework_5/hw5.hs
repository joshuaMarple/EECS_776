{-# LANGUAGE GADTs, KindSignatures #-}

import Control.Concurrent.STM
import Control.Concurrent

import Data.IORef

main = do
        id <- newTVarIO 0
        
        chopstick0 <- newTVarIO 1 
        chopstick1 <- newTVarIO 1 
        chopstick2 <- newTVarIO 1 
        chopstick3 <- newTVarIO 1 
        chopstick4 <- newTVarIO 1
        chops <- [chopstick0,chopstick1, chopstick2,chopstick3,chopstick4]

        let loop my_id = do
            atomically $ take_left_chopstick ((readTVar my_id) -1) chops 
            atomically $ take_right_chopstick (readTVar my_id) chops
            eat my_id
            atomically $ release_left_chopstick ((readTVar my_id) - 1) chops
            atomically $ release_right_chopstick (readTVar my_id) chops
            loop my_id

        let takeID = do
            my_id <- atomically (readTVar id)
            writeTVar id $ (atomically (readTVar id)) + 1
            loop my_id
        
        forkIO $ takeID 
        forkIO $ takeID
        forkIO $ takeID
        forkIO $ takeID
        forkIO $ takeID

take_left_chopstick :: Int -> [TVar Int] -> STM ()
take_left_chopstick i chops = writeTVar (chops !! i) 0  

take_right_chopstick :: Int -> [TVar Int] -> STM ()
take_right_chopstick i chops = writeTVar (chops !! i) 0  

release_left_chopstick :: Int -> [TVar Int] -> STM ()
release_left_chopstick i chops = writeTVar (chops !! i) 1

release_right_chopstick :: Int -> [TVar Int] -> STM ()
release_right_chopstick i chops = writeTVar (chops !! i) 1

eat :: Int -> IO ()
eat id = print ("I'm philosopher ", id, " and I'm eating now.")
