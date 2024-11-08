type Species = (String, Int)

type Zoo = [Species]

-- 1
isEndangered :: Species -> Bool
isEndangered (name, count) = if(count <= 100) then True else False

-- 2
updateSpecies :: Species -> Int -> Species
updateSpecies (name, oldCount) newCount = (name, oldCount + newCount)

-- 3
-- filterSpecies :: Zoo -> (Species -> Bool) -> Zoo
-- filterSpecies [] _ = []
-- filterSpecies (animal:animals) function = if (function animal) then ([animal] ++ next) else next
--     where next = filterSpecies animals function

-- 4
countAnimals :: Zoo -> Int
countAnimals animals = sum (map(\(name, count) -> count) animals)

-- 5
substring :: (Integral a) => String -> a -> a -> String
substring xs start end = take (fromIntegral end + 1) (drop (fromIntegral start) xs)

-- 6
hasSubstr :: String -> String -> Bool
hasSubstr xs str = hasSubstrHelper xs str str

hasSubstrHelper :: String -> String -> String -> Bool
hasSubstrHelper _ [] _ = True
hasSubstrHelper [] _ _ = False
hasSubstrHelper (x:xs) (y:ys) str
    | x == y = hasSubstrHelper xs ys str
    |otherwise = hasSubstrHelper xs str str 

-- 7
getAnimalName :: Species -> String
getAnimalName (animal, _) = animal

animalHasSubstr :: Zoo -> String -> Zoo
animalHasSubstr animals str = [animal | animal <- animals, hasSubstr (getAnimalName animal) str]

notAnimalHasSubstr :: Zoo -> String -> Zoo
notAnimalHasSubstr animals str = [animal | animal <- animals, not (hasSubstr (getAnimalName animal) str)]

sortSpeciesWithSubstr :: Zoo -> String -> (Zoo, Zoo)
sortSpeciesWithSubstr animals str = (animalHasSubstr animals str, notAnimalHasSubstr animals str)

-- 8 
rabbits :: (Integral a) => [a]
rabbits = 2 : 3 : zipWith (+) rabbits (tail rabbits)

-- 9
rabbitYears :: (Integral a) => a -> Int
rabbitYears year = length ([y | y <- (take (fromIntegral year) rabbits), y < year])

-- 10 
data Dendrogram = Leaf String | Node Dendrogram Int Dendrogram

myDendro :: Dendrogram
myDendro = Node (Node (Leaf "dog") 3 (Leaf "cat")) 5 (Leaf "octopus")

-- Calcula a posição horizontal mais à esquerda e mais à direita
dendroBounds :: Dendrogram -> (Int, Int)
dendroBounds (Leaf _) = (0, 0)
dendroBounds (Node left dist right) =
    let (leftMin, leftMax) = dendroBounds left
        (rightMin, rightMax) = dendroBounds right
    in (leftMin - dist, rightMax + dist)

-- Calcula a largura total
dendroWidth :: Dendrogram -> Int
dendroWidth dendro =
    let (leftBound, rightBound) = dendroBounds dendro
    in rightBound - leftBound


-- 11
dendroInBounds :: Dendrogram -> Int -> [String]
dendroInBounds dendrogram maxDistance = inBoundsHelper dendrogram 0 maxDistance

inBoundsHelper :: Dendrogram -> Int -> Int -> [String]
inBoundsHelper (Leaf name) currentDistance maxDistance
    |abs currentDistance <= maxDistance = [name]
    | otherwise = []

inBoundsHelper (Node left dist right) currentDistance maxDistance = 
    inBoundsHelper left (currentDistance - dist) maxDistance ++
    inBoundsHelper right (currentDistance + dist) maxDistance


