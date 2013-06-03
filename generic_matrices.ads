------------------------------------------------------------------------------
--
--  package Generic_Matrices (spec)
--
------------------------------------------------------------------------------
--  Update information:
--
--  2000.09.25 (Jacob Sparre Andersen)
--    Written.
--
--  2000.10.02 (Jacob Sparre Andersen)
--    Added procedure Set and procedure Transpose.
--
--  (Insert additional update information above this line.)
------------------------------------------------------------------------------

generic

   type Scalar is digits <>;

package Generic_Matrices is

   ---------------------------------------------------------------------------
   --  Exceptions:

   Mismatching_Dimensions : exception;
   Invalid_Column_Index   : exception;
   Invalid_Row_Index      : exception;

   ---------------------------------------------------------------------------
   --  Matrix types:

   type Column (N    : Positive) is private;
   type Row       (M : Positive) is private;
   type Matrix (N, M : Positive) is private;

   ---------------------------------------------------------------------------
   --  type Scalar_Array:

   type Scalar_Array is array (Positive range <>) of Scalar;

   ---------------------------------------------------------------------------
   --  Constructors:

   function To_Column (Item : in Scalar_Array) return Column;

   function To_Row    (Item : in Scalar_Array) return Row;

   function "&" (Left, Right : in Column) return Matrix;

   function "&" (Left  : in Matrix;
                 Right : in Column) return Matrix;

   function "&" (Top, Bottom : in Row) return Matrix;

   function "&" (Top    : in Matrix;
                 Bottom : in Row) return Matrix;

   ---------------------------------------------------------------------------
   --  Extracting values:

   function Element (Item : in Column;
                     i    : in Positive) return Scalar;

   function Element (Item : in Column;
                     i, j : in Positive) return Scalar;

   function Element (Item : in Row;
                        j : in Positive) return Scalar;

   function Element (Item : in Row;
                     i, j : in Positive) return Scalar;

   function Element (Item : in Matrix;
                     i, j : in Positive) return Scalar;

   procedure Set (Item  : in out Matrix;
                  i, j  : in     Positive;
                  Value : in     Scalar);

   ---------------------------------------------------------------------------
   --  Querying dimensions:

   function Height (Item : in Column) return Positive;

   function Width  (Item : in Column) return Positive;

   function Height (Item : in Row)    return Positive;

   function Width  (Item : in Row)    return Positive;

   function Height (Item : in Matrix) return Positive;

   function Width  (Item : in Matrix) return Positive;

   ---------------------------------------------------------------------------
   --  Arithmetics:

   function "+" (Left  : in Matrix;
                 Right : in Matrix) return Matrix;

   function "-" (Left  : in Matrix;
                 Right : in Matrix) return Matrix;

   function "-" (Right : in Matrix) return Matrix;

   function "*" (Left  : in Matrix;
                 Right : in Matrix) return Matrix;

   function "*" (Left  : in Matrix;
                 Right : in Column) return Column;

   function "*" (Left  : in Row;
                 Right : in Matrix) return Row;

   function "*" (Left  : in Scalar;
                 Right : in Matrix) return Matrix;

   function "*" (Left  : in Matrix;
                 Right : in Scalar) return Matrix;

   function "*" (Left  : in Row;
                 Right : in Column) return Scalar;

   function "/" (Left  : in Matrix;
                 Right : in Scalar) return Matrix;

   ---------------------------------------------------------------------------
   --  Transposing:

   function Transpose (Item : in Matrix) return Matrix;

   ---------------------------------------------------------------------------
   --  Comparisons:

   function "=" (Left  : in Matrix;
                 Right : in Column) return Boolean;

   function "=" (Left  : in Matrix;
                 Right : in Row) return Boolean;

   function "=" (Left  : in Matrix;
                 Right : in Scalar) return Boolean;

   function "=" (Left  : in Column;
                 Right : in Matrix) return Boolean;

   function "=" (Left  : in Column;
                 Right : in Row) return Boolean;

   function "=" (Left  : in Column;
                 Right : in Scalar) return Boolean;

   function "=" (Left  : in Row;
                 Right : in Matrix) return Boolean;

   function "=" (Left  : in Row;
                 Right : in Column) return Boolean;

   function "=" (Left  : in Row;
                 Right : in Scalar) return Boolean;

   ---------------------------------------------------------------------------
   --  Images:

   function Image (Value : in Column) return String;

   function Image (Value : in Row) return String;

   function Image (Value : in Matrix) return String;

   ---------------------------------------------------------------------------

private

   ---------------------------------------------------------------------------
   --  Matrix types:

   type Column (N : Positive) is
      record
         Elements : Scalar_Array (1 .. N) := (others => 0.0);
      end record;

   type Row (M : Positive) is
      record
         Elements : Scalar_Array (1 .. M) := (others => 0.0);
      end record;

   type Scalar_Matrix is array (Positive range <>,
                                Positive range <>) of Scalar;

   type Matrix (N, M : Positive) is
      record
         Elements : Scalar_Matrix (1 .. N,
                                   1 .. M) := (others => (others => 0.0));
      end record;

   ---------------------------------------------------------------------------

end Generic_Matrices;
