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

-- FOLD
instance Foldable Path where
  foldr f z (End a b) = f b $ f a z
  foldr f z (Next a b n) = f a $ f b $ foldr f z n

-- MAP
instance Functor Path where
  fmap f (End a b) = End (f a) (f b)
  fmap f (Next a b n) = Next (f a) (f b) (fmap f n)

-- path concatenation: it's just and append function for paths
-- and the implementation is the most intuitive
pconcat :: (Path a) -> (Path a) -> (Path a)
pconcat Empty p = p
pconcat p Empty = p
pconcat (End a b) n = (Next a b n)
pconcat (Next a b n) z = (Next a b (pconcat n z))

-- mono parameter concatenation
pconc :: (Path a) -> (Path a)
pconc p = pconcat Empty p

-- path flatten: from a "path of paths" this function extracts all annidated paths
-- and concatenate them
pflatten :: Path (Path a) -> Path a
pflatten Empty = Empty
pflatten (End p1 p2) = pconcat p1 p2
-- the pattern for "Next" should take account of all possible nesting
pflatten (Next p1 p2 n) = pconcat p1 $ pconcat p2 $ pconc $ pflatten n

-- APPLICATIVE
instance Applicative Path where
  pure a = End a a 
  fp <*> dp = pflatten $ fmap (\f -> fmap f dp) fp
