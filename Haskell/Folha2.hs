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


-}

somaQuadrados :: Integer
somaQuadrados = sum [x^2 | x <- [1..100]]

-- Exemplo de uso:
main :: IO ()
main = do
  putStrLn ("A soma dos quadrados de 1 a 100 é: " ++ show somaQuadrados)

