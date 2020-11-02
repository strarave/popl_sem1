module DATATYPES where
    import TreeADT
    data Point = Point Float Float

    pointY (Point _ y) = y
    pointX (Point x _) = x