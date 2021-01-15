data TreeList a = 
    Branch (TreeList a) (TreeList a) 
    | Next a (TreeList a)
    | Leaf a

-- example required
-- x = Branch (Leaf 1) (Next 2 (Branch (Branch (Leaf 3)(Leaf 4))(Next 5 (Next 6 (Leaf 7)))))

toList :: TreeList a -> [a]
toList (Leaf v) = [v]
toList (Next v n) = [v] ++ (toList n)
toList (Branch l r) = (toList l) ++ (toList r)

instance Show a => Show (TreeList a) where
    show (Leaf v) = show v
    show (Next v n) = show v ++ " then " ++ show n
    show (Branch l r) = " < " ++ show l ++ " > " ++ " < " ++ show r ++ " > " 

instance Foldable TreeList where
    foldr f z t = foldr f z $ toList t

instance Functor TreeList where
    fmap f (Leaf v) = Leaf $ f v
    fmap f (Next v n) = Next (f v) $ fmap f n
    fmap f (Branch l r) = Branch (fmap f l) (fmap f r)

-- concatenation between trees: a tree is appended to the "right most"
-- element in the base tree. In this case, all the possible list is also
-- used to search for the right most
tconcat :: TreeList a -> TreeList a -> TreeList a
tconcat (Branch l r) t = Branch l (tconcat r t)
tconcat (Next v n) t = Next v (tconcat n t)
tconcat (Leaf v) t = Next v t

instance Applicative TreeList where
    pure = Leaf
    ft <*> dt = tconcat $ fmap (\x -> fmap x dt) ft