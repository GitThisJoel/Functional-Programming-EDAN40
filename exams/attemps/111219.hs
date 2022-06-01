-- Exam 2011-12-19

-- 1.
-- map   :: (a -> b) -> [a] -> [b] 
-- const :: a -> b -> a 
-- (++)  :: [a] -> [a] -> [a] 

-- a) map (const (++)) :: 
--      correct => [b] -> [[a] -> [a] -> [a]]
--
-- b) const (map (++)) :: 
--      correct => [b] -> [[a]] -> [[a] -> [a]]


-- 2.
-- currying: a way of converting a function that takes multiple arguments into a sequence of functions that each take a single argument.
-- 
-- uncurrying: is the "reverse" of currying. It can be seen as: 
-- 
-- h(x)(y) = f(x,y) 
-- curry(f) = h 
-- uncurry(h) = f
--
-- curry       :: ((a, b) -> c) -> a -> b -> c
-- curry f x y = f (x, y)
--
-- uncurry     :: (a -> b -> c) -> (a, b) -> c
-- uncurry f p = f (fst p) (snd p)


-- 3. 
-- What is the type and value od
do [1, 2, 3, 4]; "curry"
-- value = "currycurrycurrycurry"
-- type  = String = [Char]

do [1,2,3,4]; return "uncurry"
-- value = ["uncurry","uncurry","uncurry","uncurry"]
-- type  = [[Char]]

-- OBS! might be good to look at this again


-- 4.
-- What does 
(\\) = foldl (flip delete)
c a = (a \\) . (a \\) 
-- => 
c1 a = foldl (flip delete) a . foldl (flip delete) a
-- a function called c
-- c finds the intersection between two lists, i.e
-- c [1,2..6] [3,4..7] => [3,4,5,6]


-- 5.
-- Point free notation
-- f x y = (5 + x) / y
f = (/) . (5+) 

-- g x y = x y
g = ($) -- or id


-- 6.
-- define a Tree

data Tree a = Leaf a | Node a [Tree a]

branchEq t1 t2 = 
  | (Leaf l1)     (Leaf l2)     = (l1 == l2)
  | (Tree x ts)   (Leaf l)      = (x  == l)
  | (Leaf l)      (Tree x ts)   = (x  == l) 
  | (Tree x1 ts1) (Tree x2 ts2) = (x1 == x2) && 3

-- correct
data Tree = Leaf Integer | Node Tree Integer Tree 

subTree :: Tree -> Tree -> Bool
subTree (Leaf x) t = inTree i t
subTree (Node _ _ _) (Leaf _) = False
subTree (Node t1 i t2) (Node t3 j t4) = 
  ((i == j) && (subTree t1 t3) && (subTree t2 t4) || 
  subTree (Node t1 i t2) t3 || 
  subTree (Node t1 i t2) t4 

inTree :: Integer -> Tree -> Bool
inTree i (Leaf l) = (i == l) 
inTree i (Node t1 j t2) = (i == j) || inTree i t1 || inTree i t2
