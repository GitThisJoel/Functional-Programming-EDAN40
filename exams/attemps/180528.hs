-- Exam 2018-05-28

-- 1.
-- Point free notation
 
-- f x y = (3 - y) / x
f = flip $ (/).(3-) 

-- g x y = [x z | z <- [1,3..y]]
g = flip $ (flip map) . (filter odd) . (flip take (iterate (+1) 1))


-- 2.
-- (.) :: (b -> c) -> (a -> b) -> a -> c
-- (:) :: a -> [a] -> [a]

-- a) (.)(:) :: (a1 -> a2) -> a1 -> [a2] -> [a2]
 
-- b) (:)(.) :: [(b -> c) -> (a -> b) -> a -> c] -> [(b -> c) -> (a -> b) -> a -> c]

-- c) ((.):) :: [(b -> c) -> (a -> b) -> a -> c] -> [(b -> c) -> (a -> b) -> a -> c]

-- d) (:(.)) :: Error
--
-- e) ([]>>=)(\_->[(>=)]) :: Ord a => [a -> a -> Bool]
-- obs! not Eq but Ord above!


-- 3.
-- Yes, does not flip the list.
-- Proof?


-- 4. 
func :: ([a] , a -> b) -> [b]
func (xs, f) = map f xs 


-- 5.
instance (Ord a, Ord b) => Ord (a,b) where 
  (>)  (a,b) (c,d) = (a > c) || ((a == c) && (b >  c))
  (>=) (a,b) (c,d) = (a > c) || ((a == c) && (b >= c)) 
  (<)  (a,b) (c,d) = (a < c) || ((a == c) && (b <  c)) 
  (<=) (a,b) (c,d) = (a < c) || ((a == c) && (b <= c))
  max (a,b) (c,d) 
    | (a,b) >= (c,d) = (a,b) 
    | otherwise      = (c,d)
  min (a,b) (c,d) 
    | (a,b) <= (c,d) = (a,b)
    | otherwise      = (c,d)

-- instance Ord b => Ord [b] where
  -- ??     


-- 6.
f x y = do
  a <- x
  b <- y
  return (a*b)

-- a) type of f?
-- [a] -> [a] -> [a] WRONG! 
-- f :: (Monad m, Num b) => m b -> m b -> m b 

-- b) value of f [1,2,3] [2,4,8]?
-- [2,4,8, 4,8,16, 6,12,24]

-- c)
-- Nothing (!)

-- d)
-- return 5 :: (Monad m, Num a) => m a (!)

-- e)
-- do [1,2,3]; []; "abc"?
-- ""

-- f)


