------------------------------------------------------------------------------
--
--  function Generic_Betai (spec)
--
--  Calculating the incomplete beta function - based on the example code on
--  pages 179-180 in "Numerical Recipes in C".
--
------------------------------------------------------------------------------
--  Update information:
--
--  2005.05.16 (Jacob Sparre Andersen)
--    Written.
--
--  (Insert additional update information above this line.)
------------------------------------------------------------------------------
--  Standard packages:

with Ada.Numerics.Generic_Elementary_Functions;

------------------------------------------------------------------------------

generic

   type Scalar is digits <>;

   with function Gammln (X : in Scalar) return Scalar;
   with function Betacf (A, B, X : in Scalar) return Scalar;

   with package Elementary_Functions is
     new Ada.Numerics.Generic_Elementary_Functions (Scalar);

function Generic_Betai (A, B, X : Scalar) return Scalar;
