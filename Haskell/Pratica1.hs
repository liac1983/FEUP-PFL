-- 1.1
testaTriangulo :: Float-> Float-> Float-> Bool
 testaTriangulo a b c = (a < b + c) && (b < a + c) && (c < a + b)

-- 1.2
 {- areaTriangulo :: Float-> Float-> Float-> Float
 areaTriangulo a b c = sqrt (s * (s - a) * (s - b) * (s - c))
    where 
        s = (a+b+c)/2-}

-- 1.3
metades :: [a] -> ([a], [a])
metades xs = (take n xs, drop n xs)
    where
        n = div(length xs) 2

-- 1.4

last1 :: [a] -> a1
last1 xs  = head (drop (length xs - 1) xs)

-- 1.4.b

init1:: [a] -> [a]
init1 xs = reverse (tail (reverse xs))

inti2 :: [a] -> [a]
init2 xs = take (length xs - 1) xs

-- 1.5
{- binom :: Integer-> Integer-> Integer
 binom n k = product [1..n] `div`(product [1..n] * product [1..(n-k)]) -}


-- 1.5.b

binom :: Integer -> Integer -> Integer
binom n k = product [(n-k+1)..n]`div` product [1..k]


-- 1.6

 raizes :: Float-> Float-> Float-> (Float, Float)
 raizes a b c  =
    let delta = b^2 - 4 * a * c1
        x1 = (-b + sqrt delta) / (2 * a)
        x2 = (-b - sqrt delta) / (2 * a)
    in (x1, x2)

-- Usamos :t para descobrir os tipos 
-- 1.7.a) [Char]
-- 1.7.b) (Char, Char, Char)
-- 1.7.c) [(Bool, Char)]
-- 1.7.d) ([Bool], [Char])
-- 1.7.e) [[a] -> [a]]
-- 1.7.f) [Bool -> Bool]


-- 1.8.a) segundo :: [a] -> [a]
-- 1.8.b) trocar :: (b,a) -> (a,b)
-- 1.8.c) par :: a -> b -> (a,b)
-- 1.8.d) dobro :: Num a => a -> a
-- 1.8.e) metade :: Fractional a => a -> a
-- 1.8.f) minuscula :: Char -> Bool
-- 1.8.g) intervalo == Ord a=> a -> a -> a -> Bool
-- 1.8.h) palindromo :: Eq a => [a] -> Bool
-- 1.8.i) twice :: (t -> t) -> t -> t


-- 1.9
{- 
classifica :: Int-> String
classifica nota = 
    if nota <= 9 then "reprovado"
    else if nota <= 12 then "suficiente"
    else if nota <= 15 then "bom"
    else if nota <= 18 then "muito bom"
    else "muito bom com distinção"
-}

-- 1.10

classifica ::Float-> Float-> String
classifica peso altura
    |imc < 18.5 = "baixo peso"
    |imc < 25 = "peso normal"
    |imc < 30 = "excesso de peso"
    |otherwise = "obesidade"
where
    imc = peso /(altura ^ 2)

-- 1.11
{- max, min ::Ord a => a-> a-> a
 max x y= if x>=y then x else y
 min x y= if x<=y then x else y

 max3 :: Ord a => a -> a -> a -> a -> a
 max3 x y z = max x (max y z)

 min3 :: Ord a => a -> a -> a -> a
 min3 x y z = min x (min y z)
 
 -}


-- 1.11.b

max3 :: Ord a => a -> a -> a -> a
max3 x y z = max (max x y) z

min3 :: Ord a => a -> a -> a -> a
min3 x y z = min (min x y) z

-- 1.12
xor :: Bool-> Bool-> Bool
xor True False  = True
xor False True = True
xor True True = False
xor False False = False

-- 1.13

{-
safetail ::[a]-> [a]
safetail xs = if null xs then [] else tail xs

safetail :: [a] -> [a]
safetail xs
    |null xs = []
    | otherwise = tail xs
-}

