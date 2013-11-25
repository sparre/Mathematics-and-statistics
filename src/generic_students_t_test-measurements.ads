------------------------------------------------------------------------------
--
--  package Generic_Students_T_Test.Measurements (spec)
--
--  Student's t-test on measurements - possibly with missing data-points.
--
------------------------------------------------------------------------------
--  Update information:
--
--  2005.06.20 (Jacob Sparre Andersen)
--    Written.
--
--  2005.06.22 (Jacob Sparre Andersen)
--    The single value version of To_Scalar is renamed from
--      Generic_Measurement_Values.
--
--  (Insert additional update information above this line.)
------------------------------------------------------------------------------
--  Standard packages:

------------------------------------------------------------------------------
--  Other packages:

with Generic_Measurement_Values;

------------------------------------------------------------------------------

generic

   with package Measurement_Values is
     new Generic_Measurement_Values (Scalar  => Scalar,
                                     Indices => Indices);

package Generic_Students_T_Test.Measurements is

   ---------------------------------------------------------------------------

   subtype Measurement is Measurement_Values.Measurement;

   subtype Measurement_Array is Measurement_Values.Measurement_Array;

   ---------------------------------------------------------------------------

   function To_Scalar (Item : in     Measurement) return Scalar
     renames Measurement_Values.To_Scalar;

   ---------------------------------------------------------------------------

   function To_Scalar (Item : in     Measurement_Array) return Scalar_Array;

   ---------------------------------------------------------------------------

end Generic_Students_T_Test.Measurements;
