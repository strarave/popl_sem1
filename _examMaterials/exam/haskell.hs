-- Consider the following data structure for general binary trees:
-- Using the State monad as seen in class:
-- 1) Define a monadic map for Tree, called mapTreeM.
-- 2) Use mapTreeM to define a function which takes a tree and returns a tree containing list 
--      of elements that are all the data found in the original tree in a depth-first visit.

data Tree a = Empty | Branch (Tree a) a (Tree a) deriving (Show, Eq)

-- monadic map
mapTreeM f Empty = do return Empty
mapTreeM f (Branch lt val rt) = do
    lt' <- mapTreeM f lt
    rt' <- mapTreeM f rt
    val' = f val
    return (Branch lt' val' rt')

-- the idea is to store the values list in the state, and appending 
-- the read value (val) to the state, then propagating treeToListTree
-- down the left and right subtrees
-- I will use the RunState, PutState and GetState functions as seen in the classes
treeToListTree t = runStateM (mapTreeM appendValues t) Empty
    where appendValues x = do
        vals <- GetState
        PutState(vals ++ x) -- append current value
        return (vals ++ x) -- setting current value

