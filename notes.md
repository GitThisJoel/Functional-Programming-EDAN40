# Functional programming notes

## Functors
Basically for things that can be mapped over. 

The class Functor is defined as: 
```haskell
class Functor f where 
  fmap :: (a -> b) -> f a -> f b
```
Note that `f` is a type constructor such as `[]` or `Maybe`.

All functors should obey:
```haskell
fmap id      = id
fmap (p . q) = (fmap p) . (fmap q)
```

```haskell
instance Functor [] where 
  fmap g []     = []
  fmap g (x:xs) = [g x] ++ (fmap g xs)
```

```haskell
instance Functor Maybe where 
  fmap g (Just x) = Just (g x)
  fmap g Nothing  = Nothing
```

If we have a `Tree` then we could do something like:
```haskell
data Tree a = EmptyTree | Leaf a | Node a (Tree a) (Tree a) 
instance Functor Tree where
  fmap f EmptyTree           = EmptyTree
  fmap f (Leaf x)            = Leaf (f x)
  fmap f (Node x left right) = Node (f x) (fmap f left) (fmap f right)
```

## Monads 

```haskell
class Monad m where 
  return a -> m a 
  
  (>>=) :: m a -> (a -> m b) -> m b

  (>>) :: m a -> m b -> m b
  x >> y = x >>= \_ -> y

  fail :: String -> m a  
  fail msg = error msg
```

A monad for `Maybe`
```haskell
class Monad Maybe where 
  return x      = Just x
  Nothing >>= f = Nothing
  Just x  >>= f = f x 
  fail _        = Nothing
```

### do-notaton
```haskell
do [1,2,3]; []; "abc" -- => ""
-- equal to
do {
  [1,2,3]; 
  do {
    []; -- since this one is empty it is the same as Nothing, thus output = ""
    do {
      "abc"
    }
  }
}
```

```haskell
do [1,2,3]; []; return "abc" -- => []
```

`return` takes something and wraps it in a monad, like `pure` for applicatives.

## Applicative 

<*>
<$>

## data types

## Some functions and types:

## Type derivation