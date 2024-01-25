type Species = (String, Int)
type Zoo = [Species]


isEndangered :: Species -> Bool
isEndangered (name,count) = if (count <= 100) then True else False

-- Exemplos
species1 :: Species
species1 = ("Tiger", 80)

species2 :: Species
species2 = ("Elephant", 120)

updateSpecies :: Species -> Int -> Species
updateSpecies(name,oldCount) newCount = (name, oldCount+newCount)


filterSpecies :: Zoo -> (Species -> Bool) -> Zoo
filterSpecies []_ = []
filterSpecies (animal:animals) function = if(function animal) then ([animal]++next) else next
    where next = filterSpecies animals function

isLargeSpecies :: Species -> Bool
isLargeSpecies (_, count) = count > 100

countAnimals :: Zoo -> Int
countAnimals animals = sum(map(\(name,count)->count)animals)

substring :: (Integral a) => String -> a -> a -> String
substring xs start end = take (fromIntegral end+1)(drop(fromIntegral start) xs)

hasSubstr :: String -> String -> Bool
hasSubstr xs str = hasSubstrHelper xs str str

hasSubstrHelper :: String -> String -> String -> Bool
hasSubstrHelper _ [] _ = True

{-getAnimalName :: Species -> String
getAnimalName (animal, count) = animal

sortSpeciesWithSubstr :: Zoo -> String -> (Zoo, Zoo)
sortSpeciesWithSubstr animals str = (animalHasSubstr animals str, notAnimalHasSubstr animals str)-}


rabbits :: (Integral a) => [a]
rabbits = rabbitHelper [2,3]

rabbitHelper :: (Integral a) => [a] -> [a]
rabbitHelper (xs) = rabbitHelper (xs ++ [(xs !!(length(xs)-1)) + (xs!! (length(xs)-2))])

rabbitYears::(Integral a) => a -> Int
rabbitYears = length([y|y<-(take(fromIntegral year) rabbits), y<year])
