data ITree a = ITree a (ITree a) (ITree a)
    deriving (Show, Eq)

data SimpleTree a = Branch a (SimpleTree a) (SimpleTree a) | Leaf a

costITree :: a -> ITree a
costITree x = ITree x (costITree x) (costITree x)

list2ITree :: [a] -> ITree a
list2ITree (x:xs) = ITree x (list2ITree xs) (list2ITree xs)

-- MAP
instance Functor ITree where
    fmap f (ITree x l r) = ITree (f x) (fmap f l) (fmap f r)

takeLevels :: Int -> ITree x -> SimpleTree x
takeLevels 0 (ITree x _ _) = (Leaf x)
takeLevels n (ITree x l r) = Branch x (takeLevels (n - 1) l) (takeLevels (n - 1) r)

applyOnLevels :: (a -> a) -> (a -> Bool) -> ITree a -> ITree a
applyOnLevels f p (ITree v l r) =
    if (p v) 
        then    
            ITree (f v) (applyOnLevels f p l) (applyOnLevels f p r)
        else 
            ITree v (applyOnLevels f p l) (applyOnLevels f p r)