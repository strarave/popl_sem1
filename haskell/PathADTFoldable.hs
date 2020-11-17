-- another ADT that represents a vector path
data Path a = 
  Empty |
  Next a a (Path a) 
  deriving (Show, Eq)

-- getters
abscissa :: (Path a) -> a
abscissa (Next a b _) = a

ordinate :: (Path a) -> a
ordinate (Next a b _) = b

-- property function
isEmpty :: (Path a) -> Bool
isEmpty Empty = True
isEmpty _ = False

-- stepper function (as "left, right" for the TREEADT)
step :: (Path a) -> (Path a)
step (Next _ _ n) = n
step Empty = Empty

-- converter to list
toList :: (Path a) -> [[a]]
toList Empty = []
toList (Next a b n) = ((a:(b:[])):(toList n))

-- FOLD
instance Foldable Path where
  foldr f z Empty = z
  foldr f z (Next a b n) = f a $ f b $ foldr f z n

-- MAP
instance Functor Path where
  fmap f Empty = Empty
  fmap f (Next a b n) = Next (f a) (f b) (fmap f n)

-- path concatenation: it's just and append function for paths
-- and the implementation is the most intuitive
pconcat :: (Path a) -> (Path a) -> (Path a)
pconcat Empty p = p
pconcat p Empty = p
pconcat (Next a b n) z = (Next a b (pconcat n z))

-- mono parameter concatenation
pconc :: (Path a) -> (Path a)
pconc p = pconcat Empty p

-- path flatten: from a "path of paths" this function extracts all annidated paths
-- and concatenate them
pflatten :: Path (Path a) -> Path a
pflatten Empty = Empty
-- the pattern for "Next" should take account of all possible nesting
pflatten (Next p1 p2 n) = pconcat p1 $ pconcat p2 $ pconc $ pflatten n

-- APPLICATIVE
instance Applicative Path where
  pure a = (Next a a Empty)
  fp <*> dp = pflatten $ fmap (\f -> fmap f dp) fp
