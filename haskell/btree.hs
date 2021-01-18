data Tree a = Branch (Tree a) (Tree a) | Leaf a | Nil
    deriving (Show, Eq)

tcompose :: (a -> a -> a) -> Tree a -> Tree a -> Tree a
tcompose _ _ Nil = Nil
tcompose _ Nil _ = Nil
tcompose f (Leaf v) t2 = setValues f t2 v
tcompose f (Branch l r) = Branch (tcompose f l) (tcompose f r)

setValues :: (a -> a -> a) -> Tree a -> a -> Tree a
setValues f (Leaf a) x = Leaf $ f a x
setValues f (Branch l r) x = Branch (setValues f l x) (setValues f r x)

