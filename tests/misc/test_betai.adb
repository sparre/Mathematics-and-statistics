------------------------------------------------------------------------------
--
--  procedure Test_Betai (body)
--
--  Testing the generic procedure Generic_Betai.
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

with Ada.Characters.Latin_1;
with Ada.Numerics.Generic_Elementary_Functions;
with Ada.Text_IO;

------------------------------------------------------------------------------
--  Numerical Recipes packages:

with Generic_Betacf;
with Generic_Betai;
with Generic_Gammln;

------------------------------------------------------------------------------

procedure Test_Betai is

   ---------------------------------------------------------------------------

   type Scalar is digits 15;

   ---------------------------------------------------------------------------

   package Scalar_Text_IO is
     new Ada.Text_IO.Float_IO (Scalar);

   ---------------------------------------------------------------------------

   package Elementary_Functions is
     new Ada.Numerics.Generic_Elementary_Functions (Scalar);

   ---------------------------------------------------------------------------

   function Gammln is
     new Generic_Gammln (Scalar               => Scalar,
                         Elementary_Functions => Elementary_Functions);

   ---------------------------------------------------------------------------

   function Betacf is
     new Generic_Betacf (Scalar => Scalar);

   ---------------------------------------------------------------------------

   function Betai is
     new Generic_Betai (Scalar               => Scalar,
                        Betacf               => Betacf,
                        Gammln               => Gammln,
                        Elementary_Functions => Elementary_Functions);

   ---------------------------------------------------------------------------

   use Ada.Text_IO;
   use Scalar_Text_IO;

   Test, Df : Scalar;

begin
   for Test_Index in 0 .. 1_000 loop
      Test := Scalar (Test_Index) / 1_000.0;

      Put (Item => Test);

      for Degrees_Of_Freedom in 1 .. 5 loop
         Df := Scalar (Degrees_Of_Freedom);

         Put (Item => Ada.Characters.Latin_1.HT);
         Put (Item => Betai (A => 0.5 * Df,
                             B => 0.5,
                             X => Df / (Df + Test ** 2)));
      end loop;

      New_Line;
   end loop;
end Test_Betai;
