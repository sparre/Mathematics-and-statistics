with
  Ada.Numerics.Elementary_Functions,
  Ada.Numerics.Float_Random;

package body Random_Numbers is

   ---------------------------------------------------------------------------
   --  Constants:

   Nrand : constant Natural := 4;
   Arand : constant Float := 1.0;

   GaussAdd : constant Float :=
                Ada.Numerics.Elementary_Functions.Sqrt (Float (3 * Nrand));
   GaussFac : constant Float := 2.0 * GaussAdd / (Float (Nrand) * Arand);

   ---------------------------------------------------------------------------
   --  Random number generator:

   Uniform_Distribution  : Ada.Numerics.Float_Random.Generator;

   ---------------------------------------------------------------------------

   function Gauss return Float is
      use Ada.Numerics.Float_Random;

      Sum : Float := 0.0;
   begin
      for i in 1 .. Nrand loop
         Sum := Sum + Uniform;
      end loop;

      return GaussFac * Sum - GaussAdd;
   end Gauss;

   procedure Reset is
      use Ada.Numerics.Float_Random;
   begin
      Reset (Uniform_Distribution);
   end Reset;

   function Uniform return Float is
      use Ada.Numerics.Float_Random;
   begin
      return Random (Uniform_Distribution);
   end Uniform;

end Random_Numbers;
