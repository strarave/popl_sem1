data BFList a = Back [a] | Forth [a]

instance Show BFList where
    show (Back l) = "-" ++ show l
    show (Forth l) = "+" ++ show l

instance Eq BFList where
    (Back l) == (Forth l') = False
    (Forth l) == (Back l') = False
    (Forth l) == (Forth l') = l == l'
    (Back l) == (Back l') == l == l'

Back l <++> Back l' = Back $ l ++ l'
Forth l <++> Forth l' = Forth $ l ++ l'
Back l <++> Forth [] = Back l
Forth l <++> Back [] = Forth l
Back [] <++> Forth l = Forth l
Forth [] <++> Back l = Back l
Back (x:xs) <++> Forth (x':xs') == Back xs <++> Forth xs'
Forth (x:xs) <++> Back (x':xs') == Forth xs <++> Back xs'

instance Functor BFList where
    fmap f (Back l) = Back $ fmap f l
    fmap f (Forth l) = Forth $ fmap f l

instance Foldable BFList where
    foldr f z (Back l) = Back $ foldr f z l
    foldr f z (Forth l) = Forth $ foldr f z l
    
instance Applicative BFList where
    pure x = Forth [x]
    -- classic concatmap impl

