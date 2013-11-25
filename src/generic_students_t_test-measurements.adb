------------------------------------------------------------------------------
--
--  package Generic_Students_T_Test.Measurements (body)
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

package body Generic_Students_T_Test.Measurements is

   ---------------------------------------------------------------------------

   function To_Scalar (Item : in     Measurement_Array) return Scalar_Array is
      use Measurement_Values;
      Buffer : Scalar_Array (Item'Range);
      Last   : Indices'Base := Indices'Base'Pred (Item'First);
   begin
      for Index in Item'Range loop
         if Item (Index).As = Exact then
            Last := Indices'Succ (Last);
            Buffer (Last) := Item (Index).Value;
         end if;
      end loop;
      return Buffer (Buffer'First .. Last);
   end To_Scalar;

   ---------------------------------------------------------------------------

end Generic_Students_T_Test.Measurements;
