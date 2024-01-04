-- 1
maxpos :: [Int] -> Int
maxpos [] = 0
maxpos (x:xs)
 | x > next = x
 | otherwise = next
 where
 next = maxpos xs

-- maxpos [1,2,3,4,5] == 5
-- maxpos [-1,-2,-3,4,-5] == 4
-- maxpos [2] == 2
-- maxpos [] == 0

-- 2
dups :: [a] -> [a]
dups xs = dupsAux xs True
dupsAux :: [a] -> Bool -> [a]
dupsAux [] _ = []
dupsAux (x:xs) r
 | r = x : x : dupsAux xs False
 | otherwise = x : dupsAux xs True

-- dups "abcdef" == "aabccdeef"
-- dups [0,1,2,3,4] == [0,0,1,2,2,3,4,4]
-- dups [] == []

-- 3
transforma :: String -> String
transforma [] = []
transforma (x:xs)
 | x == 'a' || x == 'e' || x == 'i' || x == 'o' || x == 'u' = x : 'p' : x : transforma xs
 | otherwise = x : transforma xs

-- transforma "ola, mundo!" == "opolapa, mupundopo!"
-- transforma "4 gatos e 3 ratos" == "4 gapatopos epe 3 rapatopos"

type Vector = [Int]
type Matriz = [[Int]]

-- Nota: as matrizes são retangulares, ou seja, o comprimento de todas as sublistas é idêntico.

-- 4
transposta :: Matriz -> Matriz
transposta [] = []
transposta m = [head x | x <- m] : transposta [tail x | x <- m, tail x /= []]

-- transposta [[1,2], [3,4]] == [[1,3], [2,4]]
-- transposta [[1,2,3], [4,5,6]] == [[1,4], [2,5], [3,6]]

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

data Arv a = F | N a (Arv a) (Arv a)
    deriving(Show)

-- 7
alturas :: Arv a -> Arv Int
alturas F = F
alturas (N a a1 a2) = N (alturasAux (N a a1 a2)) (alturas a1) (alturas a2)
alturasAux :: Arv a -> Int
alturasAux F = 0
alturasAux (N a a1 a2) = 1 + max (alturasAux a1) (alturasAux a2)

-- 8
-- por indicação do professor (auxiliar utilizada nas alturas)

equilibrada :: Arv a -> Bool
equilibrada F = True
equilibrada (N a a1 a2) = equilibradaAux (alturas (N a a1 a2))

equilibradaAux :: Arv Int -> Bool
equilibradaAux F = True
equilibradaAux (N a F F) = True
equilibradaAux (N a F (N b b1 b2)) = b == 1
equilibradaAux (N a (N b b1 b2) F) = b == 1
equilibradaAux (N a (N b b1 b2) (N c c1 c2)) = b == c && equilibradaAux (N b b1 b2) && equilibradaAux (N c c1 c2)

-- 9
f :: (a -> b -> c) -> b -> a -> c
f fun b a = fun a b

-- 9 (test)

-- Definindo uma função para testar
funcaoExemplo :: Int -> String -> String
funcaoExemplo x y = show x ++ y

-- Testando a função f com a função de exemplo
resultado :: String
resultado = f funcaoExemplo "Hello, " 42

-- Exibindo o resultado
main :: IO ()
main = putStrLn resultado