-- 1.14 
{- 
curta :: [a]-> Bool
curta xs = length xs <= 2
-}

-- 1.14.b

curta :: [a] -> Bool
curta [] = True
curta [_] = True
curta [_, _] = True
curta _ = False

-- 1.15

{-
mediana :: Ord a => a -> a -> a-> a -> a
mediana x y z 
    |(x >= y && x <= z) || (x >= z && x <= y) = x
    | (y >= x && y <= z) || (y >= z && y <= x) = y
    | otherwise                               = z
-}

-- 1.15.b

mediana :: (Ord a, Num a ) => a -> a -> a -> a 
mediana x y z = (x+y+z) - max x (max y z) - min x (min y z)

-- 1.16

-- Função auxiliar para números de 0 a 19
unidades :: Int -> String
unidades n = case n of
    1  -> "um"
    2  -> "dois"
    3  -> "três"
    4  -> "quatro"
    5  -> "cinco"
    6  -> "seis"
    7  -> "sete"
    8  -> "oito"
    9  -> "nove"
    10 -> "dez"
    11 -> "onze"
    12 -> "doze"
    13 -> "treze"
    14 -> "catorze"
    15 -> "quinze"
    16 -> "dezasseis"
    17 -> "dezassete"
    18 -> "dezoito"
    19 -> "dezanove"
    _  -> ""

-- Função auxiliar para dezenas (20 a 99)
dezenas :: Int -> String
dezenas n = case div n 10 of
    2 -> if mod n 10 == 0 then "vinte" else "vinte e " ++ unidades (mod n 10)
    3 -> if mod n 10 == 0 then "trinta" else "trinta e " ++ unidades (mod n 10)
    4 -> if mod n 10 == 0 then "quarenta" else "quarenta e " ++ unidades (mod n 10)
    5 -> if mod n 10 == 0 then "cinquenta" else "cinquenta e " ++ unidades (mod n 10)
    6 -> if mod n 10 == 0 then "sessenta" else "sessenta e " ++ unidades (mod n 10)
    7 -> if mod n 10 == 0 then "setenta" else "setenta e " ++ unidades (mod n 10)
    8 -> if mod n 10 == 0 then "oitenta" else "oitenta e " ++ unidades (mod n 10)
    9 -> if mod n 10 == 0 then "noventa" else "noventa e " ++ unidades (mod n 10)
    _ -> unidades n  -- Para números menores que 20

-- Função auxiliar para centenas (100 a 999)
centenas :: Int -> String
centenas n
    | n == 100 = "cem"
    | n >= 101 && n < 200 = "cento e " ++ converte (n - 100)
    | n >= 200 && n < 300 = "duzentos e " ++ converte (n - 200)
    | n >= 300 && n < 400 = "trezentos e " ++ converte (n - 300)
    | n >= 400 && n < 500 = "quatrocentos e " ++ converte (n - 400)
    | n >= 500 && n < 600 = "quinhentos e " ++ converte (n - 500)
    | n >= 600 && n < 700 = "seiscentos e " ++ converte (n - 600)
    | n >= 700 && n < 800 = "setecentos e " ++ converte (n - 700)
    | n >= 800 && n < 900 = "oitocentos e " ++ converte (n - 800)
    | n >= 900 && n < 1000 = "novecentos e " ++ converte (n - 900)
    | otherwise = dezenas n

-- Função principal para converter números até 999.999
converte :: Int -> String
converte n
    | n < 20 = unidades n
    | n < 100 = dezenas n
    | n < 1000 = centenas n
    | n < 2000 = "mil" ++ if n `mod` 1000 /= 0 then " " ++ converte (n `mod` 1000) else ""
    | n < 1000000 = converte (n `div` 1000) ++ " mil" ++ if n `mod` 1000 /= 0 then " " ++ converte (n `mod` 1000) else ""
    | otherwise = "Número fora do intervalo suportado."



