with Ada.Text_IO;

with Generic_Rectangular_Vectors;

procedure Vector_Examples is
   type Meter is digits 12;

   package Meter_IO is new Ada.Text_IO.Float_IO (Meter);

   package Vectors is new Generic_Rectangular_Vectors (Scalar     => Meter,
                                                       Dimensions => 2);
   use Vectors;

   function Rotate_90_Degrees (Item : in Vector) return Vector
   is (1 => Item (2), 2 => -Item (1));

   Point_On_Road    : constant Point  :=  (0.0,  0.0);
   Road_Direction   : constant Vector := (10.0,  0.0);
   House_Location   : constant Point  := (25.0, 15.0);
   Distance_To_Road : Meter;
begin

   declare
      --  Using https://en.wikipedia.org/wiki/Distance_from_a_point_to_a_line
      --        #A_vector_projection_proof
      Q : Point  renames Point_On_Road;
      n : Vector renames Rotate_90_Degrees (Road_Direction);
      P : Point  renames House_Location;
      d : Meter  renames Distance_To_Road;
   begin
      d := (Q - P) * n / Length (n);
   end;

   Ada.Text_IO.Put ("The house is ");
   Meter_IO.Put (Distance_To_Road, Exp => 0, Fore => 0, Aft => 2);
   Ada.Text_IO.Put_Line (" m from the road.");
end Vector_Examples;
