-- 4.1

{-data Arv a = Vazia | No a (Arv a) (Arv a)

sumArv :: Num a => Arv a -> a
sumArv Vazia = 0
sumArv (No valor esq dir) = valor + sumArv esq + sumArv dir


-- Exemplo de árvore binária
arvoreExemplo :: Arv Int
arvoreExemplo =
  No 5
    (No 3 (No 1 Vazia Vazia) (No 4 Vazia Vazia))
    (No 7 (No 6 Vazia Vazia) (No 9 Vazia Vazia))

-- Teste da função
resultado :: Int
resultado = sumArv arvoreExemplo

main :: IO ()
main = print resultado

-- 4.2

data Arv a = Vazia | No a (Arv a) (Arv a)

listar :: Arv a -> [a]
listar Vazia = []
listar (No valor esq dir) = listar esq ++ [valor] ++ listar dir

listarDecrescente :: Ord a => Arv a -> [a]
listarDecrescente Vazia = []
listarDecrescente (No valor esq dir) = listarDecrescente dir ++ [valor] ++ listarDecrescente esq


-- Exemplo de árvore binária
arvoreExemplo :: Arv Int
arvoreExemplo =
  No 5
    (No 3 (No 1 Vazia Vazia) (No 4 Vazia Vazia))
    (No 7 (No 6 Vazia Vazia) (No 9 Vazia Vazia))

-- Teste da função
resultadoDecrescente :: [Int]
resultadoDecrescente = listarDecrescente arvoreExemplo

main :: IO ()
main = print resultadoDecrescente-}

-- 4.5
{-
data Arv a = Vazia | No a (Arv a) (Arv a)

instance Show a => Show (Arv a) where
  show Vazia = "Vazia"
  show (No valor esq dir) = "No " ++ show valor ++ " (" ++ show esq ++ ") (" ++ show dir ++ ")"

mapArv :: (a -> b) -> Arv a -> Arv b
mapArv _ Vazia = Vazia
mapArv f (No valor esq dir) = No (f valor) (mapArv f esq) (mapArv f dir)


-- Exemplo de árvore binária
arvoreExemplo :: Arv Int
arvoreExemplo =
  No 5
    (No 3 (No 1 Vazia Vazia) (No 4 Vazia Vazia))
    (No 7 (No 6 Vazia Vazia) (No 9 Vazia Vazia))

-- Função exemplo para mapear os valores para strings
converteString :: Int -> String
converteString x = show x

-- Teste da função
arvoreMapeada :: Arv String
arvoreMapeada = mapArv converteString arvoreExemplo

main :: IO ()
main = print arvoreMapeada

-- 4.3

data Arv a = No a (Arv a) (Arv a) | Vazia deriving Show

nivel :: Int -> Arv a -> [a]
nivel n arv = nivelAux n arv 0

nivelAux :: Int -> Arv a -> Int -> [a]
nivelAux _ Vazia _ = []
nivelAux n (No valor esq dir) altura
  | altura == n = [valor]
  | otherwise = nivelAux n esq (altura + 1) ++ nivelAux n dir (altura + 1)

-- Exemplo de uso:
arvoreExemplo :: Arv Int
arvoreExemplo =
  No 1
    (No 2 (No 4 Vazia Vazia) (No 5 Vazia Vazia))
    (No 3 (No 6 Vazia Vazia) (No 7 Vazia Vazia))



-- 4.4

data Arv a = No a (Arv a) (Arv a) | Vazia deriving Show

alturaArvoreBinaria :: [a] -> Int
alturaArvoreBinaria elementos = alturaArvore (construirArvoreBinaria elementos)

alturaArvore :: Arv a -> Int
alturaArvore Vazia = 0
alturaArvore (No _ esq dir) = 1 + max (alturaArvore esq) (alturaArvore dir)

construirArvoreBinaria :: [a] -> Arv a
construirArvoreBinaria [] = Vazia
construirArvoreBinaria elementos =
  let meio = length elementos `div` 2
      (esq, raiz:dir) = splitAt meio elementos
  in No raiz (construirArvoreBinaria esq) (construirArvoreBinaria dir)


main :: IO ()
main = do
  let valores = [1..10]
  putStrLn $ "Altura da árvore binária: " ++ show (alturaArvoreBinaria valores)



-- 4.4.b)

