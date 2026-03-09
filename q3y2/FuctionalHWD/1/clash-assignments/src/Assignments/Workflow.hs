{-# OPTIONS_GHC -Wno-orphans #-}

-- | Template for the Haskell exercises in 01-Workflow
-- Student name: Ethan Bastian  
-- Student number: 560704
module Assignments.Workflow where

import Clash.Explicit.Prelude

createDomain vSystem{vName="CLK50", vPeriod=hzToPeriod 50e6}

adder ::
  (KnownDomain dom, KnownNat n) => -- Constraints of the circuit
  Clock dom -> -- Clock signal of the circuit
  Reset dom -> -- Reset signal of the circuit
  Enable dom -> -- Enable signal of the circuit
  Signal dom (Unsigned n) -> -- First input signal
  Signal dom (Unsigned n) -> -- Second input signal
  Signal dom (Unsigned n) -- Output signal
adder clk rst ena a b = c
 where
 c = a' + b'
 a' = register clk rst ena 0 a
 b' = register clk rst ena 0 b


topEntity ::
  Clock CLK50 ->
  Signal CLK50 (Unsigned 5, Unsigned 5) ->
  Signal CLK50 (Bool, Bool) ->
  Signal CLK50 (Unsigned 5)
topEntity clk switches buttons = leds
 where
  (a,b) = unbundle switches
  (rst, ena) = unbundle buttons
  leds = adder clk (unsafeFromActiveLow rst) (toEnable $ (not <$> ena)) a b

{-# ANN topEntity
  (Synthesize
    { t_name = "adder"
    , t_inputs =
        [ PortName "MAX10_CLK1_50"
        , PortName "SW"
        , PortName "KEY"
        ]
    , t_output = PortName "LEDR"
    }) #-}
