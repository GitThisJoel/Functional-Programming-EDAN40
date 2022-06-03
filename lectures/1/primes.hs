
-- fac
f 0 = 1
f n = n * f (n-1)

-- primes
primes = sieve [2..]
  where
    sieve (n:ns) =
      n : sieve [ x | x <- ns, x `mod` n > 0 ]
      
