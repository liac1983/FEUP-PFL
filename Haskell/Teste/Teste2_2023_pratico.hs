type Species = (String, Int)
type Zoo = [Species]


-- 1
isEndangered :: Species -> Bool
isEndangered (name, count) = if (count <= 100) then True else False

-- 2
updateSpecies :: Species -> Int -> Species
updateSpecies (name, oldCount) newCount = (name, newCount + oldCount)

-- 3
-- Recursion
filterSpecies :: Zoo -> (Species -> Bool) -> Zoo
filterSpecies [] _ = []
filterSpecies (animal:animals) function = if(function animal) then ([animal] ++ next) else next
    where next = filterSpecies animals function

-- 4
-- higher-order functions
countAnimals :: Zoo -> Int
countAnimals animals = sum(map(\(name, count) -> count) animals)

-- 5
-- list comprehension
substring :: (Integral a) => String -> a -> a -> String
substring xs start end = take (fromIntegral end + 1) (drop (fromIntegral start) xs)

-- 6
hasSubstr :: String -> String -> Bool
hasSubstr xs str = hasSubstrHelper xs str str

hasSubstrHelper :: String -> String -> String -> Bool
hasSubstrHelper _ [] _ = True



