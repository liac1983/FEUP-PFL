-- 3.2

dec2int :: [Int] -> Int
dec2int = foldl (\acc x -> acc * 10 + x) 0

-- 3.3

myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith _ [] _ = []
myZipWith _ _ [] = []
myZipWith f (x:xs) (y:ys) = f x y : myZipWith f xs ys


-- 3.1
-- Original usando lista em compreensão
original :: (a -> b) -> (a -> Bool) -> [a] -> [b]
original f p xs = [f x | x <- xs, p x]

-- Usando map e filter
reescrito :: (a -> b) -> (a -> Bool) -> [a] -> [b]
reescrito f p xs = map f (filter p xs)

