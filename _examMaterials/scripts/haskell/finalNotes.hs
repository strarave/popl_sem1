module FINALEXERCISE where

    -- complete example
    import Prelude hiding (Either(..), either) -- importing and hiding structures and functions
    import Data.Char (digitToInt) 

    data Either a b = Left a | Right b -- data contructors (double dependency) 
        deriving (Eq, Ord, Show) -- deriving some classes for our class
    
    -- use of "don't care" symbol in parameters
    either :: (a -> c) -> (b -> c) -> Either a b -> c
    either f _ (Left x) = f x
    either _ g (Right x) = g x

    rights :: [Either a b] -> [b]
    rights l = [y | Right y <- l] -- list comprehension
    
    lefts :: [Either a b] -> [b]
    lefts l = [y | Left y <- l] -- list comprehension

    partitionEithers ::[Either a b] -> ([a], [b])
    partitionEithers = foldr (either left right) ([], [])
        where left x (l, r) = (x:l, r) -- where clause as switch cause
            right x (l, r) = (l, x:r)
    
    -- instancing an external class
    instance Functor (Either a) where 
        fmap f (Right x) = Right $ f x -- function composition
        fmap _ (Left x) = Left x
    
    -- functor laws:
    -- identity: fmap id = id (id is the identity function)
    -- homomorphism: fmap (f.g) = (fmap f) . (fmap g)


    instance Applicative (Either a) where
        pure = Right
        (Left f) <*> _ = Left f
        (Right f) <*> r = fmap f r
    
    -- applicative laws = functor laws +
    -- interchange: u <*> pure y = pure ($ y) <*> u   
    -- composition: pure (.) <*> u <*> v <*> w = u <*> (v <*> w)

    instance Monad (Either a) where
        return = pure
        (Right x) >>= f = f x
        (Left x) >>= _ = Left x
    
    -- monadic laws:
    -- left and right identity: (return x) >>= f = f x
    -- associativity: (m >>= f) >>= g = m >>= (\x -> (f x >>= g))

    -- boundaries to the parameters
    apply42 ::(Num b, Ord b) => (a -> b) -> a -> Either b b
    apply42 f x = let s = f x
        in if s > 42 then Right s else Left s -- "let->in" construction

    sequence42 x = do -- "do" notation: only possible with monads
        x' <- apply42 (+12) x -- assignement + recursive call
        x'' <- apply42 (\x -> x-6) x'
        apply42 (*2) x''

    parseEithers :: Char -> Either String Int
    parseEithers c 
        | isDigit c = Right $ digitToInt c -- guarded equation (pattern matching)
        | otherwise Left $ "Expected digit, got " ++ [c]

    parseNumber :: String -> Either String Int
    parseNumber sn = foldl parser (Right 0) sn
        where parser acc d = 
            do
                accp <- acc
                dp <- parseEithers d
                return $ accp * 10 + dp