-- | Template for the Haskell exercises in 03-Types
-- Student name: Ethan Bastin
-- Student number: 560704
module Assignments.Types.Haskell where

-- This is Haskell's standard library
import Data.Char
import Prelude

-- Write your solutions here

types1Foo :: Bool
types1Foo = False :: Bool

types1Example :: String
types1Example = "Bool"

-- A: True
types1A :: String
types1A = "Bool"

-- B: 5
types1B :: String
types1B = "Num a => a"

-- C: 5.0
types1C :: String
types1C = "Fractional a => a"

-- D: (==)
types1D :: String
types1D = "Eq a => a -> a -> Bool"

-- E: (+)
types1E :: String
types1E = "Num a => a -> a -> a"

-- F: (/)
types1F :: String
types1F = "Fractional a => a -> a -> a"

-- G: mod
types1G :: String
types1G = "Integral a => a -> a -> a"

-- H: fromIntegral
types1H :: String
types1H = "(Integral a, Num b) => a -> b"

-- I: fromInteger
types1I :: String
types1I = "Num a => Integer -> a"

-- J: Just True
types1J :: String
types1J = "Maybe Bool"

-- K: Nothing
types1K :: String
types1K = "Maybe a"

-- L: Left 5
types1L :: String
types1L = "Num a => Either a b"

types2Foo :: a -> a
types2Foo a = a

types2Example :: String
types2Example = "a -> a"

-- A: (+)
types2A :: String
types2A = "Num a => a -> a -> a"

-- B: (1 +)
types2B :: String
types2B = "Num a => a -> a"

-- C: (1 + 2)
types2C :: String
types2C = "Num a => a"

-- (+ 1) has type: Num a => a -> a
-- ((1 :: Int) +) has type: Int -> Int
-- ((1 :: Int) + (2 :: Integer)) gives an error because Int and Integer are different types

myIsJust :: Maybe a -> Bool
myIsJust (Just _) = True
myIsJust Nothing = False

getLeft :: Either a b -> Maybe a
getLeft (Left x) = Just x
getLeft (Right _) = Nothing

isNegative :: (Ord a, Num a) => a -> Bool
isNegative x = x < 0

isZero :: (Eq a, Num a) => a -> Bool
isZero x = x == 0

range8Int :: (Int, Int)
range8Int = (minBound @Int, maxBound @Int)

range8Char :: (Char, Char)
range8Char = (minBound @Char, maxBound @Char)

range8Bool :: (Bool, Bool)
range8Bool = (minBound @Bool, maxBound @Bool)

range8Word :: (Word, Word)
range8Word = (minBound @Word, maxBound @Word)

range8Ordering :: (Ordering, Ordering)
range8Ordering = (minBound @Ordering, maxBound @Ordering)

getFractional :: RealFrac a => a -> a
getFractional x = x - fromIntegral (floor x :: Integer)

nextChar :: Char -> Char
nextChar c = chr (ord c + 1)

nextLetter :: Char -> Char
nextLetter c
  | c == 'z' = 'a'
  | c == 'Z' = 'A'
  | isLetter c = chr (ord c + 1)
  | otherwise = c
