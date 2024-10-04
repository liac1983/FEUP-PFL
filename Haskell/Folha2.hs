import Data.Char (chr, ord, isLetter, isUpper)
import Data.Char (isLower, isDigit)
import Data.List (elemIndex)

{- 
insert :: Ord a => a -> [a] -> [a]
insert x [] = [x]   -- Caso base: inserir em uma lista vazia resulta em uma lista contendo apenas o elemento a ser inserido.
insert x (y:ys)
  | x <= y    = x : y : ys   -- Se o elemento a ser inserido é menor ou igual ao primeiro elemento da lista, insira-o no início.
  | otherwise = y : insert x ys   -- Caso contrário, mantenha o primeiro elemento e insira recursivamente o elemento na cauda da lista.

-- Exemplo de uso:
main :: IO ()
main = do
  let listaOrdenada = [0, 1, 3, 5]
  let listaInserida = insert 2 listaOrdenada
  print listaInserida


isort :: Ord a => [a] -> [a]
isort [] = []   -- Lista vazia já está ordenada
isort (x:xs) = insert x (isort xs)   -- Para ordenar uma lista não vazia, recursivamente ordenamos a cauda e inserimos a cabeça na posição correta

-- Exemplo de uso:
main :: IO ()
main = do
  let listaDesordenada = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
  let listaOrdenada = isort listaDesordenada
  print listaOrdenada



minimum' :: Ord a => [a] -> a
minimum' [x] = x   -- Caso base: lista com um elemento, o menor é esse elemento.
minimum' (x:xs) = min x (minimum' xs)   -- Caso recursivo: compara o elemento atual com o mínimo da cauda da lista.

-- Exemplo de uso:
main :: IO ()
main = do
  let listaValores = [5, 1, 2, 1, 3]
  let menorValor = minimum' listaValores
  print menorValor


delete' :: Eq a => a -> [a] -> [a]
delete' _ [] = []   -- Caso base: a lista vazia, não há nada para remover.
delete' y (x:xs)
  | y == x    = xs   -- Se o elemento atual é igual ao elemento a ser removido, simplesmente ignore-o.
  | otherwise = x : delete' y xs   -- Caso contrário, mantenha o elemento atual e remova recursivamente da cauda.

-- Exemplo de uso:
main :: IO ()
main = do
  let listaValores = [5, 1, 2, 1, 3]
  let listaSemUm = delete' 1 listaValores
  print listaSemUm


ssort :: Ord a => [a] -> [a]
ssort [] = []   -- Lista vazia já está ordenada
ssort xs = m : ssort (delete' m xs)
  where
    m = minimum' xs

-- Exemplo de uso:
main :: IO ()
main = do
  let listaDesordenada = [5, 1, 2, 1, 3]
  let listaOrdenada = ssort listaDesordenada
  print listaOrdenada




somaQuadrados :: Integer
somaQuadrados = sum [x^2 | x <- [1..100]]

-- Exemplo de uso:
main :: IO ()
main = do
  putStrLn ("A soma dos quadrados de 1 a 100 é: " ++ show somaQuadrados)



-- 2.2

intersperse' :: a -> [a] -> [a]
intersperse' _ [] = []
intersperse' sep (x:xs) = x : concatMap (\y -> [sep, y]) xs


-- 2.3

mdc :: Integer -> Integer -> Integer
mdc a 0 = a
mdc a b = mdc b (a `mod` b)


-- 2.5.a)

minimum' :: Ord a => [a] -> a
minimum' [x] = x
minimum' (x:xs) = min x (minimum' xs)


-- 2.5.b)

delete' :: Eq a => a -> [a] -> [a]
delete' _ [] = []
delete' y (x:xs)
  | x == y    = xs
  | otherwise = x : delete' y xs


