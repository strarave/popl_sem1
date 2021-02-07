data PriceList a = PriceList [(a, FLoat)] deriving Show

concatPriceList :: PriceList a -> PriceList a -> PriceList a
concatPriceList (PriceList l) (PriceList l') = PriceList $ append l l'

instance Foldable PriceList where
    foldr f z (PriceList []) = z 
    foldr f z (PriceList (x:xs)) = f z $ foldr f z (PriceList xs)

instance Functor where
    fmap f (PriceList []) = PriceList []
    fmap f (PriceList (x:xs)) = 

instance Applicative PriceList where
    pure a = PriceList [(a, 0.0)]
    PriceList [(f, fv)] <*> PriceList [(d, dv)] = 