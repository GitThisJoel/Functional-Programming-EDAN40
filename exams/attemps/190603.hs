-- Exam 2018-05-28

-- 1.
-- id:
-- fmap g [] => fmap id [] = [] = id [] 
-- fmap g (x:xs) = [g x] ++ (fmap g xs) => 
--   fmap id (x:xs) = [id x] ++ (fmap id xs) = 
--   [id x] ++ [id x2] ++ (fmap id xs2) = ... = 
--   [id x] ++ [id x2] ++ ... ++ [id xn] = xs
--
-- fmap (p . q) = (fmap p) . (fmap q) 
-- fmap g [] => 
--   fmap (p . q) [] = (fmap p) . (fmap q) [] = []
-- 
-- fmap g (x:xs) = [g x] ++ (fmap g xs) =>
--   fmap (p . q) (x:xs) =
--   = [(p . q) x] ++ (fmap (p . q) xs) =
--   = [(p . q) x] ++ ... ++ [(p . q) xn] ++ (fmap (p . q) []) = 
--   = ???


-- 2. 
-- a) data Tree3String = Leaf String | Node String (Tree3String) (Tree3String) (Tree3String)
--
-- b) 
data Tree3 a = Leaf a | Node a (Tree3 a) (Tree3 a) (Tree3 a) 
  deriving (Show)

-- c) 
instance Functor Tree3 where 
  fmap f (Leaf s) = Leaf (f s)
  fmap f (Node s t1 t2 t3) = Node (f s) (fmap f t1) (fmap f t2) (fmap f t3)

instance (Eq a) => Eq (Tree3 a) where
  (==) (Leaf x) (Leaf y) = (x == y)
  (==) (Node s1 x1 y1 z1) (Node s2 x2 y2 z2) = (s1 == s2) && (x1 == x2) && (y1 == y2) && (z1 == z2)
  (==) _ _ = False

myLength :: Tree3 String -> Tree3 Int
myLength = fmap length


-- 3.
-- Point free notation
-- f x y = (3 - y) * x
f = flip $ (*).(3-) 
-- g x y = map x $ filter (<3) y
g = flip $ (flip map) . (filter (<3))


-- 4.
-- The first one evaluates just one element in each sublist, almost everything is sequential.

-- Correct!
-- because par and pseq enforce evaluation only to the WHNF, i.e. the head  of lists lesser and greater, yielding no useful paralellisation
-- what is missing is "force" evaluating the whole spine of a list


-- 5.
-- a)
-- word   :: Parser String 
-- #-     :: Parser a -> Parser b -> Parser a 
-- accept :: String -> String String
-- #      :: Parser a -> Parser b -> Parser (a, b) 
-- Expr.parse :: Parser a 
--    Correct => Parser Expression
-- require    :: String -> Parser String
-- >->    :: Parser a -> (a -> b) -> Parser b
-- buildAss   :: 
--    Correct => (String, Expression) -> Statement
-- Assignment :: Parser Statement
--    Correct => String -> Expression -> Statement 

-- b) 
assignment input = do
  (var, rest1) <- word input
  (foo, rest2) <- accept ":=" rest1 
  (val, rest3) <- Expr.parse rest2
  (bar, rest4) <- require ";" rest3
  return (buildAss (var, val)) rest4  
