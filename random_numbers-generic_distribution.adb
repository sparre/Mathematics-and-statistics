------------------------------------------------------------------------------
--
--  generic package Random_Numbers.Generic_Distribution (body)
--
------------------------------------------------------------------------------
--  Update information:
--
--  1998.04.05 (Jacob Sparre Andersen)
--    Written.
--
--  (Insert additional update information above this line.)
------------------------------------------------------------------------------

------------------------------------------------------------------------------
--  Standard packages:

with Ada.Numerics.Float_Random;

------------------------------------------------------------------------------

package body Random_Numbers.Generic_Distribution is

   ---------------------------------------------------------------------------
   --  Integrated distribution:

   Integral : array (0 .. Resolution) of Float;

   ---------------------------------------------------------------------------
   --  Table look-up:

   Scale : constant Float := (X_Max - X_Min) / Float (Resolution);

   ---------------------------------------------------------------------------
   --  procedure Reset:

   procedure Reset is

   begin --  Reset
      Random_Numbers.Reset;
   end Reset;

   ---------------------------------------------------------------------------
   --  function Random:

   function Random return Float is

      use Ada.Numerics.Float_Random;

      Even : Float;

   begin --  Random
      Even := Random_Numbers.Even * Integral (Integral'Last);

      for Index in Integral'Range loop
         if Even <= Integral (Index) then
            return X_Min + Float (Index) * Scale;
         end if;
      end loop;

      return X_Max;
   end Random;

   ---------------------------------------------------------------------------

begin
   Integral (0) := Distribution (X_Min);

   for Index in 1 .. Resolution loop
      Integral (Index) :=
        Integral (Index - 1) + Distribution (X_Min + Float (Index) * Scale);
   end loop;
end Random_Numbers.Generic_Distribution;
