 data Arv a = Vazia No a (Arv a) (Arv a)

-- 4.1
sumArv :: Num a => Arv a -> a
sumArv Vazia = 0
sumArv (No a esq dir) = a + sumArv esq + sumArv dir

-- 4.2
listarDecrescente :: Arv a -> [a]
listarDecrescente Vazia = []
listarDecrescente (No valor esq dir) = listarDecrescente dir ++ [valor] ++ listarDecrescente esq


-- 4.3

nivel :: Int -> Arv a -> [a]
nivel _ Vazia = []
nivel 0 (No valor _ _) = [valor]
nivel n (No _ esq dir) = nivel (n-1) esq ++ nivel (n-1) dir 

-- 4.4
constroiArvore :: [a] -> Arv A
constroiArvore [] = Vazia
constroiArvore xs = No valorMeio (constroiArvore parteEsq) (constroiArvore parteDir)
    where
        meio = length xs `div` 2
        valorMeio = xs !! meio
        parteEsq = take meio xs
        partedir = drop (meio + 1) xs

alturaArvore :: Arv a -> Int
alturaArvores Vazia = 0
alturaArvore (No _ esq dir) = 1 + max (alturaArvore esq) (alturaArvore dir)


-- 4.4.b

inserir :: Ord a => a -> Arv a -> Arv A
inserir x Vazia = No x Vazia Vazia
inserir x (No y esq dir)
    |x < y  = No y (inserir x esq) dir
    |x > y = No y esq (inserir x dir)
    |otherwise = No y esq dir 

constroiArvoreSimples :: Ord a => [a] -> Arv a 
constroiArvoreSimples = foldr inserir Vazia


  -- 4.5
mapArv :: (a -> b) -> Arv a -> Arv b
mapArv _ Vazia = Vazia
mapArv f (No valor esq dir) = No (f valor )(mapArv f esq) (mapArv f dir)

instance Show a => Show (Arv a) where
    show Vazia = "Vazia"
    show (No valor esq dir) = "No " ++ show valor ++ " ()" ++ show esq ++ ") (" ++ show dir ++ ")"


-- 4.6
mais_dir :: Arv a -> a
mais_dir (No x _ Vazia) = x
mais_dir (No _ _ dir) = mais_dir dir

-- 4.6.b
remover :: Ord a => a -> Arv a -> Arv a
remover x Vazia = Vazia
remover x (No y Vazia dir)
    |x == y = dir
remover x (No y esq Vazia)
    |x == y = esq
remover x (No y esq dir)
    |x < y = No y (remover x esq) dir
    |x > y = No y esq (remover x dir)
    |x == y = let z = mais_dir esq
                in No z esq (remover z dir)


-- 4.7
 data Expr = Lit Integer |
 Op Ops Expr Expr
 data Ops = Add | Sub | Mul | Div

 eval :: Expr -> Integer
eval (Lit n) = n 
eval (Op Add e1 e2) =  eval e1 + eval e2
eval (Op Sub e1 e2) = eval e1 - eval e2
eval (Op Mul e1 e2) = eval e1 * eval e2
eval (Op Div e1 e2) = eval e1 `div` eval e2


instance Show Expr where    
    show (Lit n) = show n 
    show (Op Add e1 e2) = "(" ++ show e1 ++ " + " ++ show e2 ++ ")"
    show (Op Sub e1 e2) = "(" ++ show e1 ++ " - " ++ show e2 ++ ")"
    show (Op Mul e1 e2) = "(" ++ show e1 ++ " * " ++ show e2 ++ ")"
    show (Op Div e1 e2) = "(" ++ show e1 ++ " / " ++ show e2 ++ ")"

size :: Expr -> Integer
size (Lit _ ) = 1
size (Op _ e1 e2) = 1 + size e1 + size e2

-- 4.8
data Ops = Add | Sub | Mul | Div
    deriving Show

data Expr = Lit Integer
          | Op Ops Expr Expr
          | If BExp Expr Expr
          deriving Show

data BExp = BoolLit Bool
          | And BExp BExp
          | Not BExp
          | Equal Expr Expr
          | Greater Expr Expr
          deriving Show

eval :: Expr -> Integer
eval (Lit n) = n
eval (Op Add e1 e2) = eval e1 + eval e2
eval (Op Sub e1 e2) = eval e1 - eval e2
eval (Op Mul e1 e2) = eval e1 * eval e2
eval (Op Div e1 e2) = eval e1 `div` eval e2
eval (If b e1 e2) = if bEval b then eval e1 else eval e2

bEval :: BExp -> Bool
bEval (BoolLit b) = b
bEval (And b1 b2) = bEval b1 && bEval b2
bEval (Not b) = not (bEval b)
bEval (Equal e1 e2) = eval e1 == eval e2
bEval (Greater e1 e2) = eval e1 > eval e2

instance Show Expr where
    show (Lit n) = show n
    show (Op Add e1 e2) = "(" ++ show e1 ++ " + " ++ show e2 ++ ")"
    show (Op Sub e1 e2) = "(" ++ show e1 ++ " - " ++ show e2 ++ ")"
    show (Op Mul e1 e2) = "(" ++ show e1 ++ " * " ++ show e2 ++ ")"
    show (Op Div e1 e2) = "(" ++ show e1 ++ " / " ++ show e2 ++ ")"
    show (If b e1 e2) = "If " ++ show b ++ " then " ++ show e1 ++ " else " ++ show e2

instance Show BExp where
    show (BoolLit b) = show b
    show (And b1 b2) = "(" ++ show b1 ++ " && " ++ show b2 ++ ")"
    show (Not b) = "not " ++ show b
    show (Equal e1 e2) = "(" ++ show e1 ++ " == " ++ show e2 ++ ")"
    show (Greater e1 e2) = "(" ++ show e1 ++ " > " ++ show e2 ++ ")"

