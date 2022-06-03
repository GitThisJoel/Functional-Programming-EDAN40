Module Lecture1 where

f 0 = 1
f n = n * f (n-1)

g (-2) = 100
g _ = 200

sum1 [] = 0
sum1 (x:xs) = x + (sum1 xs)

-- foldr
ackumulate f i [] = i
ackumulate f i (x:xs) = f x (ackumulate f i xs)

sum2 = ackumulate (+) 0

product1 = ackumulate (*) 1
anyTrue = ackumulate (||) False
allTrue = ackumulate (&&) True

primes = sieve [2..] 
   where
      sieve (n:ns) =
         n : sieve [ x | x <- ns, x `mod` n > 0 ]

runningSums xs = theSolution
   where
   theSolution = zipWith (+) xs (0:theSolution)

rs xs = zipWith (+) xs (0:(rs xs))

fac n = fromInteger (f n)

eExp x = runningSums [ (x^i)/(fac i) | i <- [0..] ]



foo = ackumulate (+)
bar = ackumulate (+) 1
