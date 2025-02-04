type Match = ((String, String), (Int, Int))
type MatchDay = [Match]
type League = [MatchDay]

myLeague :: League
myLeague =
  [ [ (("Porto", "Sporting"), (2, 2))
    , (("Benfica", "Vitoria SC"), (4, 0))
    ]
  , [ (("Porto", "Benfica"), (5, 0))
    , (("Vitoria SC", "Sporting"), (3, 2))
    ]
  , [ (("Vitoria SC", "Porto"), (1, 2))
    , (("Sporting", "Benfica"), (2, 1))
    ]
  ]

-- 1
-- Retorna o nome do vencedor de uma partida ou "draw" em caso de empate
winner :: Match -> String
winner ((home, away), (hScore, aScore))
    | hScore > aScore = home -- Vitória do time da casa
    | hScore < aScore = away -- Vitória do time visitante
    | otherwise = "draw" -- Empate

-- 2
-- Retorna a pontuação de um time em um dia específico da liga
matchDayScore :: String -> MatchDay -> Int
matchDayScore _ [] = 0 -- Caso base: sem partidas no dia
matchDayScore team (((home, away), (hScore, aScore)) : matches)
    | team == home && hScore > aScore = 3 -- Vitória do time da casa
    | team == away && aScore > hScore = 3 -- Vitória do time visitante
    | team == home && hScore == aScore = 1 -- Empate para o time da casa
    | team == away && aScore == hScore = 1 -- Empate para o time visitante
    | otherwise = matchDayScore team matches -- Continua para a próxima partida

-- 3
-- Calcula o total de pontos de um time na liga
leagueScore :: String -> League -> Int
leagueScore t = foldr (\d acc -> matchDayScore t d + acc) 0

-- Ordena uma lista com base em uma condição fornecida
sortByCond :: Ord a => [a] -> (a -> a -> Bool) -> [a]
sortByCond [] _ = []
sortByCond [x] _ = [x]
sortByCond l cmp = merge (sortByCond l1 cmp) (sortByCond l2 cmp) cmp
  where
    (l1, l2) = splitAt (div (length l) 2) l

-- Mescla duas listas ordenadas em uma única lista
merge :: Ord a => [a] -> [a] -> (a -> a -> Bool) -> [a]
merge [] l _ = l
merge l [] _ = l
merge (x:xs) (y:ys) cmp
    | cmp x y = x : merge xs (y:ys) cmp
    | otherwise = y : merge (x:xs) ys cmp

-- Calcula o ranking de uma liga
ranking :: League -> [(String, Int)]
ranking league =
    let teams = ["Porto", "Sporting", "Benfica", "Vitoria SC"] -- Lista de times na liga
        scores = map (\team -> (team, leagueScore team league)) teams -- Calcula os pontos para cada time
    in sortByCond scores (\(t1, s1) (t2, s2) -> s1 > s2 || (s1 == s2 && t1 < t2)) -- Ordena por pontuação e nome

-- 4
-- Retorna o número de matchdays na liga em que pelo menos uma equipe empatou
numMatchDaysWithDraws :: League -> Int
numMatchDaysWithDraws league = length $ filter hasDraw league
    where
        -- Função auxiliar para verificar se uma rodada contém um empate
        hasDraw :: MatchDay -> Bool
        hasDraw matchDay = any (\((_, _), (hScore, aScore)) -> hScore == aScore) matchDay

-- 5
-- Retorna uma lista de pares (i, ws) onde i é o índice do matchday e ws são os nomes das equipes que venceram com uma diferença de pelo menos 3 gols
bigWins :: League -> [(Int, [String])]
bigWins league = 
  [ (i, [home | ((home, away), (hScore, aScore)) <- matchDay, hScore - aScore >= 3] ++
         [away | ((home, away), (hScore, aScore)) <- matchDay, aScore - hScore >= 3])
  | (i, matchDay) <- zip [1..] league]

-- Nova função: Retorna a lista de vencedores de um MatchDay
matchDayWinners :: MatchDay -> [String]
matchDayWinners [] = []
matchDayWinners (((home, away), (hScore, aScore)) : rest)
    | hScore > aScore = home : matchDayWinners rest
    | aScore > hScore = away : matchDayWinners rest
    | otherwise = matchDayWinners rest

-- 6
-- Retorna uma lista com os winning streaks, descrita como um triplo (t,s,e)
winningStreaks :: League -> [(String, Int, Int)]
winningStreaks league = findStreaks (zip [1..] (map matchDayWinners league))

-- Auxiliar para encontrar as sequências de vitórias
findStreaks :: [(Int, [String])] -> [(String, Int, Int)]
findStreaks [] = []
findStreaks ((i, winners):rest) = processWinners i winners [] rest

-- Processa os vencedores e rastreia sequências
processWinners :: Int -> [String] -> [(String, Int)] -> [(Int, [String])] -> [(String, Int, Int)]
processWinners _ [] streaks [] = finalizeStreaks streaks
processWinners _ [] streaks ((i, winners):rest) = processWinners i winners streaks rest
processWinners i (w:ws) streaks rest =
  let updatedStreaks = updateStreak w i streaks
  in processWinners i ws updatedStreaks rest