-- 2.5.c)
ssort :: Ord a => [a] -> [a]
ssort [] = []  -- Lista vazia já está ordenada
ssort xs = m : ssort (delete' m xs)
  where
    m = minimum' xs

-- Definição da função minimum
minimum' :: Ord a => [a] -> a
minimum' [x] = x
minimum' (x:xs) = min x (minimum' xs)

-- Definição da função delete
delete' :: Eq a => a -> [a] -> [a]
delete' _ [] = []
delete' y (x:xs)
  | x == y    = xs
  | otherwise = x : delete' y xs



-- 2.6

somaQuadrados :: Integer
somaQuadrados = sum [x^2 | x <- [1..100]]
-}


-- LISTAS

-- 2.1
myand :: [Bool] -> Bool
myand [] = True                    -- Caso base: uma lista vazia é considerada True
myand (x:xs) = x && myand xs        -- Recursão: o primeiro elemento e o resultado da recursão sobre o resto da lista

-- 2.1.b)
myor :: [Bool] -> Bool
myor [] = False                  -- Caso base: uma lista vazia é considerada False
myor (x:xs) = x || myor xs        -- Recursão: o primeiro elemento ou o resultado da recursão sobre o resto da lista


-- 2.1.c
myconcat :: [[a]] -> [a]
myconcat [] = []                     -- Caso base: uma lista vazia de listas resulta em uma lista vazia
myconcat (x:xs) = x ++ myconcat xs    -- Recursão: concatena a primeira lista com a concatenação do restante das listas


-- 2.1.d)
myreplicate :: Int -> a -> [a]
myreplicate 0 _ = []                     -- Caso base: se n for 0, retorna uma lista vazia
myreplicate n x = x : myreplicate (n-1) x  -- Recursão: adiciona o elemento à lista e chama a função recursivamente com n-1


-- 2.1.e)
{-myIndex :: [a] -> Int -> a
myIndex (x:_) 0 = x                    -- Caso base: quando o índice é 0, retorna o primeiro elemento
myIndex (_:xs) n = myIndex xs (n-1)     -- Recursão: ignora o primeiro elemento e diminui n até chegar a 0
myIndex [] _ = error "Índice fora dos limites"  -- Caso especial: se a lista estiver vazia, lança um erro-}


-- 2.1.f)
myelem :: Eq a => a -> [a] -> Bool
myelem _ [] = False                    -- Caso base: se a lista for vazia, o elemento não está presente
myelem y (x:xs)
  | y == x    = True                   -- Se o elemento for encontrado, retorna True
  | otherwise = myelem y xs            -- Caso contrário, continua procurando no resto da lista



-- 2.2

myintersperse :: a -> [a] -> [a]
myintersperse _ [] = []                         -- Caso base: se a lista for vazia, retorna uma lista vazia
myintersperse _ [x] = [x]                       -- Caso base: se houver apenas um elemento, não precisa intercalar
myintersperse sep (x:xs) = x : sep : myintersperse sep xs  -- Recursão: intercala o separador entre os elementos

-- 2.3

mdc :: Integer -> Integer -> Integer
mdc a 0 = a                   -- Caso base: se o segundo número for 0, retorna o primeiro número
mdc a b = mdc b (a `mod` b)    -- Caso recursivo: aplica o algoritmo de Euclides

-- 2.4.a)

insert :: Ord a => a -> [a] -> [a]
insert x [] = [x]                      -- Caso base: se a lista for vazia, insere o elemento diretamente
insert x (y:ys)
  | x <= y    = x : y : ys             -- Se o elemento for menor ou igual ao primeiro da lista, insere antes
  | otherwise = y : insert x ys        -- Caso contrário, mantém o elemento atual e continua a inserção no resto da lista



-- 2.4.b)
isort :: Ord a => [a] -> [a]
isort [] = []                         -- Caso base: a lista vazia já está ordenada
isort (x:xs) = insert x (isort xs)    -- Recursão: ordena a cauda e insere a cabeça na posição correta


