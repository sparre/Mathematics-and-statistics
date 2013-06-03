------------------------------------------------------------------------------
--
--  procedure Test_Matrices (body)
--
--  Intended to test package Generic_Matrices.
--
------------------------------------------------------------------------------
--  Update information:
--
--  2000.09.25 (Jacob Sparre Andersen)
--    Written.
--
--  2000.10.02 (Jacob Sparre Andersen)
--    Extended with testing of procedure Generic_Matrices.Set and procedure
--      Generic_Gauss_Jordan.
--
--  (Insert additional update information above this line.)
------------------------------------------------------------------------------
--  Standard packages:

with Ada.Characters.Latin_1,
     Ada.Float_Text_IO,
     Ada.Strings.Unbounded,
     Ada.Strings.Unbounded.Text_IO,
     Ada.Text_IO;

------------------------------------------------------------------------------
--  Other packages:

with Float_Polynomial_Basis,
     Generic_Gauss_Jordan,
     Generic_Least_Squares,
     Generic_Matrices,
     Generic_Parabola_Fit;

------------------------------------------------------------------------------

procedure Test_Matrices is

   ---------------------------------------------------------------------------
   --  package Latin_1:

   package Latin_1 renames Ada.Characters.Latin_1;

   ---------------------------------------------------------------------------

   procedure Search_And_Replace
     (Source     : in out Ada.Strings.Unbounded.Unbounded_String;
      Pattern    : in     String;
      Replace_By : in     String);

   procedure Search_And_Replace
     (Source     : in out Ada.Strings.Unbounded.Unbounded_String;
      Pattern    : in     String;
      Replace_By : in     String) is
      Location   : Natural;
   begin --  Search_And_Replace
      loop
         Location := Ada.Strings.Unbounded.Index (Source  => Source,
                                                  Pattern => Pattern);

         exit when Location = 0;

         Ada.Strings.Unbounded.Replace_Slice
           (Source => Source,
            Low    => Location,
            High   => Location - 1 + Pattern'Length,
            By     => Replace_By);
      end loop;
   end Search_And_Replace;

   ---------------------------------------------------------------------------
   --  package Matrices:

   package Matrices is new Generic_Matrices (Scalar => Float);

   use Matrices;

   ---------------------------------------------------------------------------
   --  procedure Gauss_Jordan:

   procedure Gauss_Jordan is new Generic_Gauss_Jordan (Scalar   => Float,
                                                       Matrices => Matrices);

   ---------------------------------------------------------------------------
   --  package Least_Squares:

   package Least_Squares is new Generic_Least_Squares (Scalar   => Float,
                                                       Matrices => Matrices);
   use Least_Squares;

   ---------------------------------------------------------------------------
   --  package Parabola_Fit:

   package Parabola_Fit is new Generic_Parabola_Fit (Scalar      => Float,
                                                     Half_Window => 3,
                                                     Delta_X     => 0.040,
                                                     Matrices    => Matrices);

   ---------------------------------------------------------------------------
   --  procedure Put_Line:

   procedure Put_Line (Item : in     Matrix);

   procedure Put_Line (Item : in     Matrix) is
      use Ada.Strings.Unbounded;

      Buffer : Unbounded_String := To_Unbounded_String (Image (Item));

   begin --  Put_Line
      Search_And_Replace (Source     => Buffer,
                          Pattern    => "; (",
                          Replace_By => ";" & Latin_1.LF & " (");
      Ada.Strings.Unbounded.Text_IO.Put_Line (Buffer);
   end Put_Line;

   ---------------------------------------------------------------------------
   --  Unit matrix:

   Unit_Matrix : constant Matrix := To_Row ((1.0, 0.0, 0.0)) &
                                    To_Row ((0.0, 1.0, 0.0)) &
                                    To_Row ((0.0, 0.0, 1.0));

   A :          Matrix := To_Row ((+1.0,  2.0,  3.0)) &
                          To_Row ((+4.0,  5.0, -1.0)) &
                          To_Row ((-2.0, -3.0, -4.0));

   B : constant Matrix := To_Row ((+1.0, -1.0,  2.0)) &
                          To_Row ((-1.0,  1.0, -1.0)) &
                          To_Row ((+1.0, -1.0,  1.0));

   C :          Matrix (3, 1);

   ---------------------------------------------------------------------------

   use Ada.Strings.Unbounded, Ada.Text_IO;

