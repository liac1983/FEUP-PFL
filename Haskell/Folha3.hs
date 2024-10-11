-- 3.2

dec2int :: [Int] -> Int
dec2int = foldl (\acc x -> acc * 10 + x) 0 -- zero é o valor inicial

-- 3.3

myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith _ [] _ = []
myZipWith _ _ [] = []
myZipWith f (x:xs) (y:ys) = f x y : myZipWith f xs ys


-- 3.1
-- Original usando lista em compreensão
original :: (a -> b) -> (a -> Bool) -> [a] -> [b]
original f p xs = [f x | x <- xs, p x]

-- Usando map e filter
reescrito :: (a -> b) -> (a -> Bool) -> [a] -> [b]
reescrito f p xs = map f (filter p xs)


-- 3.4
-- Função insert que insere um elemento na lista ordenada
insert :: Ord a => a -> [a] -> [a]
insert x [] = [x]
insert x (y:ys)
  | x <= y    = x : y : ys
  | otherwise = y : insert x ys

-- Função isort usando foldr e insert
isort :: Ord a => [a] -> [a]
isort = foldr insert []

-- 3.5.a)
{- foldl1 :: (a -> a -> a) -> [a] -> a
foldl1 _ []     = error "foldl1: empty list"
foldl1 f (x:xs) = foldl f x xs

foldr1 :: (a -> a -> a) -> [a] -> a
foldr1 _ []     = error "foldr1: empty list" -- Não pode ser chamada em listas vazias
foldr1 _ [x]    = x                          -- Se houver apenas um elemento, esse é o resultado
foldr1 f (x:xs) = f x (foldr1 f xs)  -}          -- Caso geral: aplica a função recursivamente


mymaximum :: Ord a => [a] -> a
mymaximum = foldl1 max


myminimum :: Ord a => [a] -> a
myminimum = foldr1 min

-- 3.5.b)
myfoldl1 :: (a -> a -> a) -> [a] -> a
myfoldl1 _ []     = error "foldl1: empty list"
myfoldl1 f xs     = foldl f (head xs) (tail xs)

myfoldr1 :: (a -> a -> a) -> [a] -> a
myfoldr1 _ []     = error "foldr1: empty list"
myfoldr1 f xs     = foldr f (last xs) (init xs)

-- 3.6
-- until :: (a -> Bool) -> (a -> a) -> a -> a

-- O until aplica uma função até uma condiçãao ser verdadeira
-- mdc :: Int -> Int -> Int
-- mdc a b = until (\b -> b == 0) (\(a, b) -> (b, a `mod` b)) a

mymdc :: Int -> Int -> Int
mymdc a b = fst (until (\(a, b) -> b == 0) (\(a, b) -> (b, a `mod` b)) (a, b))


-- 3.7.a)
myConcat :: [a] -> [a] -> [a]
-- myConcat xs ys = foldr (:) ys xs
myConcat l1 l2 = foldr(\x acc -> x:acc) l2 l1

-- 3.7.b)
concat :: [[a]] -> [a]
concat = foldr (++) []

-- 3.7.c)
reverse :: [a] -> [a]
reverse = foldr (\x acc -> acc ++ [x]) []

-- 3.7.d)
-- reverse :: [a] -> [a]
-- reverse = foldl (\acc x -> x : acc) []

-- 3.7.e)
myelem :: Eq a => a -> [a] -> Bool
myelem x = any (\a -> a == x)


-- 3.8.a)

palavras :: String -> [String]
palavras s = palavrasAux s []

-- Função auxiliar que acumula a palavra atual e constrói a lista de palavras
palavrasAux :: String -> String -> [String]
palavrasAux [] [] = []
palavrasAux [] acc = [acc]
palavrasAux (c:cs) acc
  | c == ' '  = if null acc then palavrasAux cs [] else acc : palavrasAux cs []
  | otherwise = palavrasAux cs (acc ++ [c])


-- 3.8.b)
despalavras :: [String] -> String
despalavras [] = ""
despalavras [x] = x
despalavras (x:xs) = x ++ " " ++ despalavras xs

-- 3.9

myscanl :: (b -> a -> b) -> b -> [a] -> [b]
myscanl _ z []     = [z]  -- Se a lista está vazia, retornamos apenas o valor inicial
myscanl f z (x:xs) = z : myscanl f (f z x) xs  -- Aplicamos a função e continuamos com o próximo valor acumulado



-- 3.10
primos :: [Int]
primos = crivo [2..]
  where
    crivo (p:xs) = p : crivo [x | x <- xs, x `mod` p /= 0]


factores :: Int -> [Int]
factores 1 = []  -- Se o número é 1, a lista de fatores é vazia
factores n = fatorar n primos
  where
    fatorar n (p:ps)
      | n < p * p      = [n]    -- Se n é menor que p², ele é primo
      | n `mod` p == 0 = p : fatorar (n `div` p) (p:ps)  -- Divide por p e continua
      | otherwise      = fatorar n ps  -- Tenta o próximo primo


-- 3.11
calcPi1 :: Int -> Double
calcPi1 n = 4 * sum (take n (zipWith (/) (cycle [1, -1]) [1, 3..]))

calcPi2 :: Int -> Double
calcPi2 n = 3 + sum (take n (zipWith3 (\s a b c -> s * (4 / (a * b * c))) (cycle [1, -1]) [2,4..] [3,5..] [4,6..]))






