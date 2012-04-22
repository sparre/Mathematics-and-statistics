------------------------------------------------------------------------------
--
--  function Generic_Betacf (spec)
--
--  Calculating the incomplete beta function - based on the example code on
--  pages 180 in "Numerical Recipes in C".
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

------------------------------------------------------------------------------

generic

   type Scalar is digits <>;

   Itmax : Positive := 100;
   EPS   : Scalar := 3.0e-7;

function Generic_Betacf (A, B, X : Scalar) return Scalar;

