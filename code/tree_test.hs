data Tree a = EmptyTree | Leaf a | Node a (Tree a) (Tree a) 
instance Functor Tree where
  fmap f EmptyTree           = EmptyTree
  fmap f (Leaf x)            = Leaf (f x)
  fmap f (Node x left right) = Node (f x) (fmap f left) (fmap f right) 
