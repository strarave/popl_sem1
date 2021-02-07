-- data Graph a = Node a | Edge (Graph a) (Graph a)

-- instance Functor Graph where
--     fmap f (Node a) = Node $ f a
--     fmap f (Edge l r) = Edge (fmap f l) (fmap f r)

data Graph a = Node a [Graph a] | Leaf a -- node and list of connected nodes or leaf

instance Functor Graph where
    fmap f (Node v l) = Node (f v) $ fmap f l
    fmap f (Leaf a) = Leaf $ f a