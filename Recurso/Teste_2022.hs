-- 1
-- calcula o máximo dos inteiros positivos numa lista
maxpos :: [Int] -> Int
maxpos [] = 0 -- se a lista for vazia retorna 0
maxpos (x:xs)
    |x > next = x -- se x for maior que next, o maximo é x
    |otherwise = next -- se não passa para o proximo elemento da lista
    where   
        next = maxpos xs -- chamada recursiva para fazer o mesmo com os outros elementos na lista

-- 2
-- duplica os valores em posições alternadas duma lista
dups :: [a] -> [a]
dups xs = dupsAux xs True -- chama a função auxiliar

dupsAux :: [a] -> Bool -> [a]
dupsAux []_ = [] -- se a lista estiver vazia retorna a lista vazia
dupsAux (x:xs) r
    | r = x : x : dupsAux xs False -- adiciona o elemento x duas vezes na lista resultante
    | otherwise = x : dupsAux xs True -- recursão para fazer o mesmo aos outros elemntos da lista 

-- 3
--  A linguagem dos Ps é um jogo de palavras em que duplicamos cada 
-- vogal (letras 'a', 'e', 'i', 'o', 'u') e colocamos um 'p' entre elas
--  transforma uma frase para a linguagem dos Ps
transforma :: String -> String
transforma [] = [] -- se a lista for vazia continua vazia
transforma (x:xs)
    -- verifica se o caracter é uma vogal e se for fica vogal + p + vogal
    |x == 'a' || x == 'e' || x == 'i' || x == 'o' || x == 'u' = x : 'p' : x : transforma xs
    | otherwise = x : transforma xs -- chamada recursiva para fazer o mesmo no resto da string


type Vector = [Int] 
type Matriz = [[Int]] 

-- 4
-- calcula a matriz transposta
transposta :: Matriz -> Matriz
transposta [] = [] -- se for vazia continua vazia
transposta m = [head x | x <- m] : transposta [tail x | x <- m, tail x /= []]
-- cria uma linha com o primeiro elemento de cada linha da matriz m
-- chamada recursiva para fazer o mesmo com os outros elementos das linhas 

-- 5
-- calcula o produto interno de dois vectores
prodInterno :: Vector -> Vector -> Int
prodInterno [] [] = 0 -- se os vetores forem vazios o produto dá zero
prodInterno x1 x2 = head x1 * head x2 + prodInterno (tail x1)(tail x2) 
-- multiplicamos as heads e depois fazemos o mesmo para o resto dos elementos do vetor

-- 6
-- calcula o produto de duas matrizes
prodMat :: Matriz -> Matriz -> Matriz
prodMat m1 m2 = prodMatAux m1 (transposta m2)
-- O produto de matrizes é definido como a soma dos produtos dos elementos
-- correspondentes das linhas de uma matriz pelas colunas da outra.

prodMatAux :: Matriz -> Matriz -> Matriz 
prodMatAux [] [] = [] -- se forem vazias dá uma matriz vazia
prodMatAux m1 m2 = [[prodInterno v1 v2 | v2 <- m2] | v1 <- m1]
-- calcula o produto interno de v1 com cada linha v2 da matriz m2

data Arv a = F | N a (Arv a) (Arv a) 
    deriving(Show) 


-- 7
-- transforma uma árvore binária noutra com a mesma estrutura mas em
-- que o valor de cada nó é dado pela sua altura
alturas :: Arv a -> Arv Int
alturas F = F -- se a arvore for vazia ela retorna ela propria
alturas (N a a1 a2) = N(alturasAux(N a a1 a2))(alturas a1)(alturas a2) 
-- atualiza o valor da subarvore da esquerda e da direita com a altura

-- calcula a artura das arvores
alturasAux :: Arv a -> Int
alturasAux F = 0 -- se a arvore for vazia retorna 0
alturasAux (N a a1 a2) = 1 + max(alturasAux a1)(alturasAux a2)
-- O valor da altura é 1 + o maximo da altura da subarvore da esquerda e da direita

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





