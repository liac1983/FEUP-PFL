-- 1
-- calcula o máximo dos inteiros positivos numa lista
maxpos :: [Int] -> Int
maxpos [] = 0
maxpos (x:xs)
    |x > next = x
    |otherwise = next
    where   
        next = maxpos xs

-- 2
-- duplica os valores em posições alternadas duma lista
dups :: [a] -> [a]
dups xs = dupsAux xs True

dupsAux :: [a] -> Bool -> [a]
dupsAux []_ = []
dupsAux (x:xs) r
    | r = x : x : dupsAux xs False
    | otherwise = x : dupsAux xs True

-- 3
--  A linguagem dos Ps é um jogo de palavras em que duplicamos cada 
-- vogal (letras 'a', 'e', 'i', 'o', 'u') e colocamos um 'p' entre elas
--  transforma uma frase para a linguagem dos Ps
transforma :: String -> String
transforma [] = []
transforma (x:xs)
    |x == 'a' || x == 'e' || x == 'i' || x == 'o' || x == 'u' = x : 'p' : x : transforma xs
    | otherwise = x : transforma xs


type Vector = [Int] 
type Matriz = [[Int]] 

-- 4
-- calcula a matriz transposta
transposta :: Matriz -> Matriz
transposta [] = []
transposta m = [head x | x <- m] : transposta [tail x | x <- m, tail x /= []]

-- 5
-- calcula o produto interno de dois vectores
prodInterno :: Vector -> Vector -> Int
prodInterno [] [] = 0
prodInterno x1 x2 = head x1 * head x2 + prodInterno (tail x1)(tail x2)

-- 6
-- calcula o produto de duas matrizes
prodMat :: Matriz -> Matriz -> Matriz
prodMat m1 m2 = prodMatAux m1 (transposta m2)

prodMatAux :: Matriz -> Matriz -> Matriz 
prodMatAux [] [] = []
prodMatAux m1 m2 = [[prodInterno v1 v2 | v2 <- m2] | v1 <- m1]

data Arv a = F | N a (Arv a) (Arv a) 
    deriving(Show) 


-- 7
-- transforma uma árvore binária noutra com a mesma estrutura mas em
-- que o valor de cada nó é dado pela sua altura
alturas :: Arv a -> Arv Int
alturas F = F 
alturas (N a a1 a2) = N(alturasAux(N a a1 a2))(alturas a1)(alturas a2)

alturasAux :: Arv a -> Int
alturasAux F = 0
alturasAux (N a a1 a2) = 1 + max(alturasAux a1)(alturasAux a2)

-- 8
-- tem um erro não dá para compilar 
-- as alturas das sub árvores de cada nó diferem no máximo de 1 unidade
{- alturasAux :: Arv a -> Int
alturasAux F = 0
alturasAux (N a a1 a2) = 1 + max (alturasAux a1) (alturasAux a2)

equilibrada :: Arv a -> Bool
equilibrada F = True
equilibrada (N a a1 a2) = equilibradaAux (alturas (N a a1 a2))

equilibradaAux :: Arv Int -> Bool
equilibradaAux F = True
equilibradaAux (N a F F) = True
equilibradaAux (N a F (N b b1 b2)) = b == 1
equilibradaAux (N a (N b b1 b2) F) = b == 1
equilibradaAux (N a (N b b1 b2) (N c c1 c2)) =
  b == c && equilibradaAux (N b b1 b2) && equilibradaAux (N c c1 c2) -}





