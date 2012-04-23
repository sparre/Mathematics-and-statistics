------------------------------------------------------------------------------
--
--  package Generic_Measurement_Values.Text_IO (body)
--
--  Package for handling values with limited measurement ranges.
--
------------------------------------------------------------------------------
--  Update information:
--
--  2005.06.22 (Jacob Sparre Andersen)
--    Written.
--
--  2005.06.22 (Jacob Sparre Andersen)
--    End_Error results in the remainder of the Measurement_Array
--    being filled with Undefined values.
--
--  (Insert additional update information above this line.)
------------------------------------------------------------------------------
--  Standard packages:

with Ada.Characters.Handling;
with Ada.Characters.Latin_1;

------------------------------------------------------------------------------
--  Other packages:

------------------------------------------------------------------------------

package body Generic_Measurement_Values.Text_IO is

   ---------------------------------------------------------------------------

   package Scalar_Text_IO is new Ada.Text_IO.Float_IO (Scalar);

   ---------------------------------------------------------------------------

   procedure Put (File : in     Ada.Text_IO.File_Type;
                  Item : in     Measurement;
                  Fore : in     Ada.Text_IO.Field := Default_Fore;
                  Aft  : in     Ada.Text_IO.Field := Default_Aft;
                  Exp  : in     Ada.Text_IO.Field := Default_Exp) is
      use Ada.Text_IO;
      use Scalar_Text_IO;
   begin
      case Item.As is
         when Below =>
            Put (File => File,
                 Item => '<');
            Put (File => File,
                 Item => Item.Value,
                 Fore => Fore,
                 Aft  => Aft,
                 Exp  => Exp);
         when Exact =>
            Put (File => File,
                 Item => Item.Value,
                 Fore => Fore,
                 Aft  => Aft,
                 Exp  => Exp);
         when Above =>
            Put (File => File,
                 Item => '>');
            Put (File => File,
                 Item => Item.Value,
                 Fore => Fore,
                 Aft  => Aft,
                 Exp  => Exp);
         when Undefined =>
            Put (File => File,
                 Item => "N/A");
      end case;
   end Put;

   procedure Put (Item : in     Measurement;
                  Fore : in     Ada.Text_IO.Field := Default_Fore;
                  Aft  : in     Ada.Text_IO.Field := Default_Aft;
                  Exp  : in     Ada.Text_IO.Field := Default_Exp) is
   begin
      Put (File => Ada.Text_IO.Standard_Output,
           Item => Item,
           Fore => Fore,
           Aft  => Aft,
           Exp  => Exp);
   end Put;

   ---------------------------------------------------------------------------

   procedure Put (File : in     Ada.Text_IO.File_Type;
                  Item : in     Measurement_Array;
                  Fore : in     Ada.Text_IO.Field := Default_Fore;
                  Aft  : in     Ada.Text_IO.Field := Default_Aft;
                  Exp  : in     Ada.Text_IO.Field := Default_Exp) is
      use Ada.Characters.Latin_1;
      use Ada.Text_IO;
   begin
      for Index in Item'Range loop
         if Index > Item'First then
            Put (File => File,
                 Item => HT);
         end if;

         Put (File => File,
              Item => Item (Index),
              Fore => Fore,
              Aft  => Aft,
              Exp  => Exp);
      end loop;
   end Put;

   procedure Put (Item : in     Measurement_Array;
                  Fore : in     Ada.Text_IO.Field := Default_Fore;
                  Aft  : in     Ada.Text_IO.Field := Default_Aft;
                  Exp  : in     Ada.Text_IO.Field := Default_Exp) is
   begin
      Put (File => Ada.Text_IO.Standard_Output,
           Item => Item,
           Fore => Fore,
           Aft  => Aft,
           Exp  => Exp);
   end Put;

   ---------------------------------------------------------------------------

   procedure Get (File : in     Ada.Text_IO.File_Type;
                  Item :    out Measurement) is
      use Ada.Characters.Handling;
      use Ada.Text_IO;
      use Scalar_Text_IO;
      Buffer         : Character;
      EOL            : Boolean;
      Number         : Scalar;
      Not_Applicable : String := "N/A";
   begin
  Skip_Whitespace:
      loop
         Look_Ahead (File        => File,
                     Item        => Buffer,
                     End_Of_Line => EOL);

         if EOL then
            raise End_Error;
         elsif Is_Control (Buffer) or Buffer = ' ' then
            Get (File => File,
                 Item => Buffer);
         else
            exit Skip_Whitespace;
         end if;
      end loop Skip_Whitespace;

      case Buffer is
         when '<' =>
            Get (File => File,
                 Item => Buffer);
            Get (File => File,
                 Item => Number);
            Item := (As    => Below,
                     Value => Number);
         when '>' =>
            Get (File => File,
                 Item => Buffer);
            Get (File => File,
                 Item => Number);
            Item := (As    => Above,
                     Value => Number);
         when 'N' | 'n' =>
            Get (File => File,
                 Item => Not_Applicable);
            if To_Upper (Not_Applicable) = "N/A" then
               Item := (As => Undefined);
            else
               raise Data_Error;
            end if;
         when others =>
            Get (File => File,
                 Item => Number);
            Item := (As    => Exact,
                     Value => Number);
      end case;
   end Get;

   procedure Get (Item :    out Measurement) is
   begin
      Get (File => Ada.Text_IO.Standard_Input,
           Item => Item);
   end Get;

   ---------------------------------------------------------------------------

   procedure Get (File : in     Ada.Text_IO.File_Type;
                  Item :    out Measurement_Array) is
   begin
      Item := (others => (As => Undefined));

      for Index in Item'Range loop
         begin
            Get (File => File,
                 Item => Item (Index));
         exception
            when Ada.Text_IO.End_Error =>
               Item (Index) := (As => Undefined);
            when others =>
               raise;
         end;
      end loop;
   end Get;

   procedure Get (Item :    out Measurement_Array) is
   begin
      Get (File => Ada.Text_IO.Standard_Input,
           Item => Item);
   end Get;

   ---------------------------------------------------------------------------

end Generic_Measurement_Values.Text_IO;
