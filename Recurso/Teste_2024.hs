type Match = ((String,String), (Int,Int))
type MatchDay = [Match]
type League = [MatchDay]
myLeague :: League
myLeague = [
 [(("Porto","Sporting"),(2,2)),(("Benfica","Vitoria SC"),(4,0))],
 [(("Porto","Benfica"),(5,0)),(("Vitoria SC","Sporting"),(3,2))],
 [(("Vitoria SC","Porto"),(1,2)),(("Sporting","Benfica"),(2,1))]
 ]

-- 1
-- returns the name of the match's winner
winner :: Match -> String
winner ((home, away),(hScore, aScore))
    | hScore > aScore = home
    | hScore < aScore = away
    |otherwise = "draw"

-- 2
--  given a team and a matchday, returns the score obtained by that team
-- on their match of that matchday
matchDayScore :: String -> MatchDay -> Int
matchDayScore _ [] = 0  -- Caso base: rodada vazia, retorna 0
matchDayScore team (((home, away), (hScore, aScore)) : matches)
    | team == home && hScore > aScore = 3  -- Vitória do time da casa
    | team == away && aScore > hScore = 3  -- Vitória do time visitante
    | team == home && hScore == aScore = 1  -- Empate para o time da casa
    | team == away && hScore == aScore = 1  -- Empate para o time visitante
    | team == home || team == away = 0  -- Derrota do time
    | otherwise = matchDayScore team matches  -- Time não participou dessa partida

-- 3
leagueScore :: String -> League -> Int
leagueScore t = foldr (\d acc -> matchDayScore t d + acc) 0

sortByCond :: Ord a => [a] -> (a -> a -> Bool) -> [a]
sortByCond [] _ = []
sortByCond [x] _ = [x]
sortByCond l cmp = merge (sortByCond l1 cmp) (sortByCond l2 cmp) cmp
  where (l1 ,l2) = splitAt (div (length l) 2) l

merge :: Ord a => [a] -> [a] -> (a -> a -> Bool) -> [a]
merge [] l _ = l
merge l [] _ = l
merge (x:xs) (y:ys) cmp
  | cmp x y = x:(merge xs (y:ys) cmp)
  | otherwise = y:(merge (x:xs) ys cmp)

-- 4
-- Calcula o ranking de uma liga
ranking:: League -> [(String,Int)]
ranking league =
  let teams = ["Porto", "Sporting", "Benfica", "Vitoria SC"]  -- Lista de times
      scores = map (\team -> (team, leagueScore team league)) teams  -- Calcula os scores
  in sortByCond scores (\(t1, s1) (t2, s2) -> s1 > s2 || (s1 == s2 && t1 < t2))  -- Ordena por score e nome

-- 4
-- returns the amount of matchdays in the league where at least one match ended in a draw.
numMatchDaysWithDraws :: League -> Int
numMatchDaysWithDraws league = length $ filter hasDraw league
  where
    hasDraw :: MatchDay -> Bool
    hasDraw matchDay = any isDraw matchDay


-- 5
-- returns a list of pairs (i,ws), where i is the index of the matchday (with indices 
-- starting at 1) and ws are the names of teams from that matchday that won their 
-- match with a goal difference of at least 3 goals. 
bigWins :: League -> [(Int,[String])]
bigWins league = [(i, [team | ((home, away), (hScore, aScore)) <- matchDay, 
                              (team == home && hScore - aScore >= 3) || 
                              (team == away && aScore - hScore >= 3)])
                  | (i, matchDay) <- zip [1..] league]

-- 6
-- returns a list of winning streaks, described by a triple (t,s,e), where:

-- t is the name of the team involved in the winning streak;
-- s and e are the indices of the streak's first and last matchday (with indices starting at 1).
winningStreaks :: League -> [(String,Int,Int)]
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
type Path = [City]
type Distance = Int

type RoadMap = [(City,City,Distance)]

gTest1 :: RoadMap
gTest1 = [("0","1",10),("0","2",15),("0","3",20),("1","2",35),("1","3",25),("2","3",30)]

gTest2 :: RoadMap -- unconnected graph
gTest2 = [("0","1",4),("2","3",2)]


-- 7
-- returns the cities adjacent to a particular city (i.e. cities with a direct edge between them) and the respective distances to them.
adjacent :: RoadMap -> City ->[(City,Distance)]
adjacent roadMap city = 
  [(c, d) | (c1, c2, d) <- roadMap, 
            (c1 == city && c2 /= city && (c, d) == (c2, d)) || 
            (c2 == city && c1 /= city && (c, d) == (c1, d))]


-- 8
-- determines if there is a path, composed of one or more roads, connecting both input cities of the input roadmap. Consider that a city is connected to itself.
areConnected :: RoadMap -> City -> City -> Bool
areConnected roadMap start target = bfs roadMap [start] [] target

-- Busca em largura (BFS)
bfs :: RoadMap -> [City] -> [City] -> City -> Bool
bfs _ [] _ _ = False  -- Fila vazia: não há conexão
bfs roadMap (current:queue) visited target
  | current == target = True  -- Encontrou a cidade alvo
  | current `elem` visited = bfs roadMap queue visited target  -- Já visitada
  | otherwise = bfs roadMap (queue ++ neighbors) (current : visited) target
  where
    neighbors = filter (`notElem` visited) (adjacent roadMap current)


-- 9
data KdTree = Empty | Node Char (Int,Int) KdTree KdTree deriving (Eq,Show)

tree1 :: KdTree
tree1 = Node 'x' (3,3) (Node 'y' (2,2) Empty Empty) (Node 'y' (4,4) Empty Empty)

tree2 :: KdTree
tree2 = Node 'x' (3,3) (Node 'y' (2,2) (Node 'x' (1,1) Empty Empty) Empty) (Node 'y' (4,4) (Node 'x' (3,2) Empty Empty) Empty)

-- 9
-- given a point p and a tree t, returns a new tree with the result of adding p to t. Point p should be added on the appropriate leaf node (Empty), according to the rules of the kd-tree stated before. If point p is already in the tree, then return t.
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
-- Função principal: imprime a árvore com os recuos apropriados
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