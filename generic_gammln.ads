------------------------------------------------------------------------------
--
--  function Generic_Gammln (spec)
--
--  Calculating the logarithm of the gamma function - based on the
--  example code on page 168 in "Numerical Recipes in C".
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

   with package Elementary_Functions is
     new Ada.Numerics.Generic_Elementary_Functions (Scalar);

function Generic_Gammln (XX : Scalar) return Scalar;
