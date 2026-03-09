-- | Solutions to the exercises in 02-Haskell-Basics.adoc
-- Student name: Ethan Bastian  
-- Student number: 560704
module Assignments.HaskellBasics where

-- This is Haskell's standard library
import Prelude -- Uncomment
-- Write your solutions here

square :: Integer -> Integer
square x = x * x 

sumProductDifference :: Int -> Int -> (Int, Int, Int)
sumProductDifference x y = (x + y, x * y, x - y)

vectorMagnitude2D :: (Double, Double) -> Double
vectorMagnitude2D (x, y) = sqrt (x**2 + y**2)

vectorMagnitude3D :: (Double, Double, Double) -> Double
vectorMagnitude3D (x, y, z) = sqrt (x**2 + y**2 + z**2)

convertTo3D :: (Double, Double) -> (Double, Double, Double)
convertTo3D (x, y) = (x, y, 0.0)

vectorMultiply :: Double -> (Double, Double, Double) -> (Double, Double, Double)
vectorMultiply s (x, y, z) = (s * x, s * y, s * z)

isBetween :: Int -> Int -> Int -> Bool
isBetween val low high = val >= low && val <= high || val >= high && val <= low

multiplyOrSubtract :: Int -> Int
multiplyOrSubtract x = if x < 100 then x * 10 else x - 100

extractMiddle :: (a, b, c) -> b
extractMiddle (_, b, _) = b

checkDivisibility :: Int -> String
checkDivisibility x
  | mod x 2 == 0 = "Divisible by 2"
  | mod x 3 == 0 = "Divisible by 3"
  | mod x 5 == 0 = "Divisible by 5"
  | mod x 7 == 0 = "Divisible by 7"
  | otherwise    = "Not divisible by 2, 3, 5, or 7"

checkDivisibilityCase :: Int -> String
checkDivisibilityCase x = case (mod x 2, mod x 3, mod x 5, mod x 7) of
  (0, _, _, _) -> "Divisible by 2"
  (_, 0, _, _) -> "Divisible by 3"
  (_, _, 0, _) -> "Divisible by 5"
  (_, _, _, 0) -> "Divisible by 7"
  _            -> "Not divisible by 2, 3, 5, or 7"

isNegative :: Int -> Bool
isNegative x = x < 0

multiplyBy3 :: Int -> Int
multiplyBy3 = (* 3)

isEmptyList :: [Int] -> Bool
isEmptyList [] = True
isEmptyList _  = False

incrementingIndices :: [Int]
incrementingIndices = [0..]

incrementingEvens :: [Int]
incrementingEvens = [x | x <- [0..], even x]

concatString :: String -> String -> String
concatString s1 s2 = s1 ++ s2

yell :: String -> String
yell s = concatString s "!"

greeting :: String -> String
greeting = concatString "Hello "

greetPerson :: String -> String
greetPerson = yell . greeting

applyCommand :: String -> Int -> Int -> Int
applyCommand cmd x y
  | cmd == "add"      = x + y
  | cmd == "subtract" = x - y
  | cmd == "multiply" = x * y
  | cmd == "divide"   = div x y
  | cmd == "first"    = x
  | cmd == "second"   = y
  | otherwise         = error "invalid command"

dotProduct :: (Int, Int) -> (Int, Int) -> Int
dotProduct (x1, y1) (x2, y2) = x1 * x2 + y1 * y2

crossProduct :: (Double, Double, Double) -> (Double, Double, Double) -> (Double, Double, Double)
crossProduct (a1, a2, a3) (b1, b2, b3) = (a2*b3 - a3*b2, a3*b1 - a1*b3, a1*b2 - a2*b1)


isPrime :: Int -> Bool
isPrime n
    | n <= 1    = False
    | otherwise = null [x | x <- [2..floor (sqrt (fromIntegral n))], n `mod` x == 0]

everySecondElement :: [Int] -> [Int]
everySecondElement []       = []
everySecondElement [_]      = []
everySecondElement (_:x:xs) = x : everySecondElement xs

secondLastElement :: [Int] -> Int
secondLastElement xs
    | len < 2   = error "List too short"
    | otherwise = xs !! (len - 2)
    where len = length xs

primeNumbers :: [Int]
primeNumbers = filter isPrime [2..]

fibN :: Integer -> Integer
fibN n
    | n < 0     = error "negative number"
    | n == 0    = 0
    | n == 1    = 1
    | otherwise = fibN (n - 1) + fibN (n - 2)

fibonacci :: [Integer]
fibonacci = fun 0 1
    where
        fun a b = a : fun b (a + b)
