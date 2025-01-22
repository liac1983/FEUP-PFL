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
-- Retorna o nome do match winner em caso de empate 
-- no numero de golos imprime o nome das duas equipas
winner :: Match -> String
    | homeGoals > awayGoals = homeTeam -- Se a equipa da casa tiver mais golos ganha
    | awayGoals > homeGoals = awayTeam -- Se a equipa convidada tem mais pontos ganha
    | otherwise = "draw" -- Imprime draw em caso de empate 


-- 2
-- Dada uma equipa e um matchday retorna os pontos obtidos por cada equipa 
-- 3 em caso de galo, 1 em caso de empate e 0 perda 
matchDayScore :: String -> MatchDay -> Int
matchDayScore team matchDay = case findMatch team matchDay of
    Just ((homeTeam, awayTeam), (homeGoals, awayGoals))
    | team == homeTeam && homeGoals > awayGoals -> 3 -- Home win
    | team == awayTeam && awayGoals > homeGoals -> 3 -- Away win
    | (tem == homeTeam || team == awayTeam) && homeGoals == awayGoals -> 1 -- Draw
    | otherwise -> 0 -- Loss
    Nothing -> 0 -- Team not found in the matchday

findMatch :: String -> MatchDay -> Maybe Match
findMatch team = find (\((homeTeam, awayTeam), _) -> team == homeTeam || team == awayTeam)

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

-- 3

--Calculate the score of a team in a single match
matchScore :: String -> Match -> Int
matchScore team ((homeTeam, awayTeam), (homeGoals, awayGoals))
    | team = homeTeam && homeGoals > awayGoals = 3 -- Home win
    | team = awayTeam && awayGoals > homeGoals = 3 -- Away win
    | (team == homeTeam || team == awayTeam) && homeGoals == awayGoals = 1 -- Draw
    | otherwise = 0 -- Loss or not involved in the match

-- Calculate the total score of a team in a matchday
matchDayScore :: String -> MatchDay -> Int
matchDayScore team = sum . map (matchScore team)

-- Extract all unique teams from the league
allTeams :: League -> [String]
allTeams League = 
    letmatches = concat league
        teams = concatMap (\((homeTeam, awayTeam), _) -> [homeTeam, awayTeam]) matchs 
    in sort $ foldr (\ seen -> if t 'elem' seen then seen ales t : seen) [] teams


-- Calculate the total league score for each team
ranking :: League -> [(String, Int)]
ranking league = 
    let teams = allTeams league -- Get the list of unique teams
        scores = [(team, sum $ map (matchDayScore team) league) | team <- teams]
    in sortOn (\(team, score) -> (-scpre, team)) scores -- Sort by score descending, then name ascending


-- 4
-- Function to check if a match is a draw
isDraw :: Match -> Bool
isDraw ((_, _), (homeGoals, awayGoals)) = homeGoals == awayGoals

-- Retorna o numero de matchdays na liga que têm pelo menos um empate 
-- Function to count the number of matchdays with at least one draw
numMatchDaysWithDraws :: League -> Int
numMatchDaysWithDraws league =
    length $ filter (any isDraw) league

-- 5
-- Function to detremine teams that won by at leats 3 goals in each matchday
bigWins :: League -> [(Int,[String])]
bigWins league = 
    [(i, [team | ((homeTeam, awayTeam), (homeGoals, awayGoals)) <- matchDay,
                    let(team, goalDiff) = if homeGoals > awayGoals
                                          then  (homeTeam, homeGoals - awayGoals)
                                          else (awayTeam, awayGoals - homeGoals),
                    goalDiff >= 3 && (homeGoals > awayGoals || awayGoals > homeGoals)])
    | (i, matchDay) <- zip [1..] league]

-- 6
-- Check if a team won in a specific match
isWinner :: String -> Match -> Bool
isWinner team ((homeTeam, awayTeam), (homeGoals, awayGoals))
    | team == homeTeam = homeGoals > awayGoals
    | team == awayTeam = awayGoals > homeGoals
    | otherwise = False

-- Get all winners from a matchday
matchDayWinners :: MatchDay -> [String]
matchDayWinners matchday  = [team | ((homeTeam, awayTeam), (homeGoals, awayGoals)) <- matchDay,
                                      (team, win) <- [(homeTeam, homeGoals > awayGoals), (awayTeam, awayGoals > homeGoals)],
                                      win]

