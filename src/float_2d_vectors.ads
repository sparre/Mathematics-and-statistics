------------------------------------------------------------------------------
--
--  package Float_2D_Vectors (spec)
--
--  An instantiation of Generic_Rectangular_Vectors for two-dimensional
--  vectors using Float as the basic scalar type.
--
------------------------------------------------------------------------------
--  Update information:
--
--  1997.05.27 (Jacob Sparre Andersen)
--    Written.
--
--  (Insert additional update information above this line.)
------------------------------------------------------------------------------

with Generic_Rectangular_Vectors;

package Float_2D_Vectors is
  new Generic_Rectangular_Vectors (Scalar     => Float,
                                   Dimensions => 2);