-- Atualiza as sequências para cada time
updateStreak :: String -> Int -> [(String, Int)] -> [(String, Int)]
updateStreak team i [] = [(team, i)]
updateStreak team i ((t, s):rest)
  | team == t = (team, s) : rest  -- Continua a sequência
  | otherwise = (t, s) : updateStreak team i rest

-- Finaliza as sequências de vitórias
finalizeStreaks :: [(String, Int)] -> [(String, Int, Int)]
finalizeStreaks [] = []
finalizeStreaks ((team, s):rest) = (team, s, s) : finalizeStreaks rest

-- 7
type City = String
type Path = [City]
type Distance = Int
type RoadMap = [(City,City,Distance)]
gTest1 :: RoadMap
gTest1 = [("0","1",10),("0","2",15),("0","3",20),("1","2",35),("1","3",25),("2","3",30)]
gTest2 :: RoadMap -- unconnected graph
gTest2 = [("0","1",4),("2","3",2)]

-- 7
-- Retorna as cidades adjacentes a uma cidade específica e as respectivas distâncias
adjacent :: RoadMap -> City -> [(City, Distance)]
adjacent roadMap city = 
    -- Itera por cada estrada no mapa rodoviário
    [(c2, d) | (c1, c2, d) <- roadMap, c1 == city] ++ -- Se a cidade é `c1`, inclui `(c2, d)`
    [(c1, d) | (c1, c2, d) <- roadMap, c2 == city]    -- Se a cidade é `c2`, inclui `(c1, d)`

-- 8
-- Determina se existe um caminho entre duas cidades
areConnected :: RoadMap -> City -> City -> Bool
areConnected roadMap start target = bfs roadMap [start] [] target

-- Busca em largura (BFS)
bfs :: RoadMap -> [City] -> [City] -> City -> Bool
bfs _ [] _ _ = False -- Fila vazia: não há conexão
bfs roadMap (current:queue) visited target
    | current == target = True -- Encontrou a cidade alvo
    | current `elem` visited = bfs roadMap queue visited target -- Já visitada
    | otherwise = bfs roadMap (queue ++ neighbors) (current : visited) target
    where   
        -- Extrai apenas as cidades vizinhas (ignorando as distâncias)
        neighbors = [c | (c, _) <- adjacent roadMap current, c `notElem` visited]

-- 9
data KdTree = Empty | Node Char (Int,Int) KdTree KdTree deriving (Eq,Show)

tree1 :: KdTree
tree1 = Node 'x' (3,3) (Node 'y' (2,2) Empty Empty) (Node 'y' (4,4) Empty Empty)

tree2 :: KdTree
tree2 = Node 'x' (3,3) (Node 'y' (2,2) (Node 'x' (1,1) Empty Empty) Empty) (Node 'y' (4,4) (Node 'x' (3,2) Empty Empty) Empty)

-- dados dois pontos a e b e uma arvore t, retorna uma nova arvore com o resultado de adicionar p a t.
-- O ponto p deve ser adicionado à folha apropriada da arvore (vazia)
-- de acordo com as regras do Kd-tree stated before. 
-- Se o ponto p já existir na arvore retorna t
insert :: (Int,Int) -> KdTree -> KdTree
insert point Empty = Node 'x' point Empty Empty  -- A raiz sempre começa como nó X
insert point (Node axis (x, y) left right)
  | point == (x, y) = Node axis (x, y) left right  -- Se o ponto já existe, retorna a árvore
  | axis == 'x' =
      if fst point < x
      then Node axis (x, y) (insert point left) right  -- Inserção no lado esquerdo
      else Node axis (x, y) left (insert point right)  -- Inserção no lado direito
  | axis == 'y' =
      if snd point < y
      then Node axis (x, y) (insert point left) right  -- Inserção no lado esquerdo
      else Node axis (x, y) left (insert point right)  -- Inserção no lado direito
  | otherwise = error "Invalid axis"

-- 10 
-- Função principal : Imprime a árvore com os recursos apropriados 
putTreeStr :: KdTree -> IO ()
putTreeStr tree = putTreeHelper tree 0

-- Função auxiliar para gerenciar recuos e impressão
putTreeHelper :: KdTree -> Int -> IO ()
putTreeHelper Empty _ = return ()  -- Árvore vazia: não imprime nada
putTreeHelper (Node axis (x, y) left right) depth = do
  -- Prefixo de espaços para recuo
  let indent = replicate (2 * depth) ' '
  
  -- Imprime o nó atual
  putStrLn $ indent ++ "(" ++ show x ++ "," ++ show y ++ ")"
  
  -- Condição para os nós filhos à esquerda
  putStrLn $ indent ++ if axis == 'x'
    then "y<" ++ show y
    else "x<" ++ show x
  putTreeHelper left (depth + 1)
  -- Condição para os nós filhos à direita
  putStrLn $ indent ++ if axis == 'x'
    then "y>=" ++ show y
    else "x>=" ++ show x
  putTreeHelper right (depth + 1)


