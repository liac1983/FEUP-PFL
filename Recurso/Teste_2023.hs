type Species = (String, Int)

type Zoo = [Species]

-- 1
-- receives a species and determines if it is endangered.
isEndangered :: Species -> Bool
isEndangered(name, count)=if(count <= 100) then True else False

-- 2
-- given a Species and an amount of newborn babies, returns a new instance of
-- Species with the updated population
updateSpecies :: Species -> Int -> Species
updateSpecies(name, oldCount) newCount=(name, newCount)

-- 3
-- given the list species of a zoo and a predicate (i.e. a function that performs
-- a test on each species), returns the sublist of species that satisfy the predicate. 
filterSpecies :: Zoo -> (Species -> Bool) -> Zoo
filterSpecies [] _ = [] -- Se a lista estiver vazia retorna uma lista vazia
filterSpecies (animal:animals) function = 
    if(function animal)  -- verifica se o animal atual satisfaz o predicado fornecido
    then ([animal] ++ next) -- se sim, adiciona o animal à sublista
    else next -- caso contrario não adiciona o animal
    where next = filterSpecies animals function 
    -- usa recursão para processar o restante da lista e contruir a sublista 

-- 4
-- given the list of species of a zoo, counts the total population of the zoo
countAnimals :: Zoo -> Int
countAnimals animals = sum(map(\(name, count)->count)animals)

-- 5
-- which returns the substring of a given string between an initial and final index
substring :: (Integral a) => String -> a -> a -> String
substring xs start end = take (fromIntegral end + 1)(drop (fromIntegral start) xs)

-- 6
-- determines if the first string argument contains the second string argument
{- hasSubstr :: String -> String -> Bool
hasSubstr xs str = hasSubstrHelper xs str str

hasSubstrHelper :: String -> String -> String -> Bool
hasSubstrHelper _ [] _ = True -}

-- Verifica se uma string é uma substring de outra
hasSubstr :: String -> String -> Bool
hasSubstr xs str = hasSubstrHelper xs str str

hasSubstrHelper :: String -> String -> String -> Bool
hasSubstrHelper [] [] _ = True  -- Ambas as strings estão vazias, substring encontrada
hasSubstrHelper [] _ _ = False  -- A string principal esgotou antes de encontrar a substring
hasSubstrHelper (x:xs) [] _ = True  -- Substring encontrada, mesmo que xs tenha sobrado
hasSubstrHelper (x:xs) (y:ys) fullStr
    | x == y = hasSubstrHelper xs ys fullStr  -- Continua verificando o próximo caractere
    | otherwise = hasSubstrHelper xs fullStr fullStr  -- Reinicia a busca com a string original


-- 7
-- divides the species of the Zoo into a pair of sublists. The first sublist
-- stores all the species whose name contains the string argument, while the
-- second list has the remaining species.
getAnimalName :: Species -> String
getAnimalName (animal, count) = animal

-- Retorna a lista de espécies cujos nomes antém a substring fornecida
animalHasSubstr :: Zoo -> String -> Zoo
animalHasSubstr [] _ = []
animalHasSubstr (animal:animals) str
    | hasSubstr (getAnimalName animal) str = animal : animalHasSubstr animals str
    | otherwise = animalHasSubstr animals str

-- Retorna a lista de espécies cujos nomes Não contém a substring fornecida 
notAnimalHasSubstr :: Zoo -> String -> Zoo
notAnimalHasSubstr [] _ = []
notAnimalHasSubstr (animal:animals) str
    |not (hasSubstr(getAnimalName animal) str) = animal : notAnimalHasSubstr animals str
    | otherwise = notAnimalHasSubstr animals str

-- Divide as espécies em duas sublistas com base na presença da substring
sortSpeciesWithSubstr :: Zoo -> String -> (Zoo, Zoo)
sortSpeciesWithSubstr animals str = 
    (animalHasSubstr animals str, notAnimalHasSubstr animals str)

-- 8
-- returns an infinite list with the rabbit population of each year (starting at year 0)
rabbits :: (Integral a) => [a]
rabbits = 2 : 3 : zipWith (+) rabbits (tail rabbits)

-- 9
-- returns the number of years needed for the rabbit population to be greater or equal
-- to the input integral value
rabbitYears :: (Integral a) => a -> Int
rabbitYears year = length ([y|y <- (take(fromIntegral year) rabbits), y < year])

-- 10
data Dendrogram = Leaf String 
                | Node Dendrogram Int Dendrogram
                deriving (Show)
 
myDendro :: Dendrogram
myDendro = Node (Node (Leaf "dog") 3 (Leaf "cat")) 5 (Leaf "octopus")

-- returns the width of a dendrogram
dendroWidth :: Dendrogram -> Int
dendroWidth (Leaf _) = 0
dendroWidth (Node left x right) = dendroWidth left + x + dendroWidth right + x


-- 11
dendroInBounds :: Dendrogram -> Int -> [String]
dendroInBounds (Leaf str) limit
    | limit >= 0 = [str] -- se o limite permitir adiciona a folha à lista
    | otherwise = [] -- caso contrario ignora a folha
dendroInBounds (Node left dist right) limit
    |limit < 0 = [] -- Se o limite já fro negativo, não há folhas válidas 
    |otherwise = dendroInBounds left (limit - dist) ++ dendroInBounds right (limit - dist)
    -- Subtrai a distância acumulada do limite e verifica as subárvores 
    