------------------------------------------------------------------------------
--
--  procedure Generic_Gauss_Jordan (spec)
--
--  Gauss-Jordan elimination implemented as in Numerical Recipes.
--
------------------------------------------------------------------------------
--  Update information:
--
--  2000.10.02 (Jacob Sparre Andersen)
--    Written.
--
--  (Insert additional update information above this line.)
------------------------------------------------------------------------------

with Generic_Matrices;

generic

   type Scalar is digits <>;

   with package Matrices is new Generic_Matrices (Scalar => Scalar);

procedure Generic_Gauss_Jordan (A : in out Matrices.Matrix;
                                B : in out Matrices.Matrix);
