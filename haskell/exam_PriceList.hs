data PriceList a = PriceList [(a, Float)]

-- make pricelist functor, foldable, applicative

-- aux function to reduce to a list
toList :: PriceList [a] -> [a]
toList PriceList [(a, f)] = concatMap (\(x, y) -> [x]) [(a, f)]

-- foldable:
instance Foldable PriceList where
    foldr z f (PriceList [(a, f)]) = foldr z f $ toList (PriceList [(a, f)])