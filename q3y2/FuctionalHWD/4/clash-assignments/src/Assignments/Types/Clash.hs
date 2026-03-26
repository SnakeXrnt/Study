{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE DataKinds #-}

-- | Solutions to the Clash exercises in 03-Types
-- Student name: Ethan Bastin
-- Student number: 560704
module Assignments.Types.Clash where

-- This is Clash's standard library
import Clash.Prelude

-- Write your solutions here

fourthBit :: BitVector 8 -> Bool
fourthBit bv = testBit bv 3

types13Foo :: p -> Unsigned 8
types13Foo _ = 15 :: Unsigned 8

types13Example :: String
types13Example = "Unsigned 8"

-- A: foo = 0 :> 1 :> 2 :> Nil
types13A :: String
types13A = "Vec 3 (Num a => a)"

-- B: bar v = minBound :> maxBound :> Nil ++ v
types13B :: String
types13B = "(Bounded a, KnownNat n) => Vec n a -> Vec (2 + n) a"

-- C: mySnat = d3
types13C :: String
types13C = "SNat 3"

type Vector3D = (Double, Double, Double)

type Vector2D = (Double, Double)

vectorMagnitude2D :: Vector2D -> Double
vectorMagnitude2D (x, y) = sqrt (x * x + y * y)

vectorMagnitude3D :: Vector3D -> Double
vectorMagnitude3D (x, y, z) = sqrt (x * x + y * y + z * z)

convertTo3D :: Vector2D -> Vector3D
convertTo3D (x, y) = (x, y, 0)

data Weekday
  = Monday
  | Tuesday
  | Wednesday
  | Thursday
  | Friday
  | Saturday
  | Sunday
  deriving (Eq, Show)

data Shape
  = Circle Double
  | Rectangle Double Double
  deriving (Eq, Show)

nextDay :: Weekday -> Weekday
nextDay Monday = Tuesday
nextDay Tuesday = Wednesday
nextDay Wednesday = Thursday
nextDay Thursday = Friday
nextDay Friday = Saturday
nextDay Saturday = Sunday
nextDay Sunday = Monday

shapeArea :: Shape -> Double
shapeArea (Circle r) = pi * r * r
shapeArea (Rectangle w h) = w * h

shapePerimeter :: Shape -> Double
shapePerimeter (Circle r) = 2 * pi * r
shapePerimeter (Rectangle w h) = 2 * (w + h)

data TransportProtocol = TCP | UDP deriving (Eq, Show)

data ConnectionStatus = Open | Closed deriving (Eq, Show)

data NetworkConnection = NetworkConnection
  { serverIp :: Vec 4 (Unsigned 8)
  , portNumber :: Unsigned 16
  , protocol :: TransportProtocol
  , status :: ConnectionStatus
  }
  deriving (Eq, Show)

data LinkStatus = Up | Down deriving (Eq, Show)

data NetworkInterface = NetworkInterface
  { macAddress :: Vec 6 (Unsigned 8)
  , ipAddress :: Vec 4 (Unsigned 8)
  , subnetMask :: Vec 4 (Unsigned 8)
  , linkStatus :: LinkStatus
  }
  deriving (Eq, Show)

instance Ord Shape where
  compare s1 s2 = compare (shapeArea s1) (shapeArea s2)

dropTakeVec :: SNat offset -> SNat length -> Vec (offset + (length + rest)) a -> Vec length a
dropTakeVec offset len vec = takeSNat len (dropSNat offset vec)
  where
    dropSNat :: SNat n -> Vec (n + m) a -> Vec m a
    dropSNat SNat xs = dropI xs
    
    takeSNat :: SNat n -> Vec (n + m) a -> Vec n a
    takeSNat SNat xs = takeI xs