data Arv a = No a (Arv a) (Arv a) | Vazia deriving Show

inserir :: Ord a => a -> Arv a -> Arv a
inserir x Vazia = No x Vazia Vazia
inserir x (No valor esq dir)
  | x < valor  = No valor (inserir x esq) dir
  | otherwise  = No valor esq (inserir x dir)

alturaArvoreInsercao :: Ord a => [a] -> Int
alturaArvoreInsercao elementos = alturaArvore (foldr inserir Vazia elementos)

alturaArvore :: Arv a -> Int
alturaArvore Vazia = 0
alturaArvore (No _ esq dir) = 1 + max (alturaArvore esq) (alturaArvore dir)

main :: IO ()
main = do
  let valores10 = [1..10]
      valores100 = [1..100]
      valores1000 = [1..1000]

  putStrLn $ "Altura da árvore (n=10): " ++ show (alturaArvoreInsercao valores10)
  putStrLn $ "Altura da árvore (n=100): " ++ show (alturaArvoreInsercao valores100)
  putStrLn $ "Altura da árvore (n=1000): " ++ show (alturaArvoreInsercao valores1000)

  putStrLn "Altura teórica (log2 n):"
  putStrLn $ "n=10: " ++ show (ceiling (logBase 2 10 :: Double))
  putStrLn $ "n=100: " ++ show (ceiling (logBase 2 100 :: Double))
  putStrLn $ "n=1000: " ++ show (ceiling (logBase 2 1000 :: Double))


-- 4.6.a)
data Arv a = No a (Arv a) (Arv a) | Vazia deriving Show

mais_esq :: Arv a -> a
mais_esq (No valor Vazia _) = valor
mais_esq (No _ esq _) = mais_esq esq
mais_esq Vazia = error "Árvore vazia"

mais_dir :: Arv a -> a
mais_dir (No valor _ Vazia) = valor
mais_dir (No _ _ dir) = mais_dir dir
mais_dir Vazia = error "Árvore vazia"

main :: IO ()
main = do
  let arvoreExemplo = No 5 (No 3 (No 2 Vazia Vazia) (No 4 Vazia Vazia)) (No 7 (No 6 Vazia Vazia) (No 8 Vazia Vazia))

  putStrLn $ "Árvore de exemplo: " ++ show arvoreExemplo

  putStrLn $ "Valor mais à esquerda: " ++ show (mais_esq arvoreExemplo)
  putStrLn $ "Valor mais à direita: " ++ show (mais_dir arvoreExemplo)



-- 4.6.b)

data Arv a = No a (Arv a) (Arv a) | Vazia deriving Show

mais_dir :: Arv a -> a
mais_dir (No valor _ Vazia) = valor
mais_dir (No _ _ dir) = mais_dir dir
mais_dir Vazia = error "Árvore vazia"

remover :: (Ord a) => a -> Arv a -> Arv a
remover _ Vazia = Vazia
remover valor (No atual esq dir)
  | valor < atual = No atual (remover valor esq) dir
  | valor > atual = No atual esq (remover valor dir)
  | otherwise = case esq of
      Vazia -> dir
      _ -> No (mais_dir esq) (remover (mais_dir esq) esq) dir

main :: IO ()
main = do
  let arvoreExemplo = No 5 (No 3 (No 2 Vazia Vazia) (No 4 Vazia Vazia)) (No 7 (No 6 Vazia Vazia) (No 8 Vazia Vazia))

  putStrLn $ "Árvore de exemplo: " ++ show arvoreExemplo

  let valorARemover = 3
  let novaArvore = remover valorARemover arvoreExemplo

  putStrLn $ "Remover " ++ show valorARemover ++ ": " ++ show novaArvore
-}

main :: IO ()
main = do
    putStrLn "Digite algumas linhas de texto (Ctrl-D para encerrar):"
    input <- getContents
    let linhasInvertidas = map reverse (lines input)
    mapM_ putStrLn linhasInvertidas
