-- The following data structure represents a cash register. As it should be clear from the two accessor
-- functions, the first component represents the current item, while the second component is used to store
-- the price (not necessarily of the item: it could be used for the total).
-- make it Functor, Applicative, Monad

data CashRegister a = CashRegister { getReceipt :: (a, Float) } deriving (Show, Eq)
getCurrentItem = fst . getReceipt
getPrice = snd . getReceipt

instance Functor CashRegister where
    fmap f c = CashRegister (f $ getCurrentItem c, getPrice c)

