-- 5.1
import data.Char (isSpace, chr, ord, isLower, isUpper)
import Data.Char (toLower)
import Data.List (intersperse)

main::IO()
main = do   
    let input = "a maria tinha um cordeirinho"
    let numLines = length (lines input )
    let numWords = length (myWords input)
    let numBytes = length input
    putStrLn

myWords :: String -> [String]
myWords = filter (not . all isSpace) . Prelude.words

-- 5.2
main :: IO()
main = do
    input <- getContents
    let reversedLines = unlines (map reverse (lines input))
    putStr reversedLines

-- 5.3
main :: IO()
main = do 
    input <- getContents
    putStr (map rot13 input)

rot13 :: Char -> Char
rot13 c 
    |isLower c = chr ((((ord c - ord 'a') + 13) `mod` 26) + ord 'a')
    |isUpper c = chr ((((ord c - ord 'A') + 13) `mod` 26) + ord 'A')
    |otherwise = c 


-- 5.4

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


-- 5.5
elefantes :: Int -> IO()
elefantes n = sequence_ (map verso [2..n])

verso :: Int -> IO()
verso i = do
    putStrLn ("Se " ++ show (i-1) ++ " elefantes incomodam muita gente, ")
    putStrLn (show i ++ " elefantes incomodam muito mais!")

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



 



