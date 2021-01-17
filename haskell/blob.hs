data Blob a = Blob a (a -> a) 
-- "Eq" can't be derived because an equality between functions can't be inferred

instance Eq a => Eq (Blob a) where
    (Blob x f1) == (Blob y f2) = (f1 x) == (f2 y)
instance Show a => Show (Blob a) where
    show (Blob x f) = "Blob " ++ (show (f x))

instance Functor Blob where
    fmap f (Blob a func) = Blob (f $ func a) func