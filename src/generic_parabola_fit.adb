------------------------------------------------------------------------------
--
--  generic package Generic_Parabola_Fit (body)
--
------------------------------------------------------------------------------
--  Update log:
--
--  2000.10.26 (Jacob Sparre Andersen)
--    Written.
--
------------------------------------------------------------------------------
--  Standard packages:

with Ada.Text_IO;

------------------------------------------------------------------------------
--  Math (packages and) procedures:

with Generic_Gauss_Jordan;

------------------------------------------------------------------------------

package body Generic_Parabola_Fit is

   procedure Gauss_Jordan is new Generic_Gauss_Jordan (Scalar   => Scalar,
                                                       Matrices => Matrices);

   function Fit (Data : in Data_Array) return Weight_Array is

      use Matrices;

      Data_Matrix : Matrix (Window_Width, 1);
      Buffer      : Matrix (3, 1);

   begin --  Fit
      for Index in Data'Range loop
         Set (Data_Matrix,
              Index + Half_Window + 1, 1,
              Data (Index));
      end loop;

      Buffer := Weight_Matrix * Data_Matrix;

      return (0 => Element (Buffer, 1, 1),
              1 => Element (Buffer, 2, 1),
              2 => Element (Buffer, 3, 1));
   end Fit;

   use Matrices;

   A             : Matrix (Window_Width, 3);
   A_T           : Matrix (3, Window_Width);
   Alpha         : Matrix (3, 3);
   Inverse_Alpha : Matrix (3, 3);
   Dummy_Vector  : Matrix (3, 1);

begin
   for i in 1 .. Height (A) loop
      for j in 1 .. Width (A) loop
         Set (A, i, j, (Delta_X * Scalar (i - Half_Window)) ** (j - 1));
      end loop;
   end loop;

   A_T := Transpose (A);

   Alpha := A_T * A;

   Inverse_Alpha := Alpha;
   Set (Dummy_Vector, 1, 1, 1.0);
   Set (Dummy_Vector, 2, 1, 0.5);
   Set (Dummy_Vector, 3, 1, 1.5);
   Gauss_Jordan (Inverse_Alpha, Dummy_Vector);

   Weight_Matrix := Inverse_Alpha * A_T;
exception
   when others =>
      Ada.Text_IO.Put_Line ("Error initialising Generic_Parabola_Fit");
      raise;
end Generic_Parabola_Fit;
