{- module Main where

-- Definindo o tipo de dado para representar a pilha
type Stack = [Char]

-- Função para verificar se os parêntesis estão corretamente emparelhados
parent :: String -> Bool
parent str = checkParentheses str []

-- Função auxiliar para verificar se os parêntesis estão corretamente emparelhados
checkParentheses :: String -> Stack -> Bool
checkParentheses [] [] = True
checkParentheses [] _  = False
checkParentheses (x:xs) stack
    | isOpeningParenthesis x = checkParentheses xs (x:stack)
    | isClosingParenthesis x = case stack of
        []       -> False
        (y:ys)   -> if isMatchingPair y x
                        then checkParentheses xs ys
                        else False
    | otherwise = checkParentheses xs stack

-- Função para verificar se um caractere é um parêntese de abertura
isOpeningParenthesis :: Char -> Bool
isOpeningParenthesis c = c == '(' || c == '['

-- Função para verificar se um caractere é um parêntese de fechamento
isClosingParenthesis :: Char -> Bool
isClosingParenthesis c = c == ')' || c == ']'

-- Função para verificar se um par de parênteses forma um par válido
isMatchingPair :: Char -> Char -> Bool
isMatchingPair '(' ')' = True
isMatchingPair '[' ']' = True
isMatchingPair _   _   = False

main :: IO ()
main = do
    putStrLn $ show $ parent "(((()[()])))"  -- Deve imprimir True
    putStrLn $ show $ parent "((]())"         -- Deve imprimir False

module Main where

-- Definindo o tipo de dado para representar a pilha
type Stack a = [a]

-- Função para calcular o valor de uma expressão em RPN
calculateRPN :: String -> Float
calculateRPN expression = head (foldl calc [] (words expression))

-- Função auxiliar para realizar operações na pilha
calc :: Stack Float -> String -> Stack Float
calc stack token
    | token `elem` ["+", "*", "-", "/"] = applyOperator token stack
    | otherwise = (read token :: Float) : stack

-- Função para aplicar operadores à pilha
applyOperator :: String -> Stack Float -> Stack Float
applyOperator "+" (x:y:ys) = (y + x):ys
applyOperator "*" (x:y:ys) = (y * x):ys
applyOperator "-" (x:y:ys) = (y - x):ys
applyOperator "/" (x:y:ys) = (y / x):ys
applyOperator _ stack = stack  -- Tratamento para outros casos

main :: IO ()
main = do
    putStrLn $ show $ calculateRPN "42 3 * 1 +"  -- Deve imprimir 127.0
    putStrLn $ show $ calculateRPN "10 2 / 3 +"  -- Deve imprimir 8.0


module Main where

-- Definindo o tipo de dado para representar a pilha
type Stack a = [a]

-- Função para calcular o valor de uma expressão em RPN
calculateRPN :: String -> Float
calculateRPN expression = head (foldl calc [] (words expression))

-- Função auxiliar para realizar operações na pilha
calc :: Stack Float -> String -> Stack Float
calc stack token
    | token `elem` ["+", "*", "-", "/"] = applyOperator token stack
    | otherwise = (read token :: Float) : stack

-- Função para aplicar operadores à pilha
applyOperator :: String -> Stack Float -> Stack Float
applyOperator "+" (x:y:ys) = (y + x):ys
applyOperator "*" (x:y:ys) = (y * x):ys
applyOperator "-" (x:y:ys) = (y - x):ys
applyOperator "/" (x:y:ys) = (y / x):ys
applyOperator _ stack = stack  -- Tratamento para outros casos

-- Função principal para calcular o valor de uma expressão em RPN
calcular :: String -> Float
calcular = calculateRPN

main :: IO ()
main = do
    putStrLn $ show $ calcular "42 3 * 1 +"  -- Deve imprimir 127.0
    putStrLn $ show $ calcular "10 2 / 3 +"  -- Deve imprimir 8.0


module Main where

-- Definindo o tipo de dado para representar a pilha
type Stack a = [a]

-- Função para calcular o valor de uma expressão em RPN
calculateRPN :: String -> Float
calculateRPN expression = head (foldl calc [] (words expression))

-- Função auxiliar para realizar operações na pilha
calc :: Stack Float -> String -> Stack Float
calc stack token
    | token `elem` ["+", "*", "-", "/"] = applyOperator token stack
    | otherwise = (read token :: Float) : stack

-- Função para aplicar operadores à pilha
applyOperator :: String -> Stack Float -> Stack Float
applyOperator "+" (x:y:ys) = (y + x):ys
applyOperator "*" (x:y:ys) = (y * x):ys
applyOperator "-" (x:y:ys) = (y - x):ys
applyOperator "/" (x:y:ys) = (y / x):ys
applyOperator _ stack = stack  -- Tratamento para outros casos

-- Função principal para calcular o valor de uma expressão em RPN
calcular :: String -> Float
calcular = calculateRPN

main :: IO ()
main = do
    putStrLn "Digite uma expressão em RPN:"
    input <- getLine
    let resultado = calcular input
    putStrLn $ "Resultado: " ++ show resultado



module Conjunto where

-- Definindo o tipo abstrato de dados para conjuntos
newtype Conjunto a = Conjunto { elementos :: [a] } deriving (Show, Eq)

-- Função para criar um conjunto vazio
conjuntoVazio :: Conjunto a
conjuntoVazio = Conjunto []

-- Função para adicionar um elemento ao conjunto
adicionarElemento :: Eq a => a -> Conjunto a -> Conjunto a
adicionarElemento x (Conjunto xs)
  | x `elem` xs = Conjunto xs  -- Se o elemento já existe, não faz nada
  | otherwise = Conjunto (x:xs)

-- Função para verificar se um elemento pertence ao conjunto
pertence :: Eq a => a -> Conjunto a -> Bool
pertence x (Conjunto xs) = x `elem` xs

-- Função para unir dois conjuntos
unirConjuntos :: Eq a => Conjunto a -> Conjunto a -> Conjunto a
unirConjuntos (Conjunto xs) (Conjunto ys) = Conjunto (xs ++ [y | y <- ys, not (y `elem` xs)])

-- Exemplos de uso
exemploConjunto1 :: Conjunto Int
exemploConjunto1 = adicionarElemento 1 (adicionarElemento 2 (adicionarElemento 3 conjuntoVazio))

exemploConjunto2 :: Conjunto Int
exemploConjunto2 = adicionarElemento 3 (adicionarElemento 4 (adicionarElemento 5 conjuntoVazio))

exemploUniao :: Conjunto Int
exemploUniao = unirConjuntos exemploConjunto1 exemploConjunto2
-}

-- 5.4
data Set a = EmptySet | Node a (Set a) (Set a) deriving (Show, Eq, Ord)

-- Constrói um conjunto vazio
empty :: Set a
empty = EmptySet

-- Insere um elemento no conjunto
insert :: Ord a => a -> Set a -> Set a
insert x EmptySet = Node x EmptySet EmptySet
insert x (Node y left right)
  | x == y = Node y left right  -- O elemento já está no conjunto
  | x < y  = Node y (insert x left) right
  | x > y  = Node y left (insert x right)

-- Verifica se um elemento pertence ao conjunto
member :: Ord a => a -> Set a -> Bool
member _ EmptySet = False
member x (Node y left right)
  | x == y = True
  | x < y  = member x left
  | x > y  = member x right

-- Criando um conjunto
set :: Set Integer
set = insert 1 (insert 2 (insert 3 empty))

