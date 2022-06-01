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

### do-notaton

## data types

## Some functions and types:
>>= 
>>
<*>

## Terms

### Curried

### Dot free notation

### Polymorphic types

### IO

### do-notation

### Modules

### Union types

### Maybe

### foldl, foldr, scanl, scanr

### zip

### Type derivation

### sparks
