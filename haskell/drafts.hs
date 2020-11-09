module DRAFTS where

-- simple implementation of the basic filter, map, reduce functions
-- and some other experiment with lazy evaluation on infinite computation

numsFrom :: Integer -> [Integer]
numsFrom n = n : (numsFrom $ n + 1)

-- I should know the null term for every possible data type
inject :: (a -> a -> a) -> [a] -> a
inject f (x:(xs:[])) = f x xs 
inject f (x:(xs:xss)) = f (f x xs) (inject f xss)

-- BUT i can ask the the user a first value
betterInject :: (a -> a -> a) -> a -> [a] -> a
betterInject f start [] = start
betterInject f start (h:t) = f h (betterInject f start t)

-- map implementation
traspose :: (a -> b) -> [a] -> [b]
traspose _ [] = []
traspose f (h:t) = (f h) : (traspose f t)

-- filter implementation
sieve :: (a -> Bool) -> [a] -> [a]
sieve _ [] = []
sieve fil (h:t) | fil h = h : (sieve fil t)
                | otherwise = sieve fil t