module Lecture2 where

count :: Int -> String

count 1 = "one"
count 2 = "two"
count _ = "many"

count1 1 = "one"
count1 _ = "many"
count1 2 = "two"


--oddOrEven :: Int -> String
oddOrEven i
    | odd (i-1)     = "even"
    | even (i-1)    = "odd"
    | otherwise     = "strange"

ooe :: Int -> String
ooe i
    | i < 0                = "error"
    | i == 0               = "even"
    | ooe (i-1) == "odd"   = "even"
    | ooe (i-1) == "even"  = "odd"
    | otherwise     = "strange"

--- from l1.hs
runningSums xs = theSolution
   where
   theSolution = zipWith (+) xs (0:theSolution)

f 0 = 1
f n = n * f (n-1)

fac x = fromInteger (f x)
--- 

ones1 = 1:ones1

ones2 = [1,1..]

sieve1 [] = []
sieve1 (n:ns) = n: sieve1 (filter (\x-> x `mod` n > 0) ns)

sieve2 [] = []
sieve2 (n:ns) = n: sieve2 [ x | x <- ns, x `mod` n > 0 ]

eExp x = runningSums [ (x^i)/(fac i) | i<-[0..]]

allIntPairs = [ (i,j) | i<-[0..], j<-[0..i]]
--allIntPairs2 = [ (i,j) | i<-[0..j], j<-[0..]]

greeting :: IO ()

greeting = do
   putStrLn "Enter your name"
   name <- getLine 
   putStrLn ("You " ++ name ++ ", me Haskell!")

---

data MyColour = Czerwony | Red | Röd | Zielony | Green | Grön 

instance Eq MyColour where
  Czerwony == Red  = True
  Czerwony == Röd  = True
--  Red == Röd       = True
--  Red == Czerwony  = True
--  Röd == Czerwony  = True
--  Röd == Red       = True
  Zielony == Green = True
  Zielony == Grön  = True
  _ == _           = False

elemm x xs = any (==x) xs

data MyColour2 = Czerwony2 | Red2 | Röd2 | Zielony2 | Green2 | Grön2 deriving (Enum, Show)

data MyColour3 = Czerwony3 | Red3 | Röd3 | Zielony3 | Green3 | Grön3 deriving (Eq, Enum, Show)

data Price = Euro Int Int | Dollar Int Int

---------------------------------
-- foldr f z []     = z
-- foldr f z (x:xs) = f x (foldr f z xs)

-- foldl f z []     = z
-- foldl f z (x:xs) = foldl f (f z x) xs