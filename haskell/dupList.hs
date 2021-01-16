data Duplist a = Duplist [a] [a]
    deriving (Show, Eq)

instance Foldable Duplist where
    foldr f z (Duplist fl sl) = foldr f (foldr f z fl) sl

instance Functor Duplist where
    fmap f (Duplist fl sl) = Duplist (fmap f fl) (fmap f sl)

instance Applicative Duplist where
    pure a = Duplist [a] []
    (Duplist ffl sfl) <*> (Duplist fdl sdl) = Duplist (ffl <*> fdl) (sfl <*> sdl)