module TreeADT (Tree, leaf, branch, fringe, left, right, cell, isLeaf) where

    -- data type definition
    data Tree a = Leaf a | Branch (Tree a) (Tree a)

    -- "show function" definition
    fringe (Leaf x) = [x]
    fringe (Branch l r) = fringe l ++ fringe r 

    -- tree population functions
    leaf = Leaf
    branch = Branch

    -- tree navigation functions
    left (Branch l r) = l
    right (Branch l r) = r 
    cell (Leaf a) = a

    -- isLeaf
    isLeaf (Leaf _) = True
    isLeaf _ = False

    -- binary tree data structure
    fringe :: Tree a -> [a]
    leaf :: a -> Tree a
    branch :: Tree a -> Tree a -> Tree a
    left, right :: Tree a -> Tree a
    isLeaf :: Tree a -> Bool
    cell :: Tree a -> a

    -- instancig the show class to extends his capabilities to this data type
    instance Show a => Show (Tree a) where
        show (Leaf a) = show a
        show (Branch l r) = "<" ++ show l ++ "|" ++ show r ++ ">"
