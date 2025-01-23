type Species = (String, Int)
type Zoo = [Species]

-- 1
-- Verifica se as especies estão em vias de extinção 
isEndangered :: Species -> Bool
isEndangered(name, count) = if (count <= 100) then True else False

-- Exemplos
species1 :: Species
species1 = ("Tiger", 80)

species2 :: Species
species2 = ("Elephant", 120)

-- 2
-- adiciona à base de dados mais individuos de uma determinada especie 
updateSpecies :: Species -> Int -> Species 
updateSpecies(name, oldCount) newCount = (name, newCount + oldCount)

-- 3
-- dada uma lista de especies do zoo e um predicado retorna a lista que respeita o predicadoo 
filterSpecies :: Zoo -> (Species -> Bool) -> Zoo
filterSpecies []_ = []
filterSpecies(animal:animals) function = if (function animal) then ([animal]++ next) else next
    where next = filterSpecies animals function

isLargeSpecies :: Species -> Bool
isLargeSpecies (_, count ) = count > 100

-- 4
-- dada uma lista de especies, conta a população total do zoo
countAnimals :: Zoo -> Int
countAnimals animals = sum(map(\(name, count)->count)animals)

-- 5
-- retorna uma substring da string entre o indice inicial e final 
substring :: (Integral a) => String -> a -> a -> String
substring xs strat end = take (fromIntegral end + 1) (drop(fromIntegral start) xs)

-- 6
-- determina se a primeira string contém a segunda string 
hasSubstr :: String -> String -> Bool
hasSubstr xs str = hasSusbstrHelper xs str str

hasSubstrHelper::String -> String -> String -> Bool
hasSubstrHelper _[]_ = True

-- 8 
-- retorna uma lista infiita com a rabbit population de ano
rabbits::(Integral a) => a
rabbits = 0 : 1: zipWith (+) rabbits (tail rabbits)

-- 9
-- retorna o numero de anos necessários para o numero de rabbits ser maior ou igual ao input
rabbitsYears:: (Integral a) => a -> Int
rabbitYear = length ([y|y <- (take(fromIntegral year)rabbits), y < year])

data Dendrogram = Leaf String | Node Dendrogram Int Dendrogram

myDendro :: Dendrogram
myDendro = Node (Node (Leaf "dog") 3 (Leaf "cat")) 5 (Leaf "octopus")

-- 10
-- retorna  a largura do demograma 
dendroWidth :: Dendrogram -> Int
dendroWIdth (Leaf str) = 0
dendroWidth (Node left x right) = x* 2 + div(max(dendroWidth left) (dendroWith right)) 2


-- 11
-- Retorna uma lista de strings cujos nos são maiores que uma determinada distancia
dendroInBounds :: Dendrogram -> Int -> [String]
dendroInBounds _ 1 = []
dendroInBounds (Leaf str) _ = [str]
dendroInBounds (Node left x right) limit = (dendroInBounds left (limit-1)) ++ (dendroInBounds right (limit-1)) 

main :: IO ()
main = do
  let zoo = [("Lion", 3), ("Giraffe", 5), ("Monkey", 10), ("Penguin", 8)]

  putStrLn "Zoo animals:"
  mapM_ print zoo

  let totalAnimals = countAnimals zoo

  putStrLn $ "\nTotal number of animals in the zoo: " ++ show totalAnimals

  let filteredZoo = filterSpecies zoo isLargeSpecies

  putStrLn "\nFiltered zoo (large species):"
  mapM_ print filteredZoo

  let str1 = "hello world"
      substr1 = "lo"
      substr2 = "abc"

  putStrLn $ "Does \"" ++ str1 ++ "\" contain \"" ++ substr1 ++ "\"? " ++ show (hasSubstr str1 substr1)
  putStrLn $ "Does \"" ++ str1 ++ "\" contain \"" ++ substr2 ++ "\"? " ++ show (hasSubstr str1 substr2)

    -- Mostrar os primeiros 10 anos da população de coelhos
  putStrLn $ "Rabbit population for the first 10 years: " ++ show (take 10 rabbits)

