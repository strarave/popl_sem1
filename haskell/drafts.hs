module DRAFTS where

numsFrom :: Integer -> [Integer]
numsFrom n = n : (numsFrom $ n + 1)

-- I should know the null term for every possible data type
inject :: (a -> a -> a) -> [a] -> a
inject f (x:(xs:[])) = f x xs 
inject f (x:(xs:xss)) = f (f x xs) (inject f xss)