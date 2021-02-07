data ListLenght a = ListLenght Int [a] deriving Show
data Lt a = Lt [ListLenght a] deriving Show

checkLt :: Lt a -> Bool
checkLt Lt [] = True
checkLt Lt [(i lst)] = let
    declared = i
    actual = lenght lst
    in if actual == declared then return True else False