data Multinode k v = Multinode { key :: k, values :: [v]}
data Multimap k v = Multimap [Multinode k v]

mapOnNode :: (a -> b) -> Multinode k a -> Multinode k b
mapOnNode f (Multinode k v) = Multinode k $ map f v

mapOnNodes :: (a -> b) -> [Multinode k a] -> [Multinode k b]
mapOnNodes f (c:n) = [mapOnNode f c] ++  mapOnNodes f n
mapOnNodes _ [] = []

instance Functor (Multimap k) where
    fmap f (Multimap []) = Multimap []
    fmap f (Multimap l) = Multimap (mapOnNodes f l) 
    
lookup :: Eq k => k -> Multimap k v -> [v]
lookup k (Multimap []) = []
lookup k (Multimap (m:n)) = let 
    current = m.key
    vals = m.values
    in
        if current == k 
            then vals
            else lookup k (Multimap n)

insert :: Eq k => k -> v -> Multimap k v -> Multimap k v
insert k v (Multimap []) = Multimap (Multinode k v)

remove :: Eq v => v -> Multimap k v -> Multimap k v
remove x (Multimap []) = Multimap []

    