-- 2.5.a)
myMinimum :: Ord a => [a] -> a
myMinimum [x] = x                      -- Caso base: se a lista tem um único elemento, ele é o menor
myMinimum (x:xs) = min x (myMinimum xs) -- Recursão: compara o primeiro elemento com o menor da cauda


-- 2.5.b)
myDelete :: Eq a => a -> [a] -> [a]
myDelete _ [] = []                        -- Caso base: se a lista for vazia, retorna uma lista vazia
myDelete x (y:ys)
  | x == y    = ys                        -- Se o elemento for encontrado, remove-o e retorna o restante da lista
  | otherwise = y : myDelete x ys         -- Caso contrário, mantém o elemento atual e continua a busca


-- 2.5.c)
ssort :: Ord a => [a] -> [a]
ssort [] = []                          -- Caso base: a lista vazia já está ordenada
ssort xs = m : ssort (myDelete m xs)   -- Recursão: encontra o menor elemento e ordena o restante da lista
  where m = myMinimum xs               -- Encontra o menor elemento da lista


-- 2.6
somaQuadrados :: Integer
somaQuadrados = sum [x^2 | x <- [1..100]]


-- 2.7.a)
aprox :: Int -> Double
aprox n = 4 * sum [((-1) ^ k) / fromIntegral (2 * k + 1) | k <- [0..n-1]]


-- 2.7.b)
aprox' :: Int -> Double
aprox' n = sqrt (12 * sum [((-1) ^ k) / fromIntegral ((k + 1) ^ 2) | k <- [0..n-1]])


