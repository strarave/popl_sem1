-- another ADT that represents a vector path
data Path a = 
  Empty |
  End a a | 
  Next a a (Path a) 
  deriving (Show, Eq)

-- getters
abscissa :: (Path a) -> a
abscissa (End a b) = a
abscissa (Next a b _) = a

ordinate :: (Path a) -> a
ordinate (End a b) = b
ordinate (Next a b _) = b

-- property function
isEmpty :: (Path a) -> Bool
isEmpty Empty = True
isEmpty _ = False

-- stepper function (as "left, right" for the TREEADT)
step :: (Path a) -> (Path a)
step (Next _ _ n) = n
step (End a b) = (End a b)

-- converter to list
toList :: (Path a) -> [[a]]
toList Empty = []
toList (End a b) = ((a:(b:[])):[])
toList (Next a b n) = ((a:(b:[])):(toList n))

-- fold
instance Foldable Path where
  foldr f z (End a b) = f b $ f a z
  foldr f z (Next a b n) = f a $ f b $ foldr f z n

-- map
instance Functor Path where
  fmap f (End a b) = End (f a) (f b)
  fmap f (Next a b n) = Next (f a) (f b) (fmap f n)

-- journey to applicative: path concat, path concatMap
-- path concatenation
pconcat :: (Path a) -> (Path a) -> (Path a)
pconcat Empty p = p
pconcat p Empty = p
pconcat (End a b) n = (Next a b n)
pconcat (Next a b n) z = (Next a b (pconcat n z))

-- mono parameter concatenation
pconc :: (Path a) -> (Path a)
pconc p = pconcat Empty p

-- path concatMap
-- ...