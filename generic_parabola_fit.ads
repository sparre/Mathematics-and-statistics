------------------------------------------------------------------------------
--
--  generic package Generic_Parabola_Fit (spec)
--
------------------------------------------------------------------------------
--  Update log:
--
--  2000.10.26 (Jacob Sparre Andersen)
--    Written.
--
------------------------------------------------------------------------------
--  Math packages:

with Generic_Matrices;

------------------------------------------------------------------------------

generic

   type Scalar is digits <>;

   Half_Window : Positive;
   Delta_X     : Scalar;

   with package Matrices is new Generic_Matrices (Scalar => Scalar);

package Generic_Parabola_Fit is

   Window_Width : constant Positive := 2 * Half_Window + 1;

   type Data_Array is array (-Half_Window .. +Half_Window) of Scalar;

   type Weight_Array is array (0 .. 2) of Scalar;

   function Fit (Data : in Data_Array) return Weight_Array;

   ---------------------------------------------------------------------------

private

   ---------------------------------------------------------------------------
   --  Weight_Matrix:
   --
   --  A data array is multiplied by the weight matrix to give the array of
   --  weights for the three elements of the parabola, that gives the best
   --  fit.

   Weight_Matrix : Matrices.Matrix (3, Window_Width);

   ---------------------------------------------------------------------------

end Generic_Parabola_Fit;
