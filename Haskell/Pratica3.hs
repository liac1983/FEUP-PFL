-- 3.1
original :: (a -> b) -> (a -> Bool) -> [a] -> [b]
original f p xs = [f x | x <- xs, p x]

-- 3.2
dec2int :: [Int] -> Int
dec2int = foldl (\acc x -> acc * 10 + x)

-- 3.3
myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith _ [] _ = []
myZipWith _ _ [] = []
myZipWith f (x:xs) (y:ys) = f x y: myZipWith f xs ys


-- 3.4
insert :: Ord a => a -> [a] -> [a]
insert x [] = [x]
insert x (y:ys)
    | x <= y = x : y : ys
    |otherwise = y : insert x ys

isort :: Ord a => [a] -> [a]
isort = foldr insert []

-- 3.5
mymaximum :: Ord a => [a] -> a 
mymaximum = foldl1 max

myminimum :: Ord a => [a] -> A
myminimum = foldr1 min

-- 3.5.b

myfoldl1 :: (a->a->a) -> [a] -> A
myfoldl1 _ [] = error "fold1: empty list"
myfoldl1 f xs = foldl f (head xs) (tail xs)

myfoldr1 :: (a -> a -> a) -> [a] -> A
myfoldr1 _ [] = error "doldr1: empty list"
mydoldr1 f xs = foldr f (last xs) (init xs)

-- 3.6
mymdc :: Int -> Int -> Int
mymdc a b = fst (until (\(a,b) -> b == 0) (\(a,b) -> (b,a`mod`b)) (a,b))

-- 3.7.e
myelem :: Eq a => a -> [a] -> Bool
myelem x = any (\a -> a == x)

-- 3.8
palavras :: String -> [String]
palavras s = palavrasAux s []

palavrasAux :: Strng -> String -> [String]
palavrasAux [] [] = []
palavrasAux [] acc = [acc]
palavrasAux (c:cs) scc
    |c == ' ' = if null acc then palavrasAux cs [] else acc : palavrasAux cs []
    |otherwise = palavrasAux cs (acc ++ [c])

-- 3.8.b
despalavras :: [String] -> String
despalavras [] = ""
despalavras [x] = x
despalavras (x:xs) = x ++ " " ++ despalavras xs


-- 3.9
myscanl :: (b -> a -> b) -> b -> [a] -> [b]
myscanl _ z [] = [z] 
myscanl f z (x:xs) = z : myscanl f (f z x) xs

-- 3.10
primos :: [Int]
primos = crivo [2..]
    where 
        crivo (p:xs) = p : crivo [x | x <- zs, x `mod` p /= 0]

factores :: Int -> [Int]
factores 1 = []
factores n = fatorar n primos
    where
        factorar n (p:ps)
            |n < p * p = [n]
            |n `mod` p == 0 = p : fatorar (n `div` p) (p:ps)
            |otherwise = fatorar n ps 

-- 3.11
calcPi1 :: Int -> Double
calcPi1 n = 4 * sum (take n (zipWith (\) (cycle [1, -1]) [1,3..]))


