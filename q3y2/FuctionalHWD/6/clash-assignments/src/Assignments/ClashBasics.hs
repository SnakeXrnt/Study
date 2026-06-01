{-# OPTIONS_GHC -fconstraint-solver-iterations=10 #-}
{-# OPTIONS_GHC -Wno-orphans #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE ViewPatterns #-}
-- | Template for the exercises Basic Clash Circuits.
-- Student name: Ethan Bastian
-- Student number: 560704
module Assignments.ClashBasics where

import Clash.Prelude
import Data.Bits
import Clash.Explicit.Prelude (createDomain)

halfAdder :: Bit -> Bit -> (Bit, Bit)
halfAdder a b = (carry, sum')
  where
    sum'  = xor a b
    carry = a .&. b

fullAdder :: Bit -> Bit -> Bit -> (Bit, Bit)
fullAdder a b cin = (carry, sum')
  where
    (carry1, sum1) = halfAdder a b
    (carry2, sum') = halfAdder sum1 cin
    carry          = carry1 .|. carry2

ripple :: KnownNat n => Unsigned n -> Unsigned n -> Unsigned n
ripple a b = unpack $ v2bv $ snd $ mapAccumR step 0 (zip (bv2v (pack a)) (bv2v (pack b)))
  where
    step c_in (ai, bi) =
      let (c_out, s) = fullAdder ai bi c_in
      in  (c_out, s)

safeAddUnsigned :: (KnownNat n, 1 <= n) => Unsigned n -> Unsigned n -> Unsigned (n + 1)
safeAddUnsigned a b = resize a + resize b

safeSubUnsigned :: (KnownNat n, 1 <= n) => Unsigned n -> Unsigned n -> Signed (n + 1)
safeSubUnsigned a b = fromIntegral a - fromIntegral b

absSigned :: (KnownNat n, 1 <= n) => Signed n -> Unsigned n
absSigned x = if x < 0 then fromIntegral (negate x) else fromIntegral x

myPopCountBv :: (KnownNat n, 1 <= n) => BitVector n -> Unsigned (CLog 2 n + 1)
myPopCountBv bv = foldl (+) 0 (map (\b -> if bitToBool b then 1 else 0) (bv2v bv))

createDomain vSystem{vName="Dom50", vPeriod=20000}

counter
  :: forall dom a
   . (KnownDomain dom, Num a, NFDataX a)
  => Clock dom -> Reset dom -> Enable dom -> Signal dom a
counter clk rst en = withClockResetEnable clk rst en $ mealy step 0 (pure ())
  where
    step s _ = (s + 1, s)

pulseCounter
  :: forall dom a
   . (KnownDomain dom, Num a, NFDataX a)
  => Clock dom -> Reset dom -> Enable dom -> Signal dom Bit -> Signal dom a
pulseCounter clk rst en sig = withClockResetEnable clk rst en $ mealy step (0, low) sig
  where
    step (cnt, prev) curr =
      let cnt' = if prev == high && curr == low then cnt + 1 else cnt
      in  ((cnt', curr), cnt)

pwmSimple
  :: forall dom n
   . (KnownDomain dom, KnownNat n, 1 <= n, NFDataX (Index n))
  => Clock dom -> Reset dom -> Enable dom -> Signal dom (Index n) -> Signal dom Bit
pwmSimple clk rst en duty =
  withClockResetEnable clk rst en $
    let cnt     = register 0 (cnt + 1)
        pwm c d = if c < d then high else low
    in  pwm <$> cnt <*> duty
