-- Exam 2017-06-02

-- import Prelude
import qualified Prelude.Functor

-- 1.
data MyNatural = Empty | () :-: MyNatural
  deriving (Eq, Show) 
infixr 5 :-:

-- f1
natPlus Empty      y = y
natPlus (() :-: x) y = () :-: (natPlus x y)

-- f2
natTimes Empty      y = Empty
natTimes (() :-: x) y = natPlus y (natTimes x y)

-- f3
natMinus x          Empty      = x
natMinus Empty      y          = error "Negative Natrual"
natMinus (() :-: x) (() :-: y) = natMinus x y

-- other
natSignum Empty      = Empty 
natSignum (() :-: x) = () :-: Empty

-- integerToNat 0     = Empty
-- integerToNat 1     = () :-: (integerToNat 0)
-- integerToNat (x+1) = () :-: (integerToNat x) 

-- !!!
integerToNat n 
  | n < 0  = error "no negative naturals exists"
  | n == 0 = Empty
  | otherwise = () :-: integerToNat (n-1)

instance Num MyNatural where
  (+)          = natPlus 
  (-)          = natMinus
  (*)          = natTimes
  negate       = error "Negative Natural" 
  abs x        = x           
  signum       = natSignum
  fromInteger  = integerToNat


-- 2. 
-- a) version 2 is faster. 
-- b) In ver 1 we recursivly call similScore, where we need to build a new table each recursion. 
-- But in ver 1 build the table in the simEntry function and then return it.
--
-- ABOVE IS WRONG, BELOW IS CORRECT!
--
-- a. Version 1 is much faster than Version 2
-- b. because in version 1 the computation of simEntry i j is using the tabularized values, while in version 2 it recursively attempts to compute the value, without referring to earlier computations/table positions.
--
-- in ver 2 a new table is created for each item in maximum

-- 3.
-- a) 
-- g :: (a -> a) -> (a -> Maybe(a,a))
-- b)
-- g f x = Just(x, f x)


-- 4.
-- instance Functor [] where 
--     fmap g []  = []
--     fmap g (x:xs) = fmap g xs ++ [g x]

p = (+1) 
q = (*2)
(p . q) = (+1) . (*2)
xs = [1,2,3]

-- fmap (p . q) xs = [7, 5, 3]
--
-- fmap q xs = [6, 4, 2]
-- fmap p [6, 4, 2] = [3, 5, 7] != [7, 5, 3]
-- 
-- i.e not the same!


-- 5.
-- Spark: ????????
-- ans:
-- spark: "potential of a thread"
-- seq: forces evaluation its first argument up to WHNF, has value of the second argument
-- pseq: forces evaluation its first argument up to WHNF **before** returning value of the second argument
-- par: evaluates its first argument up to WHNF, possibly in parallel (creates a spark) with returning value of the second argument


-- 6.
-- a) Type of (.).(.)
-- 	
-- b)
-- rulesCompile :: [(String, [String])] -> [([String], [[String]])]
-- c) Type of
-- transformationApply :: Eq a => a -> ([a] -> [a]) -> [a] -> ([a], [a]) -> Maybe [a]
-- orElse :: Maybe a -> Maybe a -> Maybe a
--
-- foldr1 orElse (map (transformationApply wildcard f x) pats)
--  
-- transformationApply wildcard f x = tfa :: ([a], [a]) -> Maybe [a]
-- suppose pats :: [([a], [a])]
-- (map (tfa) pats) = m_tfa_p :: [Maybe [a]] 
-- 
-- recall: foldr1 :: (a -> a -> a) -> [a] -> a
-- foldr1 orElse ( m_tfa_p ) :: M(map (transformationApply wildcard f x) pats)aybe [a] 



