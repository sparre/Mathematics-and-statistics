------------------------------------------------------------------------------
--
--  package Generic_Fractions (spec)
--
------------------------------------------------------------------------------
--  Update information:
--
--  1996.10.04 (Jacob Sparre Andersen)
--    Written.
--
--  (Insert additional update information above this line.)
------------------------------------------------------------------------------

generic

   Max : Integer;

package Generic_Fractions is

   ---------------------------------------------------------------------------
   --  type Fraction:

   type Fraction is private;

   ---------------------------------------------------------------------------
   --  Integer subtypes:

   subtype Numerator_Type   is Integer range -Max .. Max;
   subtype Denominator_Type is Integer range    1 .. Max;

   ---------------------------------------------------------------------------
   --  Exceptions:

   Not_An_Integer : exception;

   ---------------------------------------------------------------------------
   --  Arithmetics:

   ------------------------------------------------------------------
   --  function "+":

   function "+" (Left, Right : in Fraction) return Fraction;

   function "+" (Left  : in Fraction;
                 Right : in Integer) return Fraction;

   function "+" (Left  : in Integer;
                 Right : in Fraction) return Fraction;

   ------------------------------------------------------------------
   --  function "-" (binary):

   function "-" (Left, Right : in Fraction) return Fraction;

   function "-" (Left  : in Fraction;
                 Right : in Integer) return Fraction;

   function "-" (Left  : in Integer;
                 Right : in Fraction) return Fraction;

   ------------------------------------------------------------------
   --  function "-" (unary):

   function "-" (Right : in Fraction) return Fraction;

   ------------------------------------------------------------------
   --  function "*":

   function "*" (Left, Right : in Fraction) return Fraction;

   function "*" (Left  : in Fraction;
                 Right : in Integer) return Fraction;

   function "*" (Left  : in Integer;
                 Right : in Fraction) return Fraction;

   ------------------------------------------------------------------
   --  function "/":

   function "/" (Left, Right : in Fraction) return Fraction;

   function "/" (Left  : in Fraction;
                 Right : in Integer) return Fraction;

   function "/" (Left  : in Integer;
                 Right : in Fraction) return Fraction;

   function "/" (Left, Right : in Integer) return Fraction;

   ---------------------------------------------------------------------------
   --  Comparisons:

   ------------------------------------------------------------------
   --  function "=":

   overriding
   function "=" (Left, Right : in Fraction) return Boolean;

   function "=" (Left  : in Fraction;
                 Right : in Integer) return Boolean;

   function "=" (Left  : in Integer;
                 Right : in Fraction) return Boolean;

   ------------------------------------------------------------------
   --  function "<=":

   function "<=" (Left, Right : in Fraction) return Boolean;

   function "<=" (Left  : in Fraction;
                  Right : in Integer) return Boolean;

   function "<=" (Left  : in Integer;
                  Right : in Fraction) return Boolean;

   ------------------------------------------------------------------
   --  function "<":

   function "<" (Left, Right : in Fraction) return Boolean;

   function "<" (Left  : in Fraction;
                 Right : in Integer) return Boolean;

   function "<" (Left  : in Integer;
                 Right : in Fraction) return Boolean;

   ------------------------------------------------------------------
   --  function ">=":

   function ">=" (Left, Right : in Fraction) return Boolean;

   function ">=" (Left  : in Fraction;
                  Right : in Integer) return Boolean;

   function ">=" (Left  : in Integer;
                  Right : in Fraction) return Boolean;

   ------------------------------------------------------------------
   --  function ">":

   function ">" (Left, Right : in Fraction) return Boolean;

   function ">" (Left  : in Fraction;
                 Right : in Integer) return Boolean;

   function ">" (Left  : in Integer;
                 Right : in Fraction) return Boolean;

   ---------------------------------------------------------------------------
   --  Extracting the components of a fraction:

   function Numerator (Item : in Fraction) return Numerator_Type;

   function Denominator (Item : in Fraction) return Denominator_Type;

   function Is_Integer (Item : in Fraction) return Boolean;

   function To_Integer (Item : in Fraction) return Integer;

   ---------------------------------------------------------------------------
   --  function Image:

   function Image (Item : in Fraction) return String;

   ---------------------------------------------------------------------------
   --  function Value:

   function Value (Item : in String) return Fraction;

   ---------------------------------------------------------------------------

private

   ---------------------------------------------------------------------------
   --  type Fraction:

   type Fraction is
      record
         Numerator   : Numerator_Type := 0;
         Denominator : Denominator_Type := 1;
      end record;

   ---------------------------------------------------------------------------

end Generic_Fractions;
