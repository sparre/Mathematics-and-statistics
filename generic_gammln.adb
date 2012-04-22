------------------------------------------------------------------------------
--
--  function Generic_Gammln (body)
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

function Generic_Gammln (XX : Scalar) return Scalar is
   use Elementary_Functions;
   X, Tmp, Ser : Scalar;
   Cof         : constant array (0 .. 5) of Scalar := (76.18009173,
                                                       -86.50532033,
                                                       24.01409822,
                                                       -1.231739516,
                                                       0.120858003e-2,
                                                       -0.536382e-5);
begin
   X := Xx - 1.0;
   Tmp := X + 5.5;
   Tmp := Tmp - (X + 0.5) * Log (Tmp);
   Ser := 1.0;
   for J in Cof'Range loop
      X := X + 1.0;
      Ser := Ser + Cof (J) / X;
   end loop;
   return - Tmp + Log (2.50662827465*Ser);
end Generic_Gammln;
