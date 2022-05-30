f x y = do
  a <- x
  b <- y
  return (a*b)

-- g = [1,2,3]; []; "abc"

data Tree3 a = Leaf a | Node a (Tree3 a) (Tree3 a) (Tree3 a)
  deriving (Show)
