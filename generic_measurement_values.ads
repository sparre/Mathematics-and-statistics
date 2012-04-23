------------------------------------------------------------------------------
--
--  package Generic_Measurement_Values (spec)
--
--  Package for handling values with limited measurement ranges.
--
------------------------------------------------------------------------------
--  Update information:
--
--  2004.07.11 (Jacob Sparre Andersen)
--    Written.
--
--  2004.07.16 (Jacob Sparre Andersen)
--    Added the posibility that measurements are undefined.
--
--  2005.06.22 (Jacob Sparre Andersen)
--    Added a Measurement_Array type.
--
--  (Insert additional update information above this line.)
------------------------------------------------------------------------------
--  Standard packages:

------------------------------------------------------------------------------
--  Other packages:

------------------------------------------------------------------------------

generic

   type Scalar is digits <>;

   type Indices is (<>);

package Generic_Measurement_Values is

   ---------------------------------------------------------------------------
   --  type Limit:

   type Limit is (Below, Exact, Above, Undefined);

   ---------------------------------------------------------------------------
   --  function "-":

   function "-" (Right : in Limit) return Limit;

   ---------------------------------------------------------------------------
   --  type Measurement:

   type Measurement (As : Limit := Exact) is
      record
         case As is
            when Below | Exact | Above =>
               Value : Scalar;
            when Undefined =>
               null;
         end case;
      end record;

   type Measurement_Array is array (Indices range <>) of Measurement;

   ---------------------------------------------------------------------------
   --  function "+":

   function "+" (Left  : in Measurement;
                 Right : in Measurement) return Measurement;

   ---------------------------------------------------------------------------
   --  function "+":

   function "+" (Left  : in Scalar;
                 Right : in Measurement) return Measurement;

   ---------------------------------------------------------------------------
   --  function "+":

   function "+" (Left  : in Measurement;
                 Right : in Scalar) return Measurement;

   ---------------------------------------------------------------------------
   --  function "-":

   function "-" (Left  : in Measurement;
                 Right : in Measurement) return Measurement;

   ---------------------------------------------------------------------------
   --  function "-":

   function "-" (Left  : in Scalar;
                 Right : in Measurement) return Measurement;

   ---------------------------------------------------------------------------
   --  function "-":

   function "-" (Left  : in Measurement;
                 Right : in Scalar) return Measurement;

   ---------------------------------------------------------------------------
   --  function To_Scalar:

   Not_An_Exact_Measurement : exception;

   function To_Scalar (Item : in Measurement) return Scalar;

   ---------------------------------------------------------------------------

end Generic_Measurement_Values;
