------------------------------------------------------------------------------
--
--  generic package Generic_Surface_Interpolation (spec)
--
--  Routines for interpolating a surface based on (a few) fixed points.
--
------------------------------------------------------------------------------
--  Maintenance log:
--
--  2000.03.13 (Jacob Sparre Andersen)
--    Written.
--
------------------------------------------------------------------------------
--  Math packages:

with Generic_Rectangular_Vectors;

------------------------------------------------------------------------------

generic

   type Scalar_Type is  digits <>;

   with package Vectors_2D is
      new Generic_Rectangular_Vectors (Dimensions => 2,
                                       Scalar     => Scalar_Type);

   with package Vectors_3D is
      new Generic_Rectangular_Vectors (Dimensions => 3,
                                       Scalar     => Scalar_Type);

package Generic_Surface_Interpolation is

   subtype Scalar   is Scalar_Type;
   subtype Point_2D is Vectors_2D.Point;
   subtype Point_3D is Vectors_3D.Point;

   type Point_Array is array (Positive range <>) of Point_3D;
   type Height_Field_Type is array (Integer range <>, Integer range <>)
     of Scalar;

   procedure Interpolate (Points       : in     Point_Array;
                          Min, Max     : in     Point_2D;
                          Height_Field :    out Height_Field_Type);

end Generic_Surface_Interpolation;
