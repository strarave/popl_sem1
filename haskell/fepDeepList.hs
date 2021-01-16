data DeepList a = Value a | Collection [DeepList a]

instance Show a => Show (DeepList a) where
    show (Value a) = show a
    show (Collection l) = show l

fep :: DeepList a -> DeepList a 
fep (Value v) = Collection [(Value v), (Collection [(Value v)]), (Value v)]
