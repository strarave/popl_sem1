
fixed::Eq a => (a -> a) -> a -> a
fixed f x = let i = f x in if i == x then x else fixed f i
