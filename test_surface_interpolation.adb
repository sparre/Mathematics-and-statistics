------------------------------------------------------------------------------
--
--  procedure Test_Surface_Interpolation (body)
--
--  A procedure for testing the package Generic_Surface_Interpolation.
--
--  Command line:
--    Grid resolution (pixels/coordinate unit)
--
--  Standard input:
--    Lines with x, y, and z coordinates.
--
--  Standard output:
--    A PGM file with the interpolation.
--
------------------------------------------------------------------------------
--  Maintenance log:
--
--  2000.03.15 (Jacob Sparre Andersen)
--    Written.
--
--  2012.04.24 (Jacob Sparre Andersen)
--    Removed superfluous comment.
--
------------------------------------------------------------------------------
--  Standard packages:

with Ada.Command_Line;
with Ada.Float_Text_IO;
with Ada.Integer_Text_IO;
with Ada.Text_IO;

------------------------------------------------------------------------------
--  Math packages:

with Generic_Rectangular_Vectors;
with Generic_Surface_Interpolation;

------------------------------------------------------------------------------

procedure Test_Surface_Interpolation is

   package Vectors_2D is new Generic_Rectangular_Vectors (Dimensions => 2,
                                                          Scalar     => Float);

   package Vectors_3D is new Generic_Rectangular_Vectors (Dimensions => 3,
                                                          Scalar     => Float);

   package Surface_Interpolation is new Generic_Surface_Interpolation
     (Scalar_Type => Float,
      Vectors_2D  => Vectors_2D,
      Vectors_3D  => Vectors_3D);

   use Ada.Float_Text_IO;
   use Ada.Integer_Text_IO;
   use Ada.Text_IO;
   use Surface_Interpolation;

   Points      : Point_Array (1 .. 1000);
   Min, Max    : Vectors_2D.Point;
   Point_Count : Natural := 0;

   Grid_Resolution : Float;
   X_Size, Y_Size  : Float;
   Bottom, Top     : Float;
   Height          : Float;

begin

   Read_Data_Points :
   loop
      exit Read_Data_Points when End_Of_File (Standard_Input);
      exit Read_Data_Points when Point_Count = Points'Last;

      Point_Count := Point_Count + 1;

      for Coordinate in Points (Point_Count)'Range loop
         Get (File => Standard_Input,
              Item => Points (Point_Count) (Coordinate));
      end loop;
      Skip_Line (File => Standard_Input);

      if Point_Count = Points'First then
         Min := (1 => Points (Point_Count) (1),
                 2 => Points (Point_Count) (2));
         Bottom := Points (Point_Count) (3);
         Max := Min;
         Top := Bottom;
      else
         for Coordinate in Min'Range loop
            if Points (Point_Count) (Coordinate) < Min (Coordinate) then
               Min (Coordinate) := Points (Point_Count) (Coordinate);
            elsif Max (Coordinate) < Points (Point_Count) (Coordinate) then
               Max (Coordinate) := Points (Point_Count) (Coordinate);
            end if;
         end loop;

         if Points (Point_Count) (3) < Bottom then
            Bottom := Points (Point_Count) (3);
            Height := Top - Bottom;
         elsif Top < Points (Point_Count) (3) then
            Top := Points (Point_Count) (3);
            Height := Top - Bottom;
         end if;
      end if;
   end loop Read_Data_Points;

   Grid_Resolution := Float'Value (Ada.Command_Line.Argument (1));

   X_Size := (Max (1) - Min (1)) * Grid_Resolution;
   Y_Size := (Max (2) - Min (2)) * Grid_Resolution;

   declare
      Height_Field : Height_Field_Type (0 .. Positive (X_Size),
                                        0 .. Positive (Y_Size));
   begin
      for X in Height_Field'Range (1) loop
         for Y in Height_Field'Range (2) loop
            Height_Field (X, Y) := Bottom;
         end loop;
      end loop;

      --  for Index in 0 .. Positive (X_Size + Y_Size) loop
      for Index in 1 .. 10 loop
         Interpolate (Points       => Points (Points'First .. Point_Count),
                      Min          => Min,
                      Max          => Max,
                      Height_Field => Height_Field);
      end loop;

      Put (File => Current_Error,
           Item => "Intensity range corresponds to the interval [");
      Put (File => Current_Error,
           Item => Bottom,
           Fore => 0,
           Aft  => 4,
           Exp  => 0);
      Put (File => Current_Error,
           Item => ", ");
      Put (File => Current_Error,
           Item => Top,
           Fore => 0,
           Aft  => 4,
           Exp  => 0);
      Put_Line (File => Current_Error,
                Item => "]");

      Put_Line ("P2");
      Put (Height_Field'Length (1), Width => 0);
      Put (" ");
      Put (Height_Field'Length (2), Width => 0);
      New_Line;
      Put_Line ("255");
      for Y in reverse Height_Field'Range (2) loop
         for X in Height_Field'Range (1) loop
            Put (Natural (255.0 * (Height_Field (X, Y) - Bottom) / Height),
                 Width => 0);

            if Col (Standard_Output) > 60 then
               New_Line;
            else
               Put (" ");
            end if;
         end loop;
      end loop;
   end;
end Test_Surface_Interpolation;
