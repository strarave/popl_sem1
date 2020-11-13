  -- another ADT that represents a vector path in a floats field
    data Path = 
        End Float Float | 
        Next Float Float Path 
        deriving (Show, Eq)
    
    -- getters
    abscissa :: Path -> Float
    abscissa (End a b) = a
    abscissa (Next a b _) = a

    ordinate :: Path -> Float
    ordinate (End a b) = b
    ordinate (Next a b _) = b

    -- a checker for the end of the path
    arrived :: Path -> Bool 
    arrived (End _ _) = True
    arrived _ = False

    -- stepper function (as "left, right" for the TREEADT)
    step :: Path -> Path
    step (Next _ _ n) = n
    step (End a b) = (End a b)

    -- fold
    instance Foldable Path where
        foldr f z (End a b) = f (f a z) (f b z)
        foldr f z (Next a b n) = f (f (f z a) (f z b)) (pfold f z n)


    -- length function
    -- it's a fold operation
    distance :: Path -> Float
    distance (Next a b (End c d)) = ((c - a)**2 + (d - b)**2)**(0.5)
    distance (Next a b n) = 
        (((a - abscissa n)**2 + (b - ordinate n)**2)**(0.5)) + distance n 
    distance (End a b) = ((a**2 + b**2)**(0.5))