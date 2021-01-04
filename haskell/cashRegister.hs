-- The following data structure represents a cash register. As it should be clear from the two accessor
-- functions, the first component represents the current item, while the second component is used to store
-- the price (not necessarily of the item: it could be used for the total).
-- make it Functor, Applicative, Monad

data CashRegister a = CashRegister { getReceipt :: (a, Float) } deriving (Show, Eq)
getCurrentItem = fst . getReceipt
getPrice = snd . getReceipt

instance Functor CashRegister where
    fmap f c = CashRegister (f $ getCurrentItem c, getPrice c)

instance Applicative CashRegister where
    pure c = CashRegister (c, 0.0)
    fc <*> dc = CashRegister(getCurrentItem fc $ getCurrentItem dc, getPrice fc + getPrice dc) 

instance Monad CashRegister where
    return = pure
    dc >>= fun = 

-- solution
instance Functor CashRegister where
    fmap f cr = CashRegister (f $ getCurrentItem cr, getPrice cr)

instance Applicative CashRegister where
    pure x = CashRegister (x, 0.0)
    CashRegister (f, pf) <*> CashRegister (x, px) = CashRegister (f x, pf + px)

instance Monad CashRegister where
    CashRegister (oldItem, price) >>= f = 
        let newReceipt = f oldItem in CashRegister (getCurrentItem newReceipt, price + (getPrice newReceipt))