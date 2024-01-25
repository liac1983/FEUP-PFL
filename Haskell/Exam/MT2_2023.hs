import Text.Read (readMaybe)
type Book = (String,[String],String)

myBooks :: [Book]
myBooks =
  [
  ("the da vinci code",["Dan Brown"],"a mystery thriller set after a murder in french soil"),
  ("the lost prologue",["Danilo Silverio","Dan Brown"],"a novel about how a wonderful language came to be"),
  ("war and peace",["Lev Tolstoy"],"a war story on the french invasion of russia")
  ]


containsWord :: Book -> String -> Bool
containsWord (title,_,desc) str = (elem str (words title)) || (elem str (words desc))

testBooks :: [Book] -> String -> String -> Bool
testBooks books a_str b_str = and [containsWord b b_str | b <- books, containsWord b a_str]


myIntersperse :: a -> [a] -> [a]
myIntersperse _ [] = []
myIntersperse _ [x] = [x]
myIntersperse v (x:xs) = x:v:(myIntersperse v xs)

executiveSummaries :: [Book] -> Int -> [Book]
executiveSummaries books n = map (\(title,people,desc) -> (title,people,concat $ myIntersperse " " $ take n $ words desc)) books

longestBook :: [Book] -> String -> Maybe Book
longestBook cases person = longestBookAux cases Nothing 0 person

longestBookAux :: [Book] -> Maybe Book -> Int -> String -> Maybe Book
longestBookAux [] acc _ _ = acc
longestBookAux (book@(_,people,desc):bs) longest_book longest_length name
  | elem name people && new_length >= longest_length = longestBookAux bs (Just book) new_length name
  | otherwise = longestBookAux bs longest_book longest_length name
  where new_length = length desc



data Aexp = IntegerVar String | IntegerConst Integer deriving Show
data Bexp = BooleanVar String | BooleanConst Bool deriving Show
data Stm = IntegerAssignment String Aexp | BooleanAssignment String Bexp deriving Show
type Program = [Stm]

parseAexp :: String -> Aexp
parseAexp value =
  case (readMaybe value)::Maybe Integer of Just number -> IntegerConst number
                                           Nothing -> IntegerVar value


parseBexp :: String -> Bexp
parseBexp value =
  case (readMaybe value)::Maybe Bool of Just boolean -> BooleanConst boolean
                                        Nothing -> BooleanVar value


parse :: String -> Program
parse str = parseAux (words str)

parseAux :: [String] -> Program
parseAux [] = []
parseAux ("int":name:":=":val:";":ts) = (IntegerAssignment name $ parseAexp val):(parseAux ts)
parseAux ("bool":name:":=":val:";":ts) = (BooleanAssignment name $ parseBexp val):(parseAux ts)


data Inst =
  Push Integer | Add | Mult | Sub | Tru | Fals | Equ | Le | And | Neg | Fetch String | Store String | Noop |
  Branch Code Code | Loop Code Code
  deriving Show
type Code = [Inst]


compile :: Program -> Code
compile [] = []
compile ((IntegerAssignment name val):stms) = compA val ++ [Store name] ++ compile stms
compile ((BooleanAssignment name val):stms) = compB val ++ [Store name] ++ compile stms

compA :: Aexp -> Code
compA (IntegerVar name) = [Fetch name]
compA (IntegerConst v) = [Push v]

compB :: Bexp -> Code
compB (BooleanVar name) = [Fetch name]
compB (BooleanConst True) = [Tru]
compB (BooleanConst False) = [Fals]

squareMatrix :: Int -> [[Int]]
squareMatrix n = squareMatrixAux 1 n

squareMatrixAux :: Int -> Int -> [[Int]]
squareMatrixAux i n
  | i <= n*n = [i .. (i + n - 1)]:(squareMatrixAux (i + n) n)
  | otherwise = []

aToB :: Int -> Int -> (Int -> Bool) -> [Int]
aToB a b pred = drop (a - 1) $ take b $ filter pred [1 ..]


saddlePoints :: [[Int]] -> [(Int, Int)]
saddlePoints matrix = [(i, j) | i <- [0..dim-1], j <- [0..dim-1], isSaddlePoint matrix i j]
  where
    dim = length matrix

isSaddlePoint :: [[Int]] -> Int -> Int -> Bool
isSaddlePoint matrix i j =
  element == maximumInColumn && element == minimumInRow
  where
    element = matrix !! i !! j
    maximumInColumn = maximum [matrix !! row !! j | row <- [0..dim-1]]
    minimumInRow = minimum (matrix !! i)
    dim = length matrix