begin --  Test_Matrices
   Put_Line ("1 = ");
   Put_Line (Unit_Matrix);
   Put_Line ("A = ");
   Put_Line (A);
   Put_Line ("B = ");
   Put_Line (B);
   New_Line;
   Put_Line ("1 * 1 = ");
   Put_Line (Unit_Matrix * Unit_Matrix);
   Put_Line ("1 * A = ");
   Put_Line (Unit_Matrix * A);
   Put_Line ("1 * B = ");
   Put_Line (Unit_Matrix * B);
   New_Line;
   Put_Line ("A * B = ");
   Put_Line (A * B);
   Put_Line ("B * A = ");
   Put_Line (B * A);

   Set (A, 3, 3, 0.0);
   Put_Line ("A (with 3;3=0.0) = ");
   Put_Line (A);

   ---------------------------------------------------------------------------

   New_Line;
   Put_Line ("Attempts to solve A*x=b");
   New_Line;

   A := Unit_Matrix;
   Set (A, 3, 1, -1.0);

   Set (C, 1, 1, 1.0);
   Set (C, 2, 1, 2.0);
   Set (C, 3, 1, 0.0);

   Put_Line ("A =");
   Put_Line (A);
   Put_Line ("b = ");
   Put_Line (C);

   New_Line;
   Gauss_Jordan (A, C);

   Put_Line ("x = ");
   Put_Line (C);

   Put_Line ("A^{-1} = ");
   Put_Line (A);

   ---------------------------------------------------------------------------
   --  Parabola fit:

   declare
      use Ada.Float_Text_IO;
      use Parabola_Fit;

      Weights : Weight_Array;
      Data    : Data_Array;

   begin
      Data := (others => 0.0);

      while Data (Data'Last) /= -1.0 loop
         Data (Data'First .. Data'Last - 1) :=
           Data (Data'First + 1 .. Data'Last);

         Get (Data (Data'Last));
         Skip_Line;

         Weights := Fit (Data);

         Put (Data (0));
         Put ("   x = ");
         Put (Weights (0));
         Put ("   v = ");
         Put (Weights (1));
         Put ("   a = ");
         Put (2.0 * Weights (2));
         New_Line;
      end loop;
   end;

   ---------------------------------------------------------------------------
   --  Least squares:

   declare
      use Ada.Float_Text_IO;
      use Float_Polynomial_Basis;

      x : Scalar_Array (1 .. 4) := (0.0, 1.1, 1.9, 3.1);
      y : Scalar_Array (1 .. 4) := (0.1, 1.0, 3.9, 9.2);

      Basis   : constant Function_Array_Type (1 .. 3)
                  := (Order_0'Access, Order_1'Access, Order_2'Access);
      Weights : Scalar_Array (1 .. 3);

   begin
      Fit (x, y, Basis, Weights);

      Put (Item => Weights (1),
           Fore => 0,
           Aft  => 4,
           Exp  => 0);
      Put (Item => " + ");
      Put (Item => Weights (2),
           Fore => 0,
           Aft  => 4,
           Exp  => 0);
      Put (Item => " * x + ");
      Put (Item => Weights (3),
           Fore => 0,
           Aft  => 4,
           Exp  => 0);
      Put_Line (Item => " * x^2");

      for Index in x'Range loop
         Get (x (Index));
         Get (y (Index));
         Skip_Line;
      end loop;

      Fit (x, y, Basis, Weights);

      Put (Item => "x(t) = ");
      Put (Item => Weights (1),
           Fore => 0,
           Aft  => 4,
           Exp  => 0);
      Put (Item => " + ");
      Put (Item => Weights (2),
           Fore => 0,
           Aft  => 4,
           Exp  => 0);
      Put (Item => " * t + ");
      Put (Item => Weights (3),
           Fore => 0,
           Aft  => 4,
           Exp  => 0);
      Put_Line (Item => " * t^2");

      Put (Item => "v(t) = ");
      Put (Item => Weights (2),
           Fore => 0,
           Aft  => 4,
           Exp  => 0);
      Put (Item => " + ");
      Put (Item => 2.0 * Weights (3),
           Fore => 0,
           Aft  => 4,
           Exp  => 0);
      Put_Line (Item => " * t");

      Put (Item => "a(t) = ");
      Put (Item => 2.0 * Weights (3),
           Fore => 0,
           Aft  => 4,
           Exp  => 0);
      New_Line;
   end;

   ---------------------------------------------------------------------------

end Test_Matrices;