compareAprox :: IO ()
compareAprox = do
  putStrLn "Aproximações de pi com 10, 100 e 1000 termos:"
  putStrLn $ "Série 1 (n = 10): " ++ show (aprox 10) ++ ", Série 2 (n = 10): " ++ show (aprox' 10) ++ ", Prelude pi: " ++ show pi
  putStrLn $ "Série 1 (n = 100): " ++ show (aprox 100) ++ ", Série 2 (n = 100): " ++ show (aprox' 100) ++ ", Prelude pi: " ++ show pi
  putStrLn $ "Série 1 (n = 1000): " ++ show (aprox 1000) ++ ", Série 2 (n = 1000): " ++ show (aprox' 1000) ++ ", Prelude pi: " ++ show pi


-- 2.8

dotprod :: [Float] -> [Float] -> Float
dotprod xs ys = sum [x * y | (x, y) <- zip xs ys]


-- 2.9
divprop :: Integer -> [Integer]
divprop n = [x | x <- [1..n-1], n `mod` x == 0]


-- 2.10

-- Função para verificar se um número é perfeito
isPerfect :: Integer -> Bool
isPerfect n = sum (divprop n) == n

-- Função para calcular a lista de números perfeitos até um limite
perfeitos :: Integer -> [Integer]
perfeitos limit = [x | x <- [1..limit], isPerfect x]


-- 2.11
pitagoricos :: Integer -> [(Integer, Integer, Integer)]
pitagoricos n = [(x, y, z) | x <- [1..n], y <- [1..n], z <- [1..n], x^2 + y^2 == z^2]


-- 2.12

-- Função para testar se um número é primo
primo :: Integer -> Bool
primo n = divprop n == [1]  -- Um número é primo se os únicos divisores próprios forem 1

-- 2.13

-- Função para gerar a lista de primos de Mersenne para n <= 30
mersennes :: [Integer]
mersennes = [2^n - 1 | n <- [2..30], primo (2^n - 1)]

-- 2.14
-- Função que calcula o coeficiente binomial (n choose k)
binom :: Integer -> Integer -> Integer
binom n k = factorial n `div` (factorial k * factorial (n - k))

-- Função auxiliar para calcular o fatorial
factorial :: Integer -> Integer
factorial 0 = 1
factorial n = n * factorial (n - 1)


-- Função que gera o triângulo de Pascal até a linha n
pascal :: Integer -> [[Integer]]
pascal n = [[binom row k | k <- [0..row]] | row <- [0..n]]


-- 2.15
--import Data.Char (chr, ord, isLetter, isUpper)

-- Função para cifrar um único caractere com um deslocamento dado
{-cifrarChar :: Int -> Char -> Char
cifrarChar k c
  | isLetter c && isUpper c = chr (((ord c - ord 'A' + k) `mod` 26) + ord 'A')
  | otherwise               = c

-- Função para cifrar uma string inteira
cifrar :: Int -> String -> String
cifrar k = map (cifrarChar k)-}

alfabeto :: String
alfabeto = ['A'..'Z']

deslocarChar :: Int -> Char -> Char
deslocarChar k c
  | c `elem` alfabeto = alfabeto !! ((pos + k) `mod` 26)
  | otherwise         = c
  where pos = case elemIndex c alfabeto of
                Just n  -> n
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


-- Função que verifica se uma senha é forte
forte :: String -> Bool
forte senha = length senha >= 8              -- Deve ter pelo menos 8 caracteres
             && any isUpper senha            -- Deve ter pelo menos uma letra maiúscula
             && any isLower senha            -- Deve ter pelo menos uma letra minúscula
             && any isDigit senha            -- Deve ter pelo menos um algarismo


-- 2.18.a)
-- Função para calcular o menor divisor próprio de um número
mindiv :: Int -> Int
mindiv n = findDivisor n 2
  where
    -- Função auxiliar que encontra o divisor começando de 2 até sqrt(n)
    findDivisor n k
      | k * k > n      = n    -- Se k for maior que sqrt(n), o número é primo
      | n `mod` k == 0 = k    -- Se n for divisível por k, k é o menor divisor
      | otherwise      = findDivisor n (k + 1)  -- Tenta o próximo divisor

-- 2.18.b)

-- Função para testar se um número é primo usando mindiv
primoEficiente :: Int -> Bool
primoEficiente n = n > 1 && mindiv n == n

-- 2.19

-- Definição recursiva da função nub
myNub :: Eq a => [a] -> [a]
myNub [] = []  -- Caso base: lista vazia retorna lista vazia
myNub (x:xs) = x : myNub [y | y <- xs, y /= x]  -- Recursão com filtro para eliminar duplicatas


-- 2.20

-- Função transpose para calcular a transposta de uma matriz
transpose :: [[a]] -> [[a]]
transpose [] = []                                 -- Caso base: uma matriz vazia retorna uma matriz vazia
transpose ([]:_) = []                             -- Caso base: se a primeira linha estiver vazia, a transposição terminou
transpose xs = [head row | row <- xs] : transpose [tail row | row <- xs] 

-- 2.21
algarismosRev :: Int -> [Int]
algarismosRev 0 = []  -- Caso base: se o número for 0, retorna uma lista vazia
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

-- 2.24.a)
merge :: Ord a => [a] -> [a] -> [a]
merge [] ys = ys                           -- Se a primeira lista estiver vazia, retorna a segunda lista
merge xs [] = xs                           -- Se a segunda lista estiver vazia, retorna a primeira lista
merge (x:xs) (y:ys)
  | x <= y    = x : merge xs (y:ys)        -- Se o primeiro elemento da primeira lista for menor ou igual ao da segunda, inclui-o
  | otherwise = y : merge (x:xs) ys        -- Caso contrário, inclui o primeiro elemento da segunda lista


-- 2.24.b)
-- Função para partir uma lista em duas metades
metades :: [a] -> ([a], [a])
metades xs = splitAt (length xs `div` 2) xs


-- Função merge sort
msort :: Ord a => [a] -> [a]
msort [] = []                           -- Caso base: lista vazia já está ordenada
msort [x] = [x]                         -- Caso base: lista com um só elemento já está ordenada
msort xs = merge (msort esquerda) (msort direita)  -- Recursão: divide e ordena as duas metades
  where
    (esquerda, direita) = metades xs    -- Divide a lista em duas metades