-- Generate a list of (team, matchdayIndex) for each winning team
winningTeamsByMatchday :: League -> [(String, Int)]
winnningTeamsByMatchday league =
    concat [ [(team, i) | team <- matchDayWinners matchDay]
            | (matchDay, i) <- zip league [1..]]

-- Group consecutive winning matchdays for a team
groupStreaks :: [(String, Int)] -> [(String , [Int])]
groupStreaks wins =
    map (\ws -> (fst (head ws), map snd ws)) grouped
    where 
        grouped = groupBy (\(t1,d1)(t2, d2) -> t1 == t2 && d2 == d1 + 1) (sortOn snd wins)

-- Extract winning streaks with at least 2 consecutive matchdays
winningStreaks :: League -> [(String,Int,Int)]
winningStreaks league = 
    [(team, head days, last days)
    | (team, days) <- groupStreaks (winningTeamsByMatchday league), length days >= 2]


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
-- Function to find adjacent cities
adjacent :: RoadMap -> City ->[(City,Distance)]
adjacent roadMap city =
    [(otherCity, dist) <- roadmap,
    let otherCity = if c1 == city then c2 else if c2 == city then c1 else "", 
    not (null otherCity) && otherCity /= city]

-- 8
-- Function to find adjacent cities (reusing from previous exercise)
adjacent :: RoadMap -> City -> [City]
adjacent roadMap city =
    [otherCity 
    | (c1, c2, _) <- roadMap,
    let otherCity = if c1 == city then c2 else if c2 == city then c1 else "",
    not (null otherCity)]

-- Function to check if two cities are connected
areConnected :: RoadMap -> City -> City -> Bool
areConnected roadMap strat target = dfs roadMap [start] target []

-- Depth-First Search helper function
dfs :: RoadMap -> [City] -> City -> [City] -> Bool
dfs roadMap [] target _ = False -- No more cities to explore
dfs roadMap (current:stack) target visited
    | current == target = True -- Found the target city
    | current 'elem' visited = dfs roadMap stack target visited -- Skip already visited city
    | otherwise = 
        -- Explore neighbors and continue DFS
        let neighbors  = adjacent roadMap current   
            newStack = neighbors  ++ stack -- Add neighbors to the stack 
        in dfs roadMap newStack target (current : visited)

-- 9
data KdTree = Empty | Node Char (Int,Int) KdTree KdTree deriving (Eq,Show)

tree1 :: KdTree
tree1 = Node 'x' (3,3) (Node 'y' (2,2) Empty Empty) (Node 'y' (4,4) Empty Empty)

tree2 :: KdTree
tree2 = Node 'x' (3,3) (Node 'y' (2,2) (Node 'x' (1,1) Empty Empty) Empty) (Node 'y' (4,4) (Node 'x' (3,2) Empty Empty) Empty)
 

-- 9

insert :: (Int,Int) -> KdTree -> KdTree
insert point Empty = Node 'x' point Empty Empty -- If tree is empty, create a new root node with 'x'
insert point@(px,py) (Node axis (x,y) left right)
    |point == (x,y) = Node axis (x,y) left right -- If point already exists, return the current tree
    | axis == 'x' = 
        if px < x
        then Node 'x' (x,y) (insert point left) right -- Go to the left subtree if px < x
        else Node 'x' (x,y) left (insert point right) -- Go to the right subtree if px >= x
    | axis == 'y' =
        if py < y 
        then Node 'y' (x,y) (insert point left ) right -- Go to the left subtree if py < y
        else Node 'y' (x,y) left (insert point right) -- Go to the right subtree if py >= y


-- 10
-- Main function to print the KD-tree
putTreeStr :: KdTree -> IO ()
putTreestr tree = putStr (treeToStr tree 0)

-- Helper function to convert the tree to a string with indentation
treeToStr :: KdTree -> Int -> String
treeToStr Empty _ = "" -- Nothing to print for an empty tree
treeToStr (Node axis (x,y) left right) depth =
    indent ++ "(" ++ show x ++ "," ++ show y ++ ")\n" ++
    indent ++ axis : "<" ++ show (if axis == 'x' then x else y) ++ "\n" ++
    treeToStr left (depth + 1) ++
    indent ++ axis : ">=" ++ show (if axis == 'x' then x else y) ++ "\n" ++
    treeToStr right (depth + 1)
    where 
        indent = replicate (2 * depth) ' ' -- Indentation based on depth 