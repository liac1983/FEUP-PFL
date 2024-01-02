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

Ex1.14.b 


curta :: [a] -> Bool
curta []     = True   -- Lista vazia, considerada curta
curta [_]    = True   -- Lista com um elemento, considerada curta
curta [_,_]  = True   -- Lista com dois elementos, considerada curta
curta _      = False  -- Outros casos, considerada não curta


-- 1.1
testaTriangulo :: Float -> Float -> Float -> Bool
testaTriangulo a b c = a < b + c && b < a + c && c < a + b

-- 1.2
areaTriangulo :: Float -> Float -> Float -> Float
areaTriangulo a b c =
  let s = (a + b + c) / 2  -- Semiperímetro
      area = sqrt (s * (s - a) * (s - b) * (s - c))
  in area

-- 1.3
metades :: [a] -> ([a], [a])
metades lista =
  let len = length lista
      metade = len `div` 2
      primeiraMetade = take metade lista
      segundaMetade = drop metade lista
  in (primeiraMetade, segundaMetade)


-- 1.4.a)

last' :: [a] -> a
last' = head . reverse

last'' :: [a] -> a
last'' xs = head (drop (length xs - 1) xs)

-- 1.4.b)

init' :: [a] -> [a]
init' = reverse . tail . reverse


init'' :: [a] -> [a]
init'' xs = take (length xs - 1) xs

-}


