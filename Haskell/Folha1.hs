{- Ex1.11.a
max3 :: Ord a => a -> a -> a -> a
max3 x y z = max x (max y z)

min3 :: Ord a => a -> a -> a -> a
min3 x y z = min x (min y z)

Ex 1.11.b
max3 :: Ord a => a -> a -> a -> a
max3 x y z = max x (max y z)

min3 :: Ord a => a -> a -> a -> a
min3 x y z = min x (min y z)

Ex 1.14.a 

curta :: [a] -> Bool
curta xs = length xs <= 2

Ex1.14.b -}


curta :: [a] -> Bool
curta []     = True   -- Lista vazia, considerada curta
curta [_]    = True   -- Lista com um elemento, considerada curta
curta [_,_]  = True   -- Lista com dois elementos, considerada curta
curta _      = False  -- Outros casos, considerada não curta

