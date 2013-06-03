with Ada.Numerics.Elementary_Functions;

package body Coordinate_Transformations is

   Degree_To_Meter : constant Meters := 1.0e7 / 90.0;

   procedure Set (Origo : Geographical_Position) is
      use Ada.Numerics.Elementary_Functions;
   begin
      Coordinate_Transformations.Origo := Origo;
      Origo_Scale := Cos (Float (Origo.Lat), Cycle => 360.0);
   end Set;

   procedure Set (Orientation : Angle_In_Degrees) is
      use Ada.Numerics.Elementary_Functions;
      Angle : constant Float := Float (Orientation);
   begin
      Cos_Orientation := Meters (Cos (Angle, Cycle => 360.0));
      Sin_Orientation := Meters (Sin (Angle, Cycle => 360.0));
   end Set;

   function To_Local (From : Geographical_Position)
                     return Euclidian_Position is
      Local : Euclidian_Position;
   begin
      Local := (X => Meters ((From.Lon - Origo.Lon) * Degree_To_Meter)
                       * Meters (Origo_Scale),
                Y => Meters ((From.Lat - Origo.Lat) * Degree_To_Meter));
      return (X => Cos_Orientation * Local.X + Sin_Orientation * Local.Y,
              Y => Cos_Orientation * Local.Y - Sin_Orientation * Local.X);
   end To_Local;

end Coordinate_Transformations;
