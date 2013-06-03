------------------------------------------------------------------------------
--
--  package Generic_Rectangular_Vectors (spec)
--
------------------------------------------------------------------------------
--  Update information:
--
--  1995.12.27 (Jacob Sparre Andersen)
--    Written.
--
--  1996.06.25 (Jacob Sparre Andersen)
--    Reformatted the header.
--    Corrected a few bugs.
--
--  2012.04.24 (Jacob Sparre Andersen)
--    Removed superfluous comments and blank lines.
--
--  (Insert additional update information above this line.)
------------------------------------------------------------------------------

with Ada.Strings.Unbounded;
with Ada.Numerics.Generic_Elementary_Functions;

package body Generic_Rectangular_Vectors is

   ---------------------------------------------------------------------------
   --  package Elementary_Functions:

   package Elementary_Functions is new
     Ada.Numerics.Generic_Elementary_Functions (Float_Type => Scalar);

   ---------------------------------------------------------------------------

   function "*" (Left  : in Vector;
                 Right : in Scalar) return Vector is
      Result : Vector;
   begin
      for Index in Result'Range loop
         Result (Index) := Left (Index) * Right;
      end loop;
      return Result;
   end "*";

   function "*" (Left  : in Scalar;
                 Right : in Vector) return Vector is
      Result : Vector;
   begin
      for Index in Result'Range loop
         Result (Index) := Left * Right (Index);
      end loop;
      return Result;
   end "*";

   function "*" (Left, Right : in Vector) return Scalar is
      Scalar_Product : Scalar := 0.0;
   begin
      for Index in Left'Range loop
         Scalar_Product := Scalar_Product + Left (Index) * Right (Index);
      end loop;
      return Scalar_Product;
   end "*";

   function "+" (Left, Right : in Vector) return Vector is
      Result : Vector;
   begin
      for Index in Left'Range loop
         Result (Index) := Left (Index) + Right (Index);
      end loop;
      return Result;
   end "+";

   function "+" (Left  : in Point;
                 Right : in Vector) return Point is
      Result : Point;
   begin
      for Index in Result'Range loop
         Result (Index) := Left (Index) + Right (Index);
      end loop;
      return Result;
   end "+";

   function "-" (Left, Right : in Vector) return Vector is
      Result : Vector;
   begin
      for Index in Result'Range loop
         Result (Index) := Left (Index) - Right (Index);
      end loop;
      return Result;
   end "-";

   function "-" (Left, Right : in Point) return Vector is
      Result : Vector;
   begin
      for Index in Result'Range loop
         Result (Index) := Left (Index) - Right (Index);
      end loop;
      return Result;
   end "-";

   function "-" (Right : in Vector) return Vector is
      Result : Vector;
   begin
      for Index in Result'Range loop
         Result (Index) := -Right (Index);
      end loop;
      return Result;
   end "-";

   function "-" (Left  : in Point;
                 Right : in Vector) return Point is
      Result : Point;
   begin
      for Index in Left'Range loop
         Result (Index) := Left (Index) - Right (Index);
      end loop;
      return Result;
   end "-";

   function "/" (Left  : in Vector;
                 Right : in Scalar) return Vector is
      Result : Vector;
   begin
      for Index in Result'Range loop
         Result (Index) := Left (Index) / Right;
      end loop;
      return Result;
   end "/";

   function Distance (A, B : in Point) return Scalar is
   begin
      return Length (A - B);
   end Distance;

   function Image (Item : in Vector) return String is
      use Ada.Strings.Unbounded;

      Result : Unbounded_String;
   begin
      Result := To_Unbounded_String ("(");

      for Index in Item'Range loop
         Result := Result & Scalar'Image (Item (Index));

         if Index = Item'Last then
            Result := Result & ")";
         else
            Result := Result & ",";
         end if;
      end loop;

      return To_String (Result);
   end Image;

   function Image (Item : in Point) return String is
      use Ada.Strings.Unbounded;

      Result : Unbounded_String;
   begin
      Result := To_Unbounded_String ("(");

      for Index in Item'Range loop
         Result := Result & Scalar'Image (Item (Index));

         if Index = Item'Last then
            Result := Result & ")";
         else
            Result := Result & ",";
         end if;
      end loop;

      return To_String (Result);
   end Image;

   function Length (Item : in Vector) return Scalar is
   begin
      return Elementary_Functions.Sqrt (Squared_Length (Item));
   end Length;

   function Mirror (Ray            : in Vector;
                    Surface_Normal : in Vector) return Vector is
   begin
      return Ray - 2.0 * Project (Ray, Surface_Normal);
   end Mirror;

   procedure Normalize (Item : in out Vector) is
   begin
      Item := Item / Length (Item);
   end Normalize;

   function Project (V  : in Vector;
                     On : in Vector) return Vector is
   begin
      return On * (V * On) / Squared_Length (On);
   end Project;

   function Squared_Distance (A, B : in Point) return Scalar is
   begin
      return Squared_Length (A - B);
   end Squared_Distance;

   function Squared_Length (Item : in Vector) return Scalar is
      Result : Scalar := 0.0;
   begin
      for Index in Vector'Range loop
         Result := Result + Item (Index) ** 2;
      end loop;

      return Result;
   end Squared_Length;

   function Unit_Vector (Item : in Vector) return Vector is
   begin
      return Item / Length (Item);
   end Unit_Vector;

   function Value (Item : in String) return Vector is
      Result : constant Vector := Null_Vector;
   begin
      raise Program_Error with "Not implemented.";
      return Result;
   end Value;

   function Value (Item : in String) return Point is
      Result : constant Point := Origo;
   begin
      raise Program_Error with "Not implemented.";
      return Result;
   end Value;
end Generic_Rectangular_Vectors;
