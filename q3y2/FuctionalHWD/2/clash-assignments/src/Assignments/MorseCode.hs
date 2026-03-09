-- Student name:
-- Student number:
module Assignments.MorseCode where

import Clash.Explicit.Prelude

-- import Data.Char(ord, chr) -- Uncomment if you need the Char functions
-- import Data.Maybe -- Uncomment if you need Maybe functions

-- Import all definitions from `Data.List` in the `L` namespace
-- You can use the definitions by prefixing them with `L.`: `L.concat`, `L.length`, etc.
import qualified Data.List as L

data MorseCode = Dot | Dash | Space
  deriving (Eq, Show, Generic, NFDataX, BitPack)

asciiToMorse :: Char -> [MorseCode]
asciiToMorse 'A' = [Dot, Dash, Space]
asciiToMorse 'B' = [Dash, Dot, Dot, Dot, Space]
asciiToMorse 'C' = [Dash, Dot, Dash, Dot, Space]
asciiToMorse 'D' = [Dash, Dot, Dot, Space]
asciiToMorse 'E' = [Dot, Space]
asciiToMorse 'F' = [Dot, Dot, Dash, Dot, Space]
asciiToMorse 'G' = [Dash, Dash, Dot, Space]
asciiToMorse 'H' = [Dot, Dot, Dot, Dot, Space]
asciiToMorse 'I' = [Dot, Dot, Space]
asciiToMorse 'J' = [Dot, Dash, Dash, Dash, Space]
asciiToMorse 'K' = [Dash, Dot, Dash, Space]
asciiToMorse 'L' = [Dot, Dash, Dot, Dot, Space]
asciiToMorse 'M' = [Dash, Dash, Space]
asciiToMorse 'N' = [Dash, Dot, Space]
asciiToMorse 'O' = [Dash, Dash, Dash, Space]
asciiToMorse 'P' = [Dot, Dash, Dash, Dot, Space]
asciiToMorse 'Q' = [Dash, Dash, Dot, Dash, Space]
asciiToMorse 'R' = [Dot, Dash, Dot, Space]
asciiToMorse 'S' = [Dot, Dot, Dot, Space]
asciiToMorse 'T' = [Dash, Space]
asciiToMorse 'U' = [Dot, Dot, Dash, Space]
asciiToMorse 'V' = [Dot, Dot, Dot, Dash, Space]
asciiToMorse 'W' = [Dot, Dash, Dash, Space]
asciiToMorse 'X' = [Dash, Dot, Dot, Dash, Space]
asciiToMorse 'Y' = [Dash, Dot, Dash, Dash, Space]
asciiToMorse 'Z' = [Dash, Dash, Dot, Dot, Space]
asciiToMorse '1' = [Dot, Dash, Dash, Dash, Dash, Space]
asciiToMorse '2' = [Dot, Dot, Dash, Dash, Dash, Space]
asciiToMorse '3' = [Dot, Dot, Dot, Dash, Dash, Space]
asciiToMorse '4' = [Dot, Dot, Dot, Dot, Dash, Space]
asciiToMorse '5' = [Dot, Dot, Dot, Dot, Dot, Space]
asciiToMorse '6' = [Dash, Dot, Dot, Dot, Dot, Space]
asciiToMorse '7' = [Dash, Dash, Dot, Dot, Dot, Space]
asciiToMorse '8' = [Dash, Dash, Dash, Dot, Dot, Space]
asciiToMorse '9' = [Dash, Dash, Dash, Dash, Dot, Space]
asciiToMorse '0' = [Dash, Dash, Dash, Dash, Dash, Space]
asciiToMorse ' ' = [Space]
asciiToMorse _ = []

-- morseDecoder ::
--   forall dom .
--   (KnownDomain dom) =>
--   Clock dom ->
--   Reset dom ->
--   Enable dom ->
--   Signal dom (Maybe MorseCode) ->
--   _ -- Result type depends on your implementations
-- morseDecoder = _ -- Implements the morse decoder

-- morseResultToChar :: _ -- Type depends on your implementation
-- morseResultToChar = _ -- Implement this function based on morse implementation.

morseTestString :: String
morseTestString = "HELLO WORLD ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789"

morseDecoderTestPattern :: [Maybe MorseCode]
morseDecoderTestPattern = Nothing : L.concatMap (fmap Just . asciiToMorse) morseTestString

-- morseDecoderTest :: _ -- Type depends on your implementation
-- morseDecoderTest = sampleN (L.length morseDecoderTestPattern) $
--   morseDecoder systemClockGen resetGen enableGen $ fromList morseDecoderTestPattern

-- -- | A function that converts your custom representation of a character to `Maybe Char`
-- -- Implement this function based on your morse implementation to be able to use the `resultingString` definition.
-- morseStateToChar :: _ -> Maybe Char
-- morseStateToChar morseState = _

-- -- | This should be the same as `morseTestString`
-- resultingString :: String
-- resultingString = mapMaybe morseStateToChar (catMaybes morseDecoderTest)
