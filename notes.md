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

Type of f?
```haskell
f x y = do
  a <- x
  b <- y
  return (a*b)
```

answer:
```haskell
f :: (Monad m, Num b) => m b -> m b -> m b 
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

## Sparks and parallelization
- `spark`: "potential of a thread"
- `seq`: forces evaluation its first argument up to WHNF, has value of the second argument
- `pseq`: forces evaluation its first argument up to WHNF **before** returning value of the second argument
- `par`: evaluates its first argument up to WHNF, possibly in parallel (creates a spark) with returning value of the second argument

## Subclasses
```haskell
instance (Eq m) => Eq (Maybe m) where 
  Just x == Just y = x == y
  Nothing == Nothing = True 
  _ == _ = False
```

```haskell
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
```

```haskell
instance (Eq a) => Eq (Tree3 a) where
  (==) (Leaf x) (Leaf y) = (x == y)
  (==) (Node s1 x1 y1 z1) (Node s2 x2 y2 z2) = (s1 == s2) && (x1 == x2) && (y1 == y2) && (z1 == z2)
  (==) _ _ = False
```

## Some functions and types:

## Type derivation

## MyNatural example
In this example no negative values can be stored thus negative values raises errors.

```haskell
data MyNatural = Empty | () :-: MyNatural
  deriving (Eq, Show) 
infixr 5 :-:

-- for MyNatural to be considere a Num we need to derive:
-- (+), (-), (*), negate, abs, signum, fromInteger
-- remember (abs x) * (signum x) = x


natPlus Empty      y = y
natPlus (() :-: x) y = () :-: (natPlus x y)

natTimes Empty      y = Empty
natTimes (() :-: x) y = natPlus y (natTimes x y)

natMinus x          Empty      = x
natMinus Empty      y          = error "Negative Natrual"
natMinus (() :-: x) (() :-: y) = natMinus x y

natSignum Empty      = Empty 
natSignum (() :-: x) = () :-: Empty

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
```

## Assignment 3
```haskell
word   :: Parser String 
#-     :: Parser a -> Parser b -> Parser a 
accept :: String -> String String
#      :: Parser a -> Parser b -> Parser (a, b) 
Expr.parse :: Parser Expression
require    :: String -> Parser String
>->    :: Parser a -> (a -> b) -> Parser b
buildAss   :: (String, Expression) -> Statement
Assignment :: String -> Expression -> Statement 
```