package Coordinate_Transformations is

   type Angle_In_Degrees is delta 0.000_000_009 -- 1 mm resolution
                            range -360.0 .. +360.0;
   subtype Longitude is Angle_In_Degrees range -180.0 .. +180.0;
   --  East positive, west negative.
   subtype Latitude  is Angle_In_Degrees range  -90.0 ..  +90.0;
   --  North positive, south negative.

   type Geographical_Position is
      record
         Lon : Longitude := 0.0;
         Lat : Latitude  := 0.0;
      end record;

   type Meters is delta 0.001 -- 1 mm resolution
                  range -200_000.0 .. +200_000.0;

   type Euclidian_Position is
      record
         X, Y : Meters := 0.0;
      end record;

   procedure Set (Origo : Geographical_Position);
   procedure Set (Orientation : Angle_In_Degrees);

   function To_Local (From : Geographical_Position) return Euclidian_Position;

private

   Origo           : Geographical_Position := (0.0, 0.0);
   Origo_Scale     : Float := 1.0;
   Cos_Orientation : Meters := 1.0;
   Sin_Orientation : Meters := 0.0;

end Coordinate_Transformations;
