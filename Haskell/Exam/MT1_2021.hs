maxpos :: [Int] -> Int
maxpos xs = case filter (> 0) xs of
               [] -> 0
               positives -> maximum positives

dups :: [a] -> [a]
dups [] = []
dups (x:xs) = x : case xs of
                    [] -> []
                    (y:ys) -> y : dups ys


transforma :: String -> String
transforma [] = []
transforma (x:xs)
  | elem x "aeiou" = x : 'p' : transforma xs
  | otherwise      = x : transforma xs

type Vector = [Int]
type Matriz = [[Int]]

transposta :: Matriz -> Matriz
transposta [] = []
transposta ([]:_) = []
transposta m = map head m : transposta (map tail m)

prodInterno :: Vector -> Vector -> Int
prodInterno [] [] = 0
prodInterno (x:xs) (y:ys) = x * y + prodInterno xs ys

prodMat :: Matriz -> Matriz -> Matriz
prodMat [] _ = []
prodMat _ [] = []
prodMat m1 m2 = [[sum (zipWith (*) row col) | col <- transposta m2] | row <- m1]

data Arv a = F | N a (Arv a) (Arv a)
    deriving(Show)

alturas :: Arv a -> Arv Int
alturas F = F
alturas (N _ left right) = N (1 + max (altura left) (altura right)) (alturas left) (alturas right)
  where
    altura F = 0
    altura (N _ left right) = 1 + max (altura left) (altura right)

equilibrada :: Arv a -> Bool
equilibrada F = True
equilibrada (N _ left right) = abs (altura left - altura right) <= 1 && equilibrada left && equilibrada right
  where
    altura F = 0
    altura (N _ left right) = 1 + max (altura left) (altura right)

f :: (a -> b -> c) -> b -> a -> c
f g x y = g y x