data Color = Yellow | Blue
data TTree a Color = Node a Color (TTree a) (TTree a) (TTree a) | Leaf a Color

instance Functor (TTree a) where
    fmap f (Leaf a c) = Leaf (f a) c
    fmap f (Node a c t1 t2 t3) = TTree (f a) c (fmap f t1) (fmap f t2) (fmap f t3)

instance Foldable (TTree a) where
    foldr f z (TTree a c t1 t2 t3) = f (foldr f (foldr f (foldr f z t3) t2) t1) a
