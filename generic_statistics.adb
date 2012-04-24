------------------------------------------------------------------------------
--
--  package Generic_Statistics (body)
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
--  2000.08.31 (Jacob Sparre Andersen)
--    Experimented with the implementation of function Variance.
--
--  2001.09.04 (Jacob Sparre Andersen)
--    Added procedure Append for collecting two sets of statistics in one.
--
--  2002.03.04 (Jacob Sparre Andersen)
--    Uses Not_Enough_Data_Points for improved exception reporting.
--
--  2012.04.24 (Jacob Sparre Andersen)
--    Removed superfluous comments and exception handlers.
--
--  (Insert additional update information above this line.)
------------------------------------------------------------------------------

package body Generic_Statistics is

   ---------------------------------------------------------------------------
   --  procedure Append_Value:
   --
   --  Exceptions:
   --    Constraint_Error - when the number of data points exceeds the
   --                       declared limit.

   procedure Append_Value (Target : in out Object;
                           Value  : in     Data) is
   begin
      Target :=
        (Count               => Target.Count + 1,
         Sum_Of_Data         => Target.Sum_Of_Data + Value,
         Sum_Of_Squared_Data => Target.Sum_Of_Squared_Data + Squared (Value));
   end Append_Value;

   ---------------------------------------------------------------------------
   --  procedure Remove_Value:
   --
   --  Exceptions:
   --    Constraint_Error - when the number of data points is 0.

   procedure Remove_Value (Target : in out Object;
                           Value  : in     Data) is
   begin
      if Target.Count < 1 then
         raise Not_Enough_Data_Points;
      else
         Target :=
           (Count               => Target.Count - 1,
            Sum_Of_Data         => Target.Sum_Of_Data - Value,
            Sum_Of_Squared_Data => Target.Sum_Of_Squared_Data - Squared (Value));
      end if;
   end Remove_Value;

   ---------------------------------------------------------------------------
   --  procedure Append:
   --
   --  Exceptions:
   --    Constraint_Error - when the number of data points exceeds the
   --                       declared limit.

   procedure Append (Target : in out Object;
                     Source : in     Object) is
   begin
      Target := (Count               => Target.Count +
                                        Source.Count,
                 Sum_Of_Data         => Target.Sum_Of_Data +
                                        Source.Sum_Of_Data,
                 Sum_Of_Squared_Data => Target.Sum_Of_Squared_Data +
                                        Source.Sum_Of_Squared_Data);
   end Append;

   ---------------------------------------------------------------------------
   --  function Mean:

   function Mean (Item : in     Object) return Data is
      pragma Inline (Mean);
   begin
      if Item.Count < 1 then
         raise Not_Enough_Data_Points;
      else
         return Item.Sum_Of_Data / Item.Count;
      end if;
   end Mean;

   ---------------------------------------------------------------------------
   --  function Variance:

   function Variance (Item : in     Object) return Squared_Data is
      pragma Inline (Variance);
   begin
      if Item.Count < 2 then
         raise Not_Enough_Data_Points;
      else
         return
           (Item.Count * Item.Sum_Of_Squared_Data - Squared (Item.Sum_Of_Data))
             / (Item.Count * (Item.Count - 1));
      end if;
   end Variance;

   ---------------------------------------------------------------------------
   --  function Standard_Deviation:

   function Standard_Deviation (Item : in     Object) return Data is
      pragma Inline (Standard_Deviation);
   begin
      return Square_Root (Variance (Item));
   end Standard_Deviation;

   ---------------------------------------------------------------------------
   --  function Number_Of_Values:

   function Number_Of_Values (Item : in     Object) return Count_Range is
      pragma Inline (Number_Of_Values);
   begin
      return Item.Count;
   end Number_Of_Values;

   ---------------------------------------------------------------------------

end Generic_Statistics;
