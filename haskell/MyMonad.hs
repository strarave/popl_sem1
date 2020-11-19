module MyMonad where
    import Prelude hiding (log)

    type Log = [String]

    data Logger a = Logger { content :: a, log :: Log }

    instance Eq a => Eq (Logger a) where
        l1 == l2 = content l1 == content l2

    instance Show a => Show (Logger a) where
        show l = show (content l) ++ "\n" ++ foldr (\line acc -> "\n\t" ++ line ++ acc) "" (log l)

    instance Functor Logger where
        fmap f l = Logger (f $ content l) (log l)

    instance Applicative Logger where
        pure x = Logger x []
        (Logger f l) <*> (Logger d l2) = Logger (f d) (l ++ l2)
    
    instance Monad Logger where
        return = pure
        Logger x oldLog >>= f = let Logger y newLog = f x
                                in Logger y (oldLog ++ newLog)
    
    incbyone :: Num n => n -> Logger n 
    incbyone x = Logger (x + 1) ["Increase by one"]
    
    mulbytwo :: Num n => n -> Logger n 
    mulbytwo x = Logger (x*2) ["Multiplied by two"]
    
    putLog :: String -> Logger ()
    putLog msg = Logger () [msg]
