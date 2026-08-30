-- | Template for the exercises in 04-Higher-Order-Functions
-- Student name: Ethan Bastian
-- Student number: 560704
module Assignments.HigherOrderFunctions where

-- This is Haskell's standard libraryimport

import Prelude -- Uncomment
import Data.List (mapAccumL)
import Data.Maybe (catMaybes)

-- Exercise 1 - Type Signatures

hof1a :: (a -> a) -> a -> a
hof1a f = f . f

hof1b :: Bool -> a -> a -> a
hof1b cond f g
  | cond      = f
  | otherwise = g

hof1c :: a -> a
hof1c = \x -> x

hof1d :: Num a => a -> a -> a
hof1d = \x y -> x + y

hof1e :: (b -> c) -> (a -> b) -> a -> c
hof1e f g = f . g

-- Exercise 2 - Reordering Arguments

myFlip :: (a -> b -> c) -> b -> a -> c
myFlip f x y = f y x

-- Exercise 3 - List Comprehensions

myMap :: (a -> b) -> [a] -> [b]
myMap f xs = [f x | x <- xs]

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter f xs = [x | x <- xs, f x]

myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith f xs ys = [f x y | (x, y) <- zip xs ys]

-- Applying Higher Order Functions

mulTwo :: Num a => [a] -> [a]
mulTwo = myMap (* 2)

midPoint :: Ord a => [a] -> a
midPoint xs = xs !! (length xs `div` 2)

upperElements :: Ord a => [a] -> [a]
upperElements xs = myFilter (>= midPoint xs) xs

zipAdd :: Num a => [a] -> [a] -> [a]
zipAdd = myZipWith (+)

greaterFive :: (Num a, Ord a) => [a] -> [a]
greaterFive = myFilter (\x -> x > 5)

mulTuples :: Num a => [(a, a)] -> [a]
mulTuples = myMap (\(x, y) -> x * y)

-- Exercise 4 - Making higher order functions

myFoldl :: (a -> b -> a) -> a -> [b] -> a
myFoldl _ acc []     = acc
myFoldl f acc (x:xs) = myFoldl f (f acc x) xs

myScanl :: (a -> b -> a) -> a -> [b] -> [a]
myScanl _ acc []     = [acc]
myScanl f acc (x:xs) = acc : myScanl f (f acc x) xs

-- Exercise 5 - Using higher order functions

mySum :: Num a => [a] -> a
mySum = myFoldl (+) 0

myProduct :: Num a => [a] -> a
myProduct = myFoldl (*) 1

myLength :: [a] -> Int
myLength = myFoldl (\acc _ -> acc + 1) 0

myReverse :: [a] -> [a]
myReverse = myFoldl (flip (:)) []

myMaximum :: Ord a => [a] -> a
myMaximum (x:xs) = myFoldl max x xs
myMaximum []     = error "myMaximum: empty list"

myMapMaybe :: (a -> Maybe b) -> [a] -> [b]
myMapMaybe f xs = [b | Just b <- myMap f xs]

countOccurrences :: Eq a => a -> [a] -> Int
countOccurrences e = myFoldl (\acc x -> if x == e then acc + 1 else acc) 0

filterIncreasing :: Ord a => [a] -> [a]
filterIncreasing []     = []
filterIncreasing (x:xs) = x : snd (myFoldl step (x, []) xs)
  where
    step (prev, acc) curr
      | curr >= prev = (curr, acc ++ [curr])
      | otherwise    = (prev, acc)

movingAverage :: (Real a, Fractional a) => [a] -> Int -> [a]
movingAverage xs n = snd $ mapAccumL step [] xs
  where
    step window x =
      let window' = if length window < n then window ++ [x] else tail window ++ [x]
          avg     = sum window' / fromIntegral (length window')
      in  (window', avg)

-- Extra

applyN :: (a -> a) -> Int -> a -> a
applyN f n = myFoldl (\acc _ -> f acc) `flip` replicate n ()

factorialList :: [Integer]
factorialList = myScanl (*) 1 [1..]

fibonacciList :: [Integer]
fibonacciList = myMap fst $ myScanl (\(a, b) _ -> (b, a + b)) (0, 1) [1..]
