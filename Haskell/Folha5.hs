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
-}


-- 5.1
{- import Data.Char (isSpace)

-- Função principal que lê da entrada padrão e imprime o resultado
main :: IO ()
main = do
    let input = "a maria tinha um cordeirinho"
    -- input <- getContents    -- Lê a entrada padrão completa
    let numLines = length (lines input)      -- Conta o número de linhas
    let numWords = length (myWords input)    -- Conta o número de palavras (usa função personalizada)
    let numBytes = length input              -- Conta o número de bytes (caracteres)
    putStrLn $ show numLines ++ " " ++ show numWords ++ " " ++ show numBytes

-- Função personalizada para contar palavras (para evitar conflito com Prelude.words)
myWords :: String -> [String]
myWords = filter (not . all isSpace) . Prelude.words -}

-- 5.2
{- 
main :: IO()
main = do 
    input <- getContents
    let reversedLines = unlines (map reverse (lines input))
    putStr reversedLines -}

-- 5.3

{- import Data.Char (chr, ord, isLower, isUpper)

main :: IO()
main = do   
    input <- getContents
    putStr (map rot13 input)

rot13 :: Char -> Char
rot13 c
    | isLower c = chr ((((ord c - ord 'a') + 13) `mod` 26) + ord 'a')
    | isUpper c = chr ((((ord c - ord 'A') + 13) `mod` 26) + ord 'A')
    | otherwise = c -}

-- 5.4
{- import Data.Char (toLower)
import Data.List (intersperse)


main :: IO()
main = do  
    l1 <- getLine
    adivinha l1

adivinha :: String -> IO()
adivinha secretWord = do    
    putStrLn "Bem-vindo ao jogo de adivinhação!"
    jogo secretWord [] 0

jogo :: String -> [Char] -> Int -> IO ()
jogo secretWord guesses attempts = do   
    let currentState = revelarPalavra secretWord guesses
    putStrLn currentState
    if currentState == secretWord
        then putStrLn $ "Parabéns! Você adivinhou a palavra em " ++ show attempts ++ " tentativas."
        else do 
            putStrLn "Adivinhe uma letra: "
            guess <- getLine
            let letra = toLower (head guess)
            if letra `elem` guesses
                then do 
                    putStrLn "Você já adivinhou essa letra. Tente outra."
                    jogo secretWord guesses attempts
                else jogo secretWord (letra:guesses) (attempts + 1)

revelarPalavra :: String -> [Char] -> String
revelarPalavra word guesses = map (\c -> if toLower c `elem` guesses then c else '_') word
 -}

-- 5.5

{- elefantes :: Int -> IO()
elefantes n = sequence_ (map verso [2..n])

verso :: Int -> IO()
verso i = do
    putStrLn ("Se " ++ show (i-1) ++ " elefantes incomodam muita gente,")
    putStrLn (show i ++ " elefantes incomodam muito mais!")
 -}

 -- 5.6

main :: IO ()
main = nim [5,4,3,2,1] 1

nim :: [Int] -> Int -> IO ()
nim estado jogador = do 
    putStrLn "\nEstado atual do tabuleiro:"
    imprimirTabuleiro estado 1
    if sum estado == 0
        then putStrLn $ "Jogador " ++ show (if jogador == 1 then 2 else 1) ++ " venceu!"
        else do
            putStrLn $ "\nJogador " ++ show jogador ++ ", é a sua vez."
            putStrLn "Escolha a linha (1-5): "
            linha <- getLine
            putStrLn "Quantas estrelas você quer remover?"
            estrelas <- getLine
            let linhaNum = read linha :: Int
            let estrelasNum = read estrelas :: Int
            if validaJogada estado linhaNum estrelasNum
                then do 
                    let novoEstado = atualizarEstado estado linhaNum estrelasNum
                    nim novoEstado (if jogador == 1 then 2 else 1)
                else do 
                    putStrLn "Jogada inválida! Tente novamente."
                    nim estado jogador 

validaJogada :: [Int] -> Int -> Int -> Bool
validaJogada estado linha estrelas =
    linha >= 1 && linha <= 5 && estrelas > 0 && estrelas <= (estado !! (linha - 1))

atualizarEstado :: [Int] -> Int -> Int -> [Int]
atualizarEstado estado linha estrelas =
    take (linha - 1) estado  ++ [estado !! (linha - 1) - estrelas] ++ drop linha estado

imprimirTabuleiro :: [Int] -> Int -> IO ()
imprimirTabuleiro [] _ = return ()
imprimirTabuleiro (x:xs) linha = do
    putStrLn $ show linha ++ " : " ++ replicate x '*'
    imprimirTabuleiro xs (linha + 1)



 

