------------------------------------------------------------------------------
--
--  procedure Test_Students_T_Test (body)
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

with Ada.Integer_Text_IO,
     Ada.Text_IO;

------------------------------------------------------------------------------
--  Numerical Recipes packages:

with Generic_Students_T_Test;

------------------------------------------------------------------------------

procedure Test_Students_T_Test is

   ---------------------------------------------------------------------------

   type Scalar is digits 15;

   type Scalar_Array is array (Positive range <>) of Scalar;

   ---------------------------------------------------------------------------

   package Scalar_Text_IO is
     new Ada.Text_IO.Float_IO (Scalar);

   ---------------------------------------------------------------------------

   package T_Test is
      new Generic_Students_T_Test (Scalar       => Scalar,
                                   Indices      => Positive,
                                   Scalar_Array => Scalar_Array);

   ---------------------------------------------------------------------------

   use Ada.Integer_Text_IO;
   use Ada.Text_IO;
   use Scalar_Text_IO;
   use T_Test;

   Data : constant array (1 .. 5) of Scalar_Array (1 .. 3) :=
            ((0.0, 0.1, -0.1),
             (0.1, 1.1, -0.9),
             (1.0, 0.9,  0.8),
             (0.9, 0.8,  0.7),
             (0.5, 0.7,  0.6));
   P_A_High, P_B_High : Scalar;
   P_Value            : Probability;
   Mean_A, Mean_B     : Scalar;

begin
   for A in Data'Range loop
      for B in A .. Data'Last loop
         Put (Item => "Data (");
         Put (Item => A, Width => 0);
         Put (Item => ") = Data (");
         Put (Item => B, Width => 0);
         Put (Item => "): ");
         Put (Item => P_Equal (Data_1 => Data (A),
                               Data_2 => Data (B)),
              Fore => 1,
              Aft  => 5,
              Exp  => 0);

         Equal (Data_1  => Data (B),
                Data_2  => Data (A),
                Mean_1  => Mean_B,
                Mean_2  => Mean_A,
                P_Value => P_Value);
         Put (Item => " [");
         Put (Item => P_Value,
              Fore => 1,
              Aft  => 5,
              Exp  => 0);
         Put (Item => "]");

         New_Line;
      end loop;
   end loop;

   New_Line;

   for A in Data'Range loop
      for B in Data'Range loop
         High_Low (Data_1 => Data (A),
                   Data_2 => Data (B),
                   P_1_High => P_A_High,
                   P_2_High => P_B_High);

         Put (Item => "Data (");
         Put (Item => A, Width => 0);
         Put (Item => ") > Data (");
         Put (Item => B, Width => 0);
         Put (Item => "): ");
         Put (Item => P_A_High,
              Fore => 1,
              Aft  => 5,
              Exp  => 0);
         New_Line;
      end loop;
   end loop;

   New_Line;

   for A in Data'Range loop
      Put (Item => "Data (");
      Put (Item => A, Width => 0);
      Put (Item => ") = 0.5: ");
      Put (Item => P_Equal (Data_1 => Data (A),
                            Data_2 => 0.5),
           Fore => 1,
           Aft  => 5,
           Exp  => 0);
      New_Line;
   end loop;
end Test_Students_T_Test;
