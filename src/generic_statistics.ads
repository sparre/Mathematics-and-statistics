------------------------------------------------------------------------------
--
--  package Generic_Statistics (spec)
--
--  Declares a type for calculating basic statistical properties of an
--  ensemble of data.
--
------------------------------------------------------------------------------
--  Update information:
--
--  1997.03.08 (Jacob Sparre Andersen)
--    Written. Based on Function.TStatistics (Borland Pascal object type dated
--      1994.03.24-1995.06.02).
--
--  1999.04.12 (Jacob Sparre Andersen)
--    Added function Standard_Deviation.
--
--  2001.09.04 (Jacob Sparre Andersen)
--    Added procedure Append for collecting two sets of statistics in one.
--
--  2002.03.04 (Jacob Sparre Andersen)
--    Added the exception Not_Enough_Data_Points.
--
--  (Insert additional update information above this line.)
------------------------------------------------------------------------------

generic

   Maximum_Number_Of_Data_Points : Positive;

   type Data is private;

   type Squared_Data is private;

   Zero : Data;

   with function "+" (Left, Right : in     Data) return Data;

   with function "-" (Left, Right : in     Data) return Data;

   with function "/" (Left  : in     Data;
                      Right : in     Positive) return Data;

   with function Squared (Item : in     Data) return Squared_Data;

   with function "+" (Left, Right : in     Squared_Data) return Squared_Data;

   with function "-" (Left, Right : in     Squared_Data) return Squared_Data;

   with function "*" (Left  : in     Positive;
                      Right : in     Squared_Data) return Squared_Data;

   with function "/" (Left  : in     Squared_Data;
                      Right : in     Positive) return Squared_Data;

   with function Square_Root (Item : in Squared_Data) return Data;

package Generic_Statistics is

   type Object is private;

   Null_Object : constant Object;

   subtype Count_Range is Natural range 0 .. Maximum_Number_Of_Data_Points;

   Not_Enough_Data_Points : exception;

   procedure Append_Value (Target : in out Object;
                           Value  : in     Data);
   --  Exceptions:
   --    Constraint_Error - when the number of data points exceeds the
   --                       declared limit.

   procedure Remove_Value (Target : in out Object;
                           Value  : in     Data);
   --  Exceptions:
   --    Constraint_Error - when the number of data points is 0.

   procedure Append (Target : in out Object;
                     Source : in     Object);
   --  Exceptions:
   --    Constraint_Error - when the number of data points exceeds the
   --                       declared limit.

   function Mean (Item : in     Object) return Data;

   function Variance (Item : in     Object) return Squared_Data;

   function Standard_Deviation (Item : in     Object) return Data;

   function Number_Of_Values (Item : in     Object) return Count_Range;

private

   type Object is
      record
         Count               : Count_Range := 0;
         Sum_Of_Data         : Data := Zero;
         Sum_Of_Squared_Data : Squared_Data := Squared (Zero);
      end record;

   Null_Object : constant Object := (Count               => 0,
                                     Sum_Of_Data         => Zero,
                                     Sum_Of_Squared_Data => Squared (Zero));

end Generic_Statistics;
