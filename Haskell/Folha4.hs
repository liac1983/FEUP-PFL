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

