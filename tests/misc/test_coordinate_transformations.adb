with
  Ada.Text_IO,
  Coordinate_Transformations;

use
  Ada.Text_IO,
  Coordinate_Transformations;

procedure Test_Coordinate_Transformations is
   Pos : Euclidian_Position;
begin
   pragma Warnings (Off);

   Set (Origo => (Lon => +12.08, Lat => +56.01));

   Pos := To_Local (From => (Lon => +12.08, Lat => +56.01));
   Put_Line ("Pos = (" & Pos.X'Img & ", " & Pos.Y'Img & ")");

   Pos := To_Local (From => (Lon => +12.08, Lat => +56.02));
   Put_Line ("Pos = (" & Pos.X'Img & ", " & Pos.Y'Img & ")");

   Pos := To_Local (From => (Lon => +12.10, Lat => +56.01));
   Put_Line ("Pos = (" & Pos.X'Img & ", " & Pos.Y'Img & ")");

   Set (Orientation => 90.0);

   Pos := To_Local (From => (Lon => +12.08, Lat => +56.01));
   Put_Line ("Pos = (" & Pos.X'Img & ", " & Pos.Y'Img & ")");

   Pos := To_Local (From => (Lon => +12.08, Lat => +56.02));
   Put_Line ("Pos = (" & Pos.X'Img & ", " & Pos.Y'Img & ")");

   Pos := To_Local (From => (Lon => +12.10, Lat => +56.01));
   Put_Line ("Pos = (" & Pos.X'Img & ", " & Pos.Y'Img & ")");
end Test_Coordinate_Transformations;
