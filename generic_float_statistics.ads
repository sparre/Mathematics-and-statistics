------------------------------------------------------------------------------
--
--  package Generic_Float_Statistics (spec)
--
--  Declares a type for calculating basic statistical properties of an
--  ensemble of floating point data.
--
------------------------------------------------------------------------------
--  Update information:
--
--  1997.03.08 (Jacob Sparre Andersen)
--    Written.
--
--  2012.04.24 (Jacob Sparre Andersen)
--    Added Ada-2005 "overriding" keyword where appropriate.
--
--  (Insert additional update information above this line.)
------------------------------------------------------------------------------

with Generic_Statistics;

generic

   Maximum_Number_Of_Data_Points : Positive;

   type Data is digits <>;

   type Squared_Data is digits <>;

package Generic_Float_Statistics is

   ---------------------------------------------------------------------------
   --  function "/":

   function "/" (Left  : in     Data;
                 Right : in     Positive) return Data;

   ---------------------------------------------------------------------------
   --  function Squared:

   function Squared (Item  : in     Data'Base) return Squared_Data'Base;

   ---------------------------------------------------------------------------
   --  function "*":

   function "*" (Left  : in     Positive;
                 Right : in     Squared_Data) return Squared_Data;

   ---------------------------------------------------------------------------
   --  function Squared_To_Integer:

   function Squared_To_Integer (Left  : in     Squared_Data;
                                Right : in     Positive) return Squared_Data;

   ---------------------------------------------------------------------------
   --  function Square_Root:

   function Square_Root (Item : in Squared_Data'Base) return Data'Base;

   ---------------------------------------------------------------------------
   --  package Statistics:

   package Statistics is new Generic_Statistics
     (Maximum_Number_Of_Data_Points,
      Data,
      Squared_Data,
      0.0,
      "+",
      "-",
      "/",
      Squared,
      "+",
      "-",
      "*",
      Squared_To_Integer,
      Square_Root => Square_Root);

   ---------------------------------------------------------------------------

end Generic_Float_Statistics;
