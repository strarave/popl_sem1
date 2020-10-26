module ES1 where

fact :: Int -> Int
fact 0 = 1
fact n = n * fact (n-1)

facti :: Integer -> Integer
facti 0 = 1
facti n = n * facti (n-1)

fibonacci :: Integer -> Integer
fibonacci n | n == 0 = 0
            | n == 1 = 1
            | otherwise = fibonacci (n - 1) + fibonacci(n - 2)


rightTriangle :: Integer -> [(Integer, Integer, Integer)]
rightTriangle n = [(a, b, c) | a <- [1..n], b <- [1..n], c <- [1..n], a^2 == b^2 + c^2]

pack :: Eq a => [a] -> [[a]]
pack l = packAux l [] []

packAux :: Eq a => [a] -> [a] -> [[a]] -> [[a]]
packAux [] currPack acc = currPack : acc
packAux (x:xs) [] acc = packAux xs [x] acc
packAux (x:xs) currPack@(y:ys) acc
    | x == y = packAux xs (x:currPack) acc
    | otherwise = packAux (x:xs) [] (currPack:acc)
