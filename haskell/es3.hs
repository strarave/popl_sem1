module Es3 where 

newtype ZipList a = ZL [a] deriving (Eq, Show)

instance Functor ZipList where
fmap f (ZL xs) = ZL $ map f xs

instance Applicative ZipList where
pure x = ZL [x]
(ZL fl) <*> (ZL xs) = ZL $ map (\f e -> f e) (zip fl xs)

