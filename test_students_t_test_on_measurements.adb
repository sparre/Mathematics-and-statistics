------------------------------------------------------------------------------
--
--  procedure Test_Students_T_Test_On_Measurements (body)
--
--  Testing the generic package Generic_Students_T_Test.
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

with Ada.Text_IO;

------------------------------------------------------------------------------
--  Numerical Recipes packages:

with Generic_Measurement_Values;
with Generic_Measurement_Values.Text_IO;
with Generic_Students_T_Test;
with Generic_Students_T_Test.Measurements;

------------------------------------------------------------------------------

procedure Test_Students_T_Test_On_Measurements is

   ---------------------------------------------------------------------------

   type Scalar is digits 15;

   type Scalar_Array is array (Positive range <>) of Scalar;

   ---------------------------------------------------------------------------

   package Scalar_Text_IO is
      new Ada.Text_IO.Float_IO (Scalar);

   ---------------------------------------------------------------------------

   package Measurements is
      new Generic_Measurement_Values (Scalar  => Scalar,
                                      Indices => Positive);

   ---------------------------------------------------------------------------

   subtype Measurement_Array is Measurements.Measurement_Array;

   package Measurement_Text_IO is new Measurements.Text_IO;

   ---------------------------------------------------------------------------

   package T_Test is
      new Generic_Students_T_Test (Scalar       => Scalar,
                                   Indices      => Positive,
                                   Scalar_Array => Scalar_Array);

   ---------------------------------------------------------------------------

   package Measurement_T_Test is
      new T_Test.Measurements (Measurement_Values => Measurements);

   ---------------------------------------------------------------------------

   use Ada.Text_IO;
   use Measurement_T_Test;
   use Measurement_Text_IO;
   use Scalar_Text_IO;
   use T_Test;

   A, B           : Measurement_Array (1 .. 100);
   P_Value        : Probability;
   Mean_A, Mean_B : Scalar;

begin
   Get (Item => B);
   Skip_Line (File => Standard_Input);

   while not End_Of_File (Standard_Input) loop
      A := B;
      Get (Item => B);
      Skip_Line (File => Standard_Input);

      Equal (Data_1  => To_Scalar (A),
             Data_2  => To_Scalar (B),
             Mean_1  => Mean_A,
             Mean_2  => Mean_B,
             P_Value => P_Value);

      Put (Item => "P ([");
      Put (Item => A,
           Fore => 2,
           Aft  => 4,
           Exp  => 0);
      Put (Item => "] = [");
      Put (Item => B,
           Fore => 2,
           Aft  => 4,
           Exp  => 0);
      Put (Item => "]) = ");
      Put (Item => P_Value,
           Fore => 1,
           Aft  => 5,
           Exp  => 0);
      New_Line;
   end loop;
end Test_Students_T_Test_On_Measurements;
