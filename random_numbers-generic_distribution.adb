with
  Ada.Numerics.Float_Random;

package body Random_Numbers.Generic_Distribution is

   ---------------------------------------------------------------------------
   --  Integrated distribution:

   Integral : array (0 .. Resolution) of Float;

   ---------------------------------------------------------------------------
   --  Table look-up:

   Scale : constant Float := (X_Max - X_Min) / Float (Resolution);

   ---------------------------------------------------------------------------

   function Random return Float is
      use Ada.Numerics.Float_Random;

      Uniform : Float;
   begin
      Uniform := Random_Numbers.Uniform * Integral (Integral'Last);

      for Index in Integral'Range loop
         if Uniform <= Integral (Index) then
            return X_Min + Float (Index) * Scale;
         end if;
      end loop;

      return X_Max;
   end Random;

begin
   Integral (0) := Distribution (X_Min);

   for Index in 1 .. Resolution loop
      Integral (Index) :=
        Integral (Index - 1) + Distribution (X_Min + Float (Index) * Scale);
   end loop;
end Random_Numbers.Generic_Distribution;
