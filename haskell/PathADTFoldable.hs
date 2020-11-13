  -- another ADT that represents a vector path in a floats field
    data Path a = 
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

    -- stepper function (as "left, right" for the TREEADT)
    step :: (Path a) -> (Path a)
    step (Next _ _ n) = n
    step (End a b) = (End a b)

    -- fold
    instance Foldable Path where
        foldr f z (End _ b) = f b z
        foldr f z (Next _ b n) = foldr f (f b z) n