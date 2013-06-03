--  Handling values with limited measurement ranges.

generic

   type Scalar is digits <>;

   type Indices is (<>);

package Generic_Measurement_Values is

   ---------------------------------------------------------------------------
   --  type Limit:

   type Limit is (Below, Exact, Above, Undefined);

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

   function "+" (Left  : in Measurement;
                 Right : in Measurement) return Measurement;

   function "+" (Left  : in Scalar;
                 Right : in Measurement) return Measurement;

   function "+" (Left  : in Measurement;
                 Right : in Scalar) return Measurement;

   function "-" (Left  : in Measurement;
                 Right : in Measurement) return Measurement;

   function "-" (Left  : in Scalar;
                 Right : in Measurement) return Measurement;

   function "-" (Left  : in Measurement;
                 Right : in Scalar) return Measurement;

   Not_An_Exact_Measurement : exception;

   function To_Scalar (Item : in Measurement) return Scalar;

   ---------------------------------------------------------------------------

end Generic_Measurement_Values;
