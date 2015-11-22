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

        let loop = do
            atomically $ take_left_chopstick
            atomically $ take_right_chopstick
            eat
            atomically $ release_left_chopstick
            atomically $ release_right_chopstick
            loop

        let takeID = do
            my_id <- atomically (readTVar id)
            writeTVar id $ (atomically (readTVar id)) + 1
        
        forkIO $ takeID $ loop
        forkIO $ takeID $ loop
        forkIO $ takeID $ loop
        forkIO $ takeID $ loop
        forkIO $ takeID $ loop

take_left_chopstick :: TVar -> Int -> IO ()
take_left_chopstick a i = print ("pbfff") 

take_right_chopstick :: TVar -> Int ->IO ()
take_right_chopstick a i = print ("fffbp")


release_left_chopstick :: TVar -> Int ->IO ()
release_left_chopstick a i = print ("fffbp")

release_right_chopstick :: TVar -> Int ->IO ()
release_right_chopstick a i = print ("fffbp")

eat :: Int -> IO ()
eat id = print ("I'm philosopher ", id, " and I'm eating now.")
