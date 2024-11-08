-- 1
maxpos :: [Int] -> Int
maxpos [] = 0
maxpos (x:xs)
    |x > next = x 
    |otherwise = next
    where 
        next = maxpos xs

-- 2
dups :: [a] -> [a]
dups xs = dupsAux xs True

dupsAux :: [a] -> Bool -> [a]
dupsAux [] _ = []
dupsAux (x:xs) r 
    |r = x:x:dupsAux xs False
    |otherwise = x:dupsAux xs True

-- 3
transforma :: String -> String 
transforma [] = []
transforma (x:xs)
    |x == 'a' || x == 'e' || x == 'i' || x == 'o' || x == 'u' = x:'p':x:transforma xs
    |otherwise = x:transforma xs

-- 4
type Vector = [Int]
type Matriz = [[Int]]

transposta :: Matriz -> Matriz
transposta [] = []
transposta m = [head x | x <- m] : transposta [tail x | x <- m, tail x /= []]

-- 5
prodInterno :: Vector -> Vector -> Int
prodInterno [] [] = 0
prodInterno x1 x2 = head x1 * head x2 + prodInterno (tail x1) (tail x2)

-- 6
prodMat :: Matriz -> Matriz -> Matriz
prodMat m1 m2 = prodMatAux m1 (transposta m2)

prodMatAux :: Matriz -> Matriz -> Matriz 
prodMatAux [] [] = []
prodMatAux m1 m2 = [[prodInterno v1 v2 | v2 <- m2] | v1 <- m1]

-- 7
data Arv a = F | N a (Arv a) (Arv a)
    deriving(Show)


alturas :: Arv a -> Arv Int
alturas F = F 
alturas (N a a1 a2) = N (alturasAux (N a a1 a2)) (alturas a1) (alturas a2)

alturasAux :: Arv a -> Int
alturasAux F = 0
alturasAux (N a a1 a2) = 1 + max(alturasAux a1)(alturasAux a2)

-- 8
equilibrada :: Arv a -> Bool 
equilibrada F = True
equilibrada (N a a1 a2) = equilibradaAux (alturas(N a a1 a2))

equilibradaAux :: Arv Int -> Bool
equilibradaAux F = True
equilibradaAux (N a F F) = True
equilibradaAux (N a F(N b b1 b2)) = b == 1
equilibradaAux (N a (N b b1 b2)F) = b == 1
equilibradaAux (N a (N b b1 b2)(N c c1 c2)) = b == c && equilibradaAux (N b b1 b2) && equilibradaAux (N c c1 c2)



