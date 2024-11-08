import qualified Data.List
import Data.List (groupBy, sortOn, nub, maximumBy, permutations, minimumBy)
import qualified Data.Array
import qualified Data.Bits


type City = String
type Path = [City]
type Distance = Int

type RoadMap = [(City,City,Distance)]

--8
-- shortestPath :: RoadMap -> City -> City -> [Path]
-- Uses BFS to find all shortest paths between two cities.
-- Arguments:
--   roadMap - A RoadMap representing the network of cities and distances between them.
--   start - The starting city.
--   end - The destination city.
-- Returns:
--   A list of all possible shortest paths (lists of cities) from the start city to the end city.
shortestPath :: RoadMap -> City -> City -> [Path]
shortestPath roadMap start end
    | start == end = [[start]]  -- If the origin and destination cities are the same, the shortest route is to the city itself
    | otherwise = bfs [[start]] [] -- We use BFS from the city of origin
  where
    -- BFS helper function to explore paths
    -- bfs :: [Path] -> [Path] -> [Path]
    -- Arguments:
    --   queue - A list of paths that need to be explored.
    --   foundPaths - A list of paths that have reached the destination.
    -- Returns:
    --   An updated list of found paths that reach the destination.
    bfs :: [Path] -> [Path] -> [Path]
    bfs [] foundPaths = foundPaths  -- When the queue is empty, we finish and return the found paths
    bfs (path:queue) foundPaths
        | currentCity == end =
            -- If we reach the destination, we add the current path to the list of found paths
            bfs queue (addPath foundPaths path)
        | otherwise =
            -- Otherwise, we continue to explore adjacent paths
            let newPaths = [path ++ [nextCity] | (nextCity, _) <- adjacent roadMap currentCity,
                                                nextCity `notElem` path] -- We add the next city to the current path
                extendedQueue = queue ++ newPaths -- We added the new paths to the queue
                sortedQueue = sortOn pathLength extendedQueue -- We order the queue by the paths with the shortest distance
            in bfs sortedQueue foundPaths
      where
        currentCity = last path  -- The current city is the last element of the current path

    -- addPath :: [Path] -> Path -> [Path]
    -- Helper function to add a path to the list of found paths, keeping only the shortest ones.
    -- Arguments:
    --   foundPaths - A list of already found shortest paths.
    --   newPath - The path that we are adding if it has the shortest distance.
    -- Returns:
    --   An updated list of shortest paths.
    addPath :: [Path] -> Path -> [Path]
    addPath [] newPath = [newPath] -- If the path list is empty, we add the new path
    addPath foundPaths newPath
        | pathLength newPath < pathLength (head foundPaths) = [newPath]  -- If the new path is shorter, we discard the previous ones
        | pathLength newPath == pathLength (head foundPaths) = newPath : foundPaths -- If it is the same length, we add
        | otherwise = foundPaths  -- Otherwise, we keep the paths already found

    -- pathLength :: Path -> Distance
    -- Helper function to calculate the length of a path.
    -- Arguments:
    --   path - The path whose length is being calculated.
    -- Returns:
    --   The total distance of the path as a Distance.
    pathLength :: Path -> Distance
    pathLength path = case pathDistance roadMap path of
                        Just d -> d
                        Nothing -> maxBound :: Int -- We set the value too high for invalid paths

--9
-- travelSales :: RoadMap -> Path
-- Solves the Traveling Salesman Problem (TSP) by finding the shortest path that visits all cities exactly once and returns to the starting city.
-- Arguments:
--   roadMap - A RoadMap representing the network of cities and distances between them.
-- Returns:
--   A path representing the shortest possible route that visits each city exactly once and returns to the starting city, or an empty list if no such path exists.
travelSales :: RoadMap -> Path
travelSales roadMap
    | null allCities = []  -- If there are no cities, returns an empty list
    | otherwise = case validPaths of
                    [] -> []  -- If there are no valid paths, returns an empty list
                    _  -> minimumBy comparePaths validPaths  -- Returns the path with the shortest total distance
  where
    allCities = cities roadMap  -- Get all cities
    startingCity = head allCities  -- We chose the first city as a starting point
    possibleRoutes = map (\perm -> startingCity : perm ++ [startingCity]) (permutations (tail allCities))  -- Generates all possible routes (permutations of cities)
    
    -- validPaths :: [Path]
    -- Filters only valid paths (those where all cities are connected).
    validPaths = filter (isValidRoute roadMap) possibleRoutes

    -- comparePaths :: Path -> Path -> Ordering
    -- Function to compare two paths by their total length.
    -- Arguments:
    --   p1, p2 - Paths to be compared based on their distances.
    -- Returns:
    --   The ordering based on the total distances of p1 and p2.
    comparePaths :: Path -> Path -> Ordering
    comparePaths p1 p2 = compare (totalDistance p1) (totalDistance p2)

    -- totalDistance :: Path -> Distance
    -- Calculates the total distance of a path.
    -- Arguments:
    --   path - The path whose total distance is being calculated.
    -- Returns:
    --   The total distance of the path, or a maximum bound if the path is invalid.
    totalDistance :: Path -> Distance
    totalDistance path = case pathDistance roadMap path of
                           Just d -> d
                           Nothing -> maxBound  -- Invalid paths will have a maximum distance

-- isValidRoute :: RoadMap -> Path -> Bool
-- Checks if a route is valid (all cities are connected).
-- Arguments:
--   roadMap - A RoadMap representing the network of cities and distances between them.
--   path - The path being checked for connectivity.
-- Returns:
--   True if the route is valid (all cities are connected), False otherwise.
isValidRoute :: RoadMap -> Path -> Bool
isValidRoute roadMap path = case pathDistance roadMap path of
                              Just _ -> True
                              Nothing -> False


