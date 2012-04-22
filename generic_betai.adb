------------------------------------------------------------------------------
--
--  function Generic_Betai (body)
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

function Generic_Betai (A, B, X : Scalar) return Scalar is
   use Elementary_Functions;
   Bt : Scalar;
begin
   if X < 0.0 or X > 1.0 then
      raise Constraint_Error;
   end if;

   if X = 0.0 or X = 1.0 then
      Bt := 0.0;
   else
      Bt := Exp (+ Gammln (A + B)
                 - Gammln (A)
                 - Gammln (B)
                 + A * Log (X)
                 + B * Log (1.0 - X));
   end if;

   if X < (A + 1.0) / (A + B + 2.0) then
      return Bt * Betacf (A, B, X) / A;
   else
      return 1.0 - Bt * Betacf (B, A, 1.0 - X) / B;
   end if;
end Generic_Betai;
