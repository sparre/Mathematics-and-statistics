------------------------------------------------------------------------------
--
--  package Generic_Measurement_Values.Text_IO (spec)
--
--  Package for handling values with limited measurement ranges.
--
------------------------------------------------------------------------------
--  Update information:
--
--  2005.06.21-22 (Jacob Sparre Andersen)
--    Written.
--
--  (Insert additional update information above this line.)
------------------------------------------------------------------------------
--  Standard packages:

with Ada.Text_IO;

------------------------------------------------------------------------------
--  Other packages:

------------------------------------------------------------------------------

generic

package Generic_Measurement_Values.Text_IO is

   ---------------------------------------------------------------------------

   Default_Fore : Ada.Text_IO.Field := 2;
   Default_Aft  : Ada.Text_IO.Field := Scalar'Digits - 1;
   Default_Exp  : Ada.Text_IO.Field := 3;

   ---------------------------------------------------------------------------

   procedure Put (File : in     Ada.Text_IO.File_Type;
                  Item : in     Measurement;
                  Fore : in     Ada.Text_IO.Field := Default_Fore;
                  Aft  : in     Ada.Text_IO.Field := Default_Aft;
                  Exp  : in     Ada.Text_IO.Field := Default_Exp);

   procedure Put (Item : in     Measurement;
                  Fore : in     Ada.Text_IO.Field := Default_Fore;
                  Aft  : in     Ada.Text_IO.Field := Default_Aft;
                  Exp  : in     Ada.Text_IO.Field := Default_Exp);

   ---------------------------------------------------------------------------

   procedure Put (File : in     Ada.Text_IO.File_Type;
                  Item : in     Measurement_Array;
                  Fore : in     Ada.Text_IO.Field := Default_Fore;
                  Aft  : in     Ada.Text_IO.Field := Default_Aft;
                  Exp  : in     Ada.Text_IO.Field := Default_Exp);

   procedure Put (Item : in     Measurement_Array;
                  Fore : in     Ada.Text_IO.Field := Default_Fore;
                  Aft  : in     Ada.Text_IO.Field := Default_Aft;
                  Exp  : in     Ada.Text_IO.Field := Default_Exp);

   ---------------------------------------------------------------------------

   procedure Get (File : in     Ada.Text_IO.File_Type;
                  Item :    out Measurement);

   procedure Get (Item :    out Measurement);

   ---------------------------------------------------------------------------

   procedure Get (File : in     Ada.Text_IO.File_Type;
                  Item :    out Measurement_Array);

   procedure Get (Item :    out Measurement_Array);

   ---------------------------------------------------------------------------

end Generic_Measurement_Values.Text_IO;
