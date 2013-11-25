------------------------------------------------------------------------------
--
--  package Generic_Matrices (body)
--
------------------------------------------------------------------------------
--  Update information:
--
--  2000.09.25 (Jacob Sparre Andersen)
--    Written and tested.
--
--  2000.10.02 (Jacob Sparre Andersen)
--    Added procedure Set and procedure Transpose.
--
--  (Insert additional update information above this line.)
------------------------------------------------------------------------------
--  Standard packages:

with Ada.Strings.Unbounded;

------------------------------------------------------------------------------

package body Generic_Matrices is

   function "&" (Left, Right : in Column) return Matrix is
      Result : Matrix (Height (Left), 2);
   begin
      if Height (Left) = Height (Right) then
         for i in Result.Elements'Range (1) loop
            Result.Elements (i, 1) := Left.Elements (i);
            Result.Elements (i, 2) := Right.Elements (i);
         end loop;

         return Result;
      else
         raise Mismatching_Dimensions;
      end if;
   end "&";

   function "&" (Left  : in Matrix;
                 Right : in Column) return Matrix is
      Result : Matrix (Height (Left), Width (Left) + 1);
   begin
      if Height (Left) = Height (Right) then
         for i in Left.Elements'Range (1) loop
            for j in Left.Elements'Range (2) loop
               Result.Elements (i, j) := Left.Elements (i, j);
            end loop;

            Result.Elements (i, Result.Elements'Last (2))
              := Right.Elements (i);
         end loop;

         return Result;
      else
         raise Mismatching_Dimensions;
      end if;
   end "&";

   function "&" (Top, Bottom : in Row) return Matrix is
      Result : Matrix (2, Width (Top));
   begin
      if Width (Top) = Width (Bottom) then
         for j in Result.Elements'Range (2) loop
            Result.Elements (1, j) := Top.Elements (j);
            Result.Elements (2, j) := Bottom.Elements (j);
         end loop;

         return Result;
      else
         raise Mismatching_Dimensions;
      end if;
   end "&";

   function "&" (Top    : in Matrix;
                 Bottom : in Row) return Matrix is
      Result : Matrix (Height (Top) + 1, Width (Top));
   begin
      if Width (Top) = Width (Bottom) then
         for j in Top.Elements'Range (2) loop
            for i in Top.Elements'Range (1) loop
               Result.Elements (i, j) := Top.Elements (i, j);
            end loop;

            Result.Elements (Result.Elements'Last (1), j)
              := Bottom.Elements (j);
         end loop;

         return Result;
      else
         raise Mismatching_Dimensions;
      end if;
   end "&";

   function "*" (Left  : in Matrix;
                 Right : in Matrix) return Matrix is

      Result : Matrix (N => Height (Left),
                       M => Width (Right));

   begin --  "*"
      if Width (Left) = Height (Right) then
         for i in Left.Elements'Range (1) loop
            for j in Left.Elements'Range (2) loop
               for k in Right.Elements'Range (2) loop
                  Result.Elements (i, k) := Result.Elements (i, k)
                    + Left.Elements (i, j) * Right.Elements (j, k);
               end loop;
            end loop;
         end loop;

         return Result;
      else
         raise Mismatching_Dimensions;
      end if;
   end "*";

   function "*" (Left  : in Matrix;
                 Right : in Column) return Column is

      Result : Column (N => Height (Left));

   begin --  "*"
      if Width (Left) = Height (Right) then
         for i in Left.Elements'Range (1) loop
            for j in Left.Elements'Range (2) loop
               Result.Elements (i) := Result.Elements (i)
                 + Left.Elements (i, j) * Right.Elements (j);
            end loop;
         end loop;

         return Result;
      else
         raise Mismatching_Dimensions;
      end if;
   end "*";

   function "*" (Left  : in Row;
                 Right : in Matrix) return Row is

      Result : Row (M => Width (Right));

   begin --  "*"
      if Width (Left) = Height (Right) then
         for j in Right.Elements'Range (1) loop
            for k in Right.Elements'Range (2) loop
               Result.Elements (k) := Result.Elements (k)
                 + Left.Elements (j) * Right.Elements (j, k);
            end loop;
         end loop;

         return Result;
      else
         raise Mismatching_Dimensions;
      end if;
   end "*";

   function "*" (Left  : in Scalar;
                 Right : in Matrix) return Matrix is

      Result : Matrix (N => Height (Right),
                       M => Width  (Right));

   begin --  "*"
      for i in Result.Elements'Range (1) loop
         for j in Result.Elements'Range (2) loop
            Result.Elements (i, j) := Left * Right.Elements (i, j);
         end loop;
      end loop;

      return Result;
   end "*";

   function "*" (Left  : in Matrix;
                 Right : in Scalar) return Matrix is

      Result : Matrix (N => Height (Left),
                       M => Width  (Left));

   begin --  "*"
      for i in Result.Elements'Range (1) loop
         for j in Result.Elements'Range (2) loop
            Result.Elements (i, j) := Left.Elements (i, j) * Right;
         end loop;
      end loop;

      return Result;
   end "*";

   function "*" (Left  : in Row;
                 Right : in Column) return Scalar is

      Result : Scalar := 0.0;

   begin --  "*"
      if Width (Left) = Height (Right) then
         for i in 1 .. Width (Left) loop
            Result := Result + Left.Elements (i) * Right.Elements (i);
         end loop;

         return Result;
      else
         raise Mismatching_Dimensions;
      end if;
   end "*";

   function "+" (Left  : in Matrix;
                 Right : in Matrix) return Matrix is

      Result : Matrix (N => Height (Left),
                       M => Width (Left));

   begin --  "+"
      if Width (Left) = Width (Right) and Height (Left) = Height (Right) then
         for i in Result.Elements'Range (1) loop
            for j in Result.Elements'Range (2) loop
               Result.Elements (i, j) := Left.Elements (i, j)
                                           + Right.Elements (i, j);
            end loop;
         end loop;

         return Result;
      else
         raise Mismatching_Dimensions;
      end if;
   end "+";

   function "-" (Left  : in Matrix;
                 Right : in Matrix) return Matrix is

      Result : Matrix (N => Height (Left),
                       M => Width (Left));

   begin --  "-"
      if Width (Left) = Width (Right) and Height (Left) = Height (Right) then
         for i in Result.Elements'Range (1) loop
            for j in Result.Elements'Range (2) loop
               Result.Elements (i, j) := Left.Elements (i, j)
                                           - Right.Elements (i, j);
            end loop;
         end loop;

         return Result;
      else
         raise Mismatching_Dimensions;
      end if;
   end "-";

   function "-" (Right : in Matrix) return Matrix is
      Result : Matrix (N => Height (Right),
                       M => Width  (Right));
   begin
      for i in Result.Elements'Range (1) loop
         for j in Result.Elements'Range (2) loop
            Result.Elements (i, j) := -Right.Elements (i, j);
         end loop;
      end loop;

      return Result;
   end "-";

   function "/" (Left  : in Matrix;
                 Right : in Scalar) return Matrix is
      Result : Matrix (N => Height (Left),
                       M => Width  (Left));
   begin
      for i in Result.Elements'Range (1) loop
         for j in Result.Elements'Range (2) loop
            Result.Elements (i, j) := Left.Elements (i, j) / Right;
         end loop;
      end loop;

      return Result;
   end "/";

   function "=" (Left  : in Matrix;
                 Right : in Column) return Boolean is
   begin
      if Width (Left) = Width (Right) and Height (Left) = Height (Right) then
         for i in 1 .. Height (Left) loop
            for j in 1 .. Width (Left) loop
               if Element (Left, i, j) /= Element (Right, i, j) then
                  return False;
               end if;
            end loop;
         end loop;

         return True;
      else
         raise Mismatching_Dimensions;
      end if;
   end "=";

   function "=" (Left  : in Matrix;
                 Right : in Row) return Boolean is

   begin
      if Width (Left) = Width (Right) and Height (Left) = Height (Right) then
         for i in 1 .. Height (Left) loop
            for j in 1 .. Width (Left) loop
               if Element (Left, i, j) /= Element (Right, i, j) then
                  return False;
               end if;
            end loop;
         end loop;

         return True;
      else
         raise Mismatching_Dimensions;
      end if;
   end "=";

   function "=" (Left  : in Matrix;
                 Right : in Scalar) return Boolean is

   begin
      if Width (Left) = 1 and Height (Left) = 1 then
         return Element (Left, 1, 1) = Right;
      else
         raise Mismatching_Dimensions;
      end if;
   end "=";

   function "=" (Left  : in Column;
                 Right : in Matrix) return Boolean is

   begin
      if Width (Left) = Width (Right) and Height (Left) = Height (Right) then
         for i in 1 .. Height (Left) loop
            for j in 1 .. Width (Left) loop
               if Element (Left, i, j) /= Element (Right, i, j) then
                  return False;
               end if;
            end loop;
         end loop;

         return True;
      else
         raise Mismatching_Dimensions;
      end if;
   end "=";

   function "=" (Left  : in Column;
                 Right : in Row) return Boolean is

   begin
      if Width (Left) = Width (Right) and Height (Left) = Height (Right) then
         for i in 1 .. Height (Left) loop
            for j in 1 .. Width (Left) loop
               if Element (Left, i, j) /= Element (Right, i, j) then
                  return False;
               end if;
            end loop;
         end loop;

         return True;
      else
         raise Mismatching_Dimensions;
      end if;
   end "=";

   function "=" (Left  : in Column;
                 Right : in Scalar) return Boolean is

   begin
      if Width (Left) = 1 and Height (Left) = 1 then
         return Left.Elements (1) = Right;
      else
         raise Mismatching_Dimensions;
      end if;
   end "=";

   function "=" (Left  : in Row;
                 Right : in Matrix) return Boolean is

   begin
      if Width (Left) = Width (Right) and Height (Left) = Height (Right) then
         for i in 1 .. Height (Left) loop
            for j in 1 .. Width (Left) loop
               if Element (Left, i, j) /= Element (Right, i, j) then
                  return False;
               end if;
            end loop;
         end loop;

         return True;
      else
         raise Mismatching_Dimensions;
      end if;
   end "=";

   function "=" (Left  : in Row;
                 Right : in Column) return Boolean is

   begin
      if Width (Left) = Width (Right) and Height (Left) = Height (Right) then
         return Left.Elements (1) = Right.Elements (1);
      else
         raise Mismatching_Dimensions;
      end if;
   end "=";

   function "=" (Left  : in Row;
                 Right : in Scalar) return Boolean is

   begin
      if Width (Left) = 1 and Height (Left) = 1 then
         return Left.Elements (1) = Right;
      else
         raise Mismatching_Dimensions;
      end if;
   end "=";

   function Element (Item : in Column;
                     i    : in Positive) return Scalar is
   begin
      return Item.Elements (i);
   end Element;

   function Element (Item : in Column;
                     i, j : in Positive) return Scalar is
   begin
      if j = 1 then
         return Item.Elements (i);
      else
         raise Invalid_Column_Index;
      end if;
   end Element;

   function Element (Item : in Row;
                        j : in Positive) return Scalar is
   begin
      return Item.Elements (j);
   end Element;

   function Element (Item : in Row;
                     i, j : in Positive) return Scalar is
   begin
      if i = 1 then
         return Item.Elements (j);
      else
         raise Invalid_Row_Index;
      end if;
   end Element;

   function Element (Item : in Matrix;
                     i, j : in Positive) return Scalar is
   begin
      return Item.Elements (i, j);
   end Element;

   function Height (Item : in Column) return Positive is
   begin
      return Item.Elements'Length;
   end Height;

   function Height (Item : in Row) return Positive is
      pragma Unreferenced (Item);
   begin
      return 1;
   end Height;

   function Height (Item : in Matrix) return Positive is
   begin
      return Item.Elements'Length (1);
   end Height;

   function Image (Value : in Column) return String is

      use Ada.Strings.Unbounded;

      Result : Unbounded_String := Null_Unbounded_String;

   begin --  Image
      for i in Value.Elements'Range loop
         if i = 1 then
            Append (Result, "(");
         else
            Append (Result, "; ");
         end if;

         Append (Result, Scalar'Image (Value.Elements (i)));
      end loop;

      Append (Result, ")");

      return To_String (Result);
   end Image;

   function Image (Value : in Row) return String is

      use Ada.Strings.Unbounded;

      Result : Unbounded_String := Null_Unbounded_String;

   begin --  Image
      for i in Value.Elements'Range loop
         if i = 1 then
            Append (Result, "(");
         else
            Append (Result, "; ");
         end if;

         Append (Result, Scalar'Image (Value.Elements (i)));
      end loop;

      Append (Result, ")");

      return To_String (Result);
   end Image;

   function Image (Value : in Matrix) return String is
      use Ada.Strings.Unbounded;

      Result : Unbounded_String := Null_Unbounded_String;
   begin
      for i in 1 .. Height (Value) loop
         if i = 1 then
            Append (Result, "(");
         else
            Append (Result, "; ");
         end if;

         for j in 1 .. Width (Value) loop
            if j = 1 then
               Append (Result, "(");
            else
               Append (Result, "; ");
            end if;

            Append (Result, Scalar'Image (Value.Elements (i, j)));
         end loop;

         Append (Result, ")");
      end loop;

      Append (Result, ")");

      return To_String (Result);
   end Image;

   procedure Set (Item  : in out Matrix;
                  i, j  : in     Positive;
                  Value : in     Scalar) is
   begin
      Item.Elements (i, j) := Value;
   end Set;

   function To_Column (Item : in Scalar_Array) return Column is
   begin
      return Column'(N        => Item'Length,
                     Elements => Item);
   end To_Column;

   function To_Row (Item : in Scalar_Array) return Row is
   begin
      return Row'(M        => Item'Length,
                  Elements => Item);
   end To_Row;

   function Transpose (Item : in Matrix) return Matrix is
      Result : Matrix (N => Item.M, M => Item.N);
   begin
      for i in 1 .. Height (Item) loop
         for j in 1 .. Width (Item) loop
            Result.Elements (j, i) := Item.Elements (i, j);
         end loop;
      end loop;

      return Result;
   end Transpose;

   function Width  (Item : in Column) return Positive is
      pragma Unreferenced (Item);
   begin
      return 1;
   end Width;

   function Width  (Item : in Row) return Positive is
   begin
      return Item.Elements'Length;
   end Width;

   function Width  (Item : in Matrix) return Positive is

   begin
      return Item.Elements'Length (2);
   end Width;

end Generic_Matrices;
