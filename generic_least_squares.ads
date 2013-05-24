------------------------------------------------------------------------------
--
--  package Generic_Least_Squares (spec)
--
------------------------------------------------------------------------------
--  Update information:
--
--  2000.10.02 (Jacob Sparre Andersen)
--    Written.
--
--  (Insert additional update information above this line.)
------------------------------------------------------------------------------
--  Other packages:

with Generic_Gauss_Jordan;
with Generic_Matrices;

------------------------------------------------------------------------------

generic

   type Scalar is digits <>;

   with package Matrices is new Generic_Matrices (Scalar => Scalar);

package Generic_Least_Squares is

   ---------------------------------------------------------------------------
   --  Simple function:

   type Simple_Function is
     access function (Variable : in Scalar) return Scalar;

   type Function_Array_Type is array (Positive range <>) of Simple_Function;

   ---------------------------------------------------------------------------
   --  procedure Gauss_Jordan:

   procedure Gauss_Jordan is new Generic_Gauss_Jordan (Scalar   => Scalar,
                                                       Matrices => Matrices);

   ---------------------------------------------------------------------------

   procedure Fit (x, y    : in     Matrices.Scalar_Array;
                  Basis   : in     Function_Array_Type;
                  Weights :    out Matrices.Scalar_Array);

   ---------------------------------------------------------------------------

end Generic_Least_Squares;
