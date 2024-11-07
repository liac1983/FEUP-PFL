-- 2.1
myand :: [Bool] -> Bool
myand [] = True
myand (x:xs) = x && myand xs

-- 2.2
myintersperse :: a → [a] → [a] 
myintersperse _ [] = []
myintersperse _ [x] = [x]
myintersperse sep (x:xs) = x : sep : myintersperse sep xs

-- 2.3
mdc :: Integer -> Integer -> Integer
mdc a 0 = a 
mdc a b = mdc b (a `mod` b)

-- 2.4
insert :: Ord a => a -> [a] -> [a]
insert x [] = [x]
insert x (y:ys)
    |x <= y  = x: y: ys
    |otherwise = y : insert x ys

-- 2.4.b
isort :: Ord a => [a] -> [a]
isort [] = []
isort (x:xs) = insert x (isort xs)

-- 2.5
myMinimum :: Ord a => [a] -> a
myMinimum [x] = x
myMinimum (x:xs) = min x (myMinimum xs)

-- 2.5.b
myDelete :: Eq a => a -> [a] -> [a]
myDelete _ [] = []
myDelete x (y:ys)
    |x == y = ys
    |otherwise = y:myDelete x ys


-- 2.5.c
ssort :: Ord a => [a] -> [a]
ssort [] = []
ssort xs = m : ssort (myDelete m xs)
    where m = myMinimum xs

-- 2.6
somaQuadrados : Integer
somaQuadrados = sum [x ^2 | x <- [1..100]]

-- 2.7
aprox :: Int -> Double
aprox n = 4 * sum [((-1) ^ k) / fromIntegral (2 * k +1) | k <- [0..n-1]]

-- 2.7.b

aprox' :: Int -> Double
aprox' n = sqrt (12 * sum [((-1) ^ k) / fromIntegral ((k +1) ^2) | k <- [0..n-1]])

compareAprox :: IO()
compareAprox = do
  putStrLn "Aproximações de pi com 10, 100 e 1000 termos:"
  putStrLn $ "Série 1 (n = 10): " ++ show (aprox 10) ++ ", Série 2 (n = 10): " ++ show (aprox' 10) ++ ", Prelude pi: " ++ show pi
  putStrLn $ "Série 1 (n = 100): " ++ show (aprox 100) ++ ", Série 2 (n = 100): " ++ show (aprox' 100) ++ ", Prelude pi: " ++ show pi
  putStrLn $ "Série 1 (n = 1000): " ++ show (aprox 1000) ++ ", Série 2 (n = 1000): " ++ show (aprox' 1000) ++ ", Prelude pi: " ++ show pi

-- 2.8
dotprod :: [Float] -> [Float] -> Float
dotprod xs ys = sum [x*y | (x,y) <- zip xs ys]

-- 2.9
divprop :: Integer -> [Integer]
divprod n = [x | x <- [1..n-1], n `mod` x == 0]

-- 2.10
isPerfect :: Integer -> Bool
isPerfect n = sum (divprod) == n

perfeitos :: Integer -> [Integer]
perfeitos limit = [x | x <- [1..limit], isPerfect x]

-- 2.11
pitagoricos :: Integer -> [(Integer, Integer, Integer)]
pitagoricos n = [(x,y,z) | x <- [1..n], y <- [1..n], z <- [1..n], x^2+y^2 == z^2]

-- 2.12
primo :: Integer -> Bool
primo n = divpord n == [1]

-- 2.13
mersennes :: [Integer]
mersenes = [2^n-1 | n <- [2..30], primo (2^n-1)]

-- 2.14
binom :: Integer -> Integer -> Integer
binom n k = factorial n `div` (factorial k * factorial (n-k))

factorial :: Integer -> Integer
factorial 0 = 1
factorial n = n * factorial (n-1)

pascal :: Integer -> [[Integer]]
pascal n = [[binm row k | k <- [0..row]] | row <- [0..n]]

-- 2.15
alfabeto :: string
alfabeto = ['A'..'Z']

deslocarChar :: Int -> Char -> Char
deslocarChar k c
    |c `elem` alfabeto = alfabeto !! ((pos+k) `mod` 26)
    |otherwise
    where pos = case elemIndex c alfabeto of
        just n -> n 
        Nothing -> 0

cifrar :: Int -> String -> String
cifrar k = map (deslocarChar k)

-- 2.16
myConcat :: [[a]] -> [a]
myConcat xss = [x | xs <- xss, x <- xs]

myReplicate :: Int -> a -> [a]
myReplicate n x = [x | _ <- [1..n]]

myIndex :: [a] -> Int -> a
myIndex xs n = head [x | (x, i) <- zip xs [0..], i == n]

-- 2.17
forte :: String -> Bool
forte senha = length senha >= 8
    && any isUpper senha
    && any isLower senha
    && any isDigit senha

-- 2.18
mindiv :: Int -> Int
mindiv n = findDivisor n 2
    where
        findDivisor n k
        |k * k > n = N
        | n `mod` k == 0 = k
        |otherwise  = findDivisor n (k+1)

-- 2.18.b
primoEficiente :: Int -> Bool
primoEficiente n = n  > 1 && mindiv n == n 

-- 2.19

myNub :: Eq a => [a] -> [a]
myNub [] = []
myNub (x:xs) = x : myNub [ y| y <- xs , y /= x]

-- 2.20
transpose :: [[a]] -> [[a]]
transpose [] = []
transpose ([]:_) = []
transpose xs = [head row | row <- xs ] : transpose [tail row | row <- xs]

-- 2.21
algarismosRev :: Int -> [Int]
algarismosRev 0 = []
algarismosRev n = (n `mod` 10) : algarismosRev (n `div` 10)

algarismos :: Int -> [Int]
algarismos n = reverse (algarismosRev n)

-- 2.22
toBitsRev :: Int -> [Int]
toBitsRev 0 = []
toBitsRev n = (n `mod` 2) : toBitsRev (n `div` 2)

toBits :: Int -> [Int]
toBits 0 = [0]
toBits n = reverse (toBitsRev n)

-- 2.23
fromBits :: [Int] -> Int
fromBits bits = sum [bit * 2^i | (bit, i) <- zip (reverse bits) [0..]]

-- 2.24
merge :: Ord a => [a] -> [a] -> [a]
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys) 
    |x <= y = x:merge xs (y:ys)
    |otherwise = y : merge (x:xs) ys

-- 2.24.b
metades :: [a] -> ([a], [a])
metades xs = splitAt (length xs `div` 2) xs
msort ::Ord a => [a] -> [a]
msort [] = []
msort [x] = [x]
msort xs = merge (msort esquerda)(msort direita)
    where
        (esquerda, direita) = metades xs






