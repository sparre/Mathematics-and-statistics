------------------------------------------------------------------------------
--
--  package Generic_Fractions (body)
--
------------------------------------------------------------------------------
--  Update information:
--
--  1996.10.04 (Jacob Sparre Andersen)
--    Written.
--
--  (Insert additional update information above this line.)
------------------------------------------------------------------------------

with Ada.Strings.Fixed;

package body Generic_Fractions is

   function Greatest_Common_Divisor (A, B : in Positive) return Positive;

   function Reduce (Numerator, Denominator : in Integer) return Fraction;

   ---------------------------------------------------------------------------

   function "*" (Left, Right : in Fraction) return Fraction is
   begin
      return Reduce (Numerator   => Left.Numerator * Right.Numerator,
                     Denominator => Left.Denominator * Right.Denominator);
   end "*";

   function "*" (Left  : in Fraction;
                 Right : in Integer) return Fraction is
   begin
      return Reduce (Numerator   => Left.Numerator * Right,
                     Denominator => Left.Denominator);
   end "*";

   function "*" (Left  : in Integer;
                 Right : in Fraction) return Fraction is
   begin
      return Reduce (Numerator   => Left * Right.Numerator,
                     Denominator => Right.Denominator);
   end "*";

   function "+" (Left, Right : in Fraction) return Fraction is
   begin
      return Reduce (Numerator   => Left.Numerator * Right.Denominator +
                                    Right.Numerator * Left.Denominator,
                     Denominator => Left.Denominator * Right.Denominator);
   end "+";

   function "+" (Left  : in Fraction;
                 Right : in Integer) return Fraction is
   begin
      return (Numerator   => Left.Numerator + Right * Left.Denominator,
              Denominator => Left.Denominator);
   end "+";

   function "+" (Left  : in Integer;
                 Right : in Fraction) return Fraction is
   begin
      return (Numerator   => Left * Right.Denominator + Right.Numerator,
              Denominator => Right.Denominator);
   end "+";

   function "-" (Left, Right : in Fraction) return Fraction is
   begin
      return Reduce (Numerator   => Left.Numerator * Right.Denominator -
                                    Right.Numerator * Left.Denominator,
                     Denominator => Left.Denominator * Right.Denominator);
   end "-";

   function "-" (Left  : in Fraction;
                 Right : in Integer) return Fraction is
   begin
      return (Numerator   => Left.Numerator - Right * Left.Denominator,
              Denominator => Left.Denominator);
   end "-";

   function "-" (Left  : in Integer;
                 Right : in Fraction) return Fraction is
   begin
      return (Numerator   => Left * Right.Denominator + Right.Numerator,
              Denominator => Right.Denominator);
   end "-";

   function "-" (Right : in Fraction) return Fraction is

   begin
      return (Numerator   => -Right.Numerator,
              Denominator =>  Right.Denominator);
   end "-";

   function "/" (Left, Right : in Fraction) return Fraction is
   begin
      return Reduce (Numerator   => Left.Numerator * Right.Denominator,
                     Denominator => Left.Denominator * Right.Numerator);
   end "/";

   function "/" (Left  : in Fraction;
                 Right : in Integer) return Fraction is
   begin
      return Reduce (Numerator   => Left.Numerator,
                     Denominator => Left.Denominator * Right);
   end "/";

   function "/" (Left  : in Integer;
                 Right : in Fraction) return Fraction is
   begin
      return Reduce (Numerator   => Left * Right.Denominator,
                     Denominator => Right.Numerator);
   end "/";

   function "/" (Left, Right : in Integer) return Fraction is
   begin
      return Reduce (Numerator   => Left,
                     Denominator => Right);
   end "/";

   function "<" (Left, Right : in Fraction) return Boolean is
   begin
      return Left.Numerator * Right.Denominator <
             Right.Numerator * Left.Denominator;
   end "<";

   function "<" (Left  : in Fraction;
                 Right : in Integer) return Boolean is
   begin
      return Left.Numerator < Right * Left.Denominator;
   end "<";

   function "<" (Left  : in Integer;
                 Right : in Fraction) return Boolean is
   begin
      return Left * Right.Denominator < Right.Numerator;
   end "<";

   function "<=" (Left, Right : in Fraction) return Boolean is
   begin
      return Left.Numerator * Right.Denominator <=
             Right.Numerator * Left.Denominator;
   end "<=";

   function "<=" (Left  : in Fraction;
                  Right : in Integer) return Boolean is
   begin
      return Left.Numerator <= Right * Left.Denominator;
   end "<=";

   function "<=" (Left  : in Integer;
                  Right : in Fraction) return Boolean is
   begin
      return Left * Right.Denominator <= Right.Numerator;
   end "<=";

   overriding
   function "=" (Left, Right : in Fraction) return Boolean is
   begin
      return Left.Numerator   = Right.Numerator and
             Left.Denominator = Right.Denominator;
   end "=";

   function "=" (Left  : in Fraction;
                 Right : in Integer) return Boolean is
   begin
      return Left.Numerator   = Right and
             Left.Denominator = 1;
   end "=";

   function "=" (Left  : in Integer;
                 Right : in Fraction) return Boolean is
   begin
      return Left = Right.Numerator and
             1    = Right.Denominator;
   end "=";

   function ">" (Left, Right : in Fraction) return Boolean is
   begin
      return Left.Numerator * Right.Denominator >
             Right.Numerator * Left.Denominator;
   end ">";

   function ">" (Left  : in Fraction;
                 Right : in Integer) return Boolean is
   begin
      return Left.Numerator > Right * Left.Denominator;
   end ">";

   function ">" (Left  : in Integer;
                 Right : in Fraction) return Boolean is
   begin
      return Left * Right.Denominator > Right.Numerator;
   end ">";

   function ">=" (Left, Right : in Fraction) return Boolean is
   begin
      return Left.Numerator * Right.Denominator >=
             Right.Numerator * Left.Denominator;
   end ">=";

   function ">=" (Left  : in Fraction;
                  Right : in Integer) return Boolean is
   begin
      return Left.Numerator >= Right * Left.Denominator;
   end ">=";

   function ">=" (Left  : in Integer;
                  Right : in Fraction) return Boolean is
   begin
      return Left * Right.Denominator >= Right.Numerator;
   end ">=";

   function Denominator (Item : in Fraction) return Denominator_Type is
   begin
      return Item.Denominator;
   end Denominator;

   function Greatest_Common_Divisor (A, B : in Positive) return Positive is
   begin
      for Divisor in reverse 1 .. Positive'Min (A, B) loop
         if (A rem Divisor = 0) and then (B rem Divisor = 0) then
            return Divisor;
         end if;
      end loop;

      raise Program_Error
        with "This can never happen as 1 is a divisor of all integers.";
   end Greatest_Common_Divisor;

   function Image (Item : in Fraction) return String is
      use Ada.Strings;
      use Ada.Strings.Fixed;
   begin
      if Item.Denominator = 1 then
         return Trim (Source => Numerator_Type'Image (Item.Numerator),
                      Side   => Left);
      else
         return Trim (Source => Numerator_Type'Image (Item.Numerator),
                      Side   => Left) &
                "/" &
                Trim (Source => Denominator_Type'Image (Item.Denominator),
                      Side   => Left);
      end if;
   end Image;

   function Is_Integer (Item : in Fraction) return Boolean is
   begin
      return Item.Denominator = 1;
   end Is_Integer;

   function Numerator (Item : in Fraction) return Numerator_Type is
   begin
      return Item.Numerator;
   end Numerator;

   function Reduce (Numerator, Denominator : in Integer) return Fraction is
      GCD : Positive;
   begin
      if Denominator = 0 then
         raise Constraint_Error;
      elsif Numerator = 0 then
         return (Numerator   => 0,
                 Denominator => 1);
      elsif Denominator < 0 then
         GCD := Greatest_Common_Divisor (abs Numerator, abs Denominator);

         return (Numerator   => (-Numerator) / GCD,
                 Denominator => (-Denominator) / GCD);
      else
         GCD := Greatest_Common_Divisor (abs Numerator, abs Denominator);

         return (Numerator   => Numerator / GCD,
                 Denominator => Denominator / GCD);
      end if;
   end Reduce;

   function To_Integer (Item : in Fraction) return Integer is
   begin
      if Item.Denominator = 1 then
         return Item.Numerator;
      else
         raise Not_An_Integer;
      end if;
   end To_Integer;

   function Value (Item : in String) return Fraction is
   begin
      raise Program_Error with "Not implemented yet.";
      return 0/1;
   end Value;

end Generic_Fractions;
