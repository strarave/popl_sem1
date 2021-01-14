-- We want to define a data structure, called BFlist (Back/Forward list), to define lists that can either be
-- “forward” (like usual list, from left to right), or “backward”, i.e. going from right to left.
-- We want to textually represent such lists with a plus or a minus before, to state their direction: e.g. +[1,2,3] is
-- a forward list, -[1,2,3] is a backward list.
-- Concatenation (let us call it <++>) for BFlist has this behavior: if both lists have the same direction, the
-- returned list is the usual concatenation. Otherwise, forward and backward elements of the two lists delete
-- each other, without considering their stored values.
-- For instance: +[a,b,c] <++> -[d,e] is +[c], and -[a,b,c] <++> +[d,e] is -[c].
-- 1) Define a datatype for BFlist.
-- 2) Make BFList an instance of Eq and Show, having the representation presented above.
-- 3) Define <++>, i.e. concatenation for BFList.
-- 4) Make BFList an instance of Functor.
-- 5) Make BFList an instance of Foldable.
-- 6) Make BFList an instance of Applicative.

data BFList a = Forward [a] | Backward [a]

instance Show a => Show (BFList a) where
    show (Forward l) = "+" ++ show l
    show (Backward l) = "-" ++ show l

instance Eq a => Eq (BFList a) where
    (Forward l1) == (Forward l2) = l1 == l2
    (Backward l1) == (Backward l2) = l1 == l2
    _ == _ = False

concatBF :: BFList a -> BFList a -> BFList a
concatBF (Forward l1) (Forward l2) = Forward $ concat [l1, l2]
concatBF (Backward l1) (Backward l2) = Backward $ concat [l2, l1]
concatBF (Backward l1) (Forward l2) 
    | length l1 == length l2 = Backward []
    | length l1 > length l2 = Backward $ drop (length l2) l1
    | length l1 < length l2 = Forward $ drop (length l1) l2
concatBF (Forward l1) (Backward l2)
    | length l1 == length l2 = Forward []
    | length l1 > length l2 = Forward $ drop (length l2) l1
    | length l1 < length l2 = Backward $ drop (length l1) l2

instance Foldable BFList where
    foldr f z (Backward l) = foldr f z $ reverse l
    foldr f z (Forward l) = foldr f z l

instance Functor BFList where
    fmap f (Backward l) = Backward $ fmap f l
    fmap f (Forward l) = Forward $ fmap f l

instance Applicative BFList where
    pure a = Forward [a]
    (Forward fl) <*> (Forward dl) = Forward $ fl <*> dl
    (Forward fl) <*> (Backward dl) = Forward $ fl <*> dl
    (Backward fl) <*> (Forward dl) = Backward $ fl <*> dl
    (Backward fl) <*> (Backward dl) = Backward $ fl <*> dl