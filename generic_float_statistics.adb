------------------------------------------------------------------------------
--
--  package Generic_Float_Statistics (body)
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
--  (Insert additional update information above this line.)
------------------------------------------------------------------------------

with Ada.Numerics.Generic_Elementary_Functions;

package body Generic_Float_Statistics is

   ---------------------------------------------------------------------------
   --  package Elementary_Functions:

   package Elementary_Functions is
     new Ada.Numerics.Generic_Elementary_Functions
       (Float_Type => Squared_Data);

   ---------------------------------------------------------------------------
   --  function "/":

   function "/" (Left  : in     Data;
                 Right : in     Positive) return Data is

   begin --  "/"
      return Left / Data (Right);
   end "/";

   ---------------------------------------------------------------------------
   --  function Squared:

   function Squared (Item  : in     Data'Base) return Squared_Data'Base is

   begin --  Squared
      return Squared_Data (Item) ** 2;
   end Squared;

   ---------------------------------------------------------------------------
   --  function "*":

   function "*" (Left  : in     Positive;
                 Right : in     Squared_Data) return Squared_Data is

   begin --  "*"
      return Squared_Data (Left) * Right;
   end "*";

   ---------------------------------------------------------------------------
   --  function Squared_To_Integer:

   function Squared_To_Integer (Left  : in     Squared_Data;
                                Right : in     Positive)
     return Squared_Data is

   begin --  Squared_To_Integer
      return Left / Squared_Data (Right);
   end Squared_To_Integer;

   ---------------------------------------------------------------------------
   --  function Square_Root:

   function Square_Root (Item : in Squared_Data'Base) return Data'Base is

      use Elementary_Functions;

   begin
      return Data'Base (Sqrt (Item));
   end Square_Root;

   ---------------------------------------------------------------------------

end Generic_Float_Statistics;
