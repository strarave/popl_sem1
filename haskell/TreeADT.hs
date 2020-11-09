module TreeADT (Tree, leaf, branch, fringe, left, right, cell, isLeaf, 
    Path) where

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

    -- another ADT that represents a vector path in a floats field
    data Path = 
        End Float Float | 
        Next Float Float Path 
        deriving (Show, Eq)
    
    -- getters
    abscissa :: Path -> Float
    abscissa (End a b) = a
    abscissa (Next a b _) = a

    -- a checker for the end of the path
    arrived :: Path -> Bool 
    arrived (End _ _) = True
    arrived _ = False

    -- stepper function (as "left, right" for the TREEADT)
    step :: Path -> Path
    step (Next _ _ n) = n
    step (End a b) = (End a b)

    ordinate :: Path -> Float
    ordinate (End a b) = b
    ordinate (Next a b _) = b

    -- length function
    -- it's a fold operation
    distance :: Path -> Float
    distance (Next a b (End c d)) = ((c - a)**2 + (d - b)**2)**(0.5)
    distance (Next a b n) = 
        (((a - abscissa n)**2 + (b - ordinate n)**2)**(0.5)) + distance n 
    distance (End a b) = ((a**2 + b**2)**(0.5))