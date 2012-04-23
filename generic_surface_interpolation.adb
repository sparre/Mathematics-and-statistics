------------------------------------------------------------------------------
--
--  generic package Generic_Surface_Interpolation (body)
--
--  Routines for interpolating a surface based on (a few) fixed points.
--
------------------------------------------------------------------------------
--  Maintenance log:
--
--  2000.03.13 (Jacob Sparre Andersen)
--    Written.
--
------------------------------------------------------------------------------

package body Generic_Surface_Interpolation is

   ---------------------------------------------------------------------------
   --  type Boolean_Field:
   --
   --  For locking the heights defined byt the supplied points.

   type Boolean_Field is array (Integer range <>, Integer range <>) of Boolean;

   ---------------------------------------------------------------------------
   --  procedure Interpolate:
   --

   procedure Interpolate (Points       : in     Point_Array;
                          Min, Max     : in     Point_2D;
                          Height_Field :    out Height_Field_Type) is

      ------------------------------------------------------------------------
      --  procedure Adjust:
      --
      --  Sets the height of a point to be the average value of the heights of
      --  the neighbouring points.

      procedure Adjust (X, Y : in Integer) is

         Sum   : Scalar := 0.0;
         Count : Natural := 0;

      begin --  Adjust
         if X in Height_Field'Range (1) and then
            Y in Height_Field'Range (2) then

            for dX in -1 .. +1 loop
               for dY in -1 .. +1 loop
                  if X + dX in Height_Field'Range (1) and then
                     Y + dY in Height_Field'Range (2) then

                     Sum := Sum + Height_Field (X + dX, Y + dY);
                     Count := Count + 1;
                  end if;
               end loop;
            end loop;

            Height_Field (X, Y) := Sum / Scalar (Count);
         end if;
      end Adjust;

      ------------------------------------------------------------------------
      --  function X:
      --
      --  ...

      X_Multiplier : constant Scalar :=
        Scalar (Height_Field'Length (1) - 1) / (Max (1) - Min (1));

      function X (Point : in Point_3D) return Integer is

      begin
         return Integer ((Point (1) - Min (1)) * X_Multiplier)
                  + Height_Field'First (1);
      end X;

      ------------------------------------------------------------------------
      --  function Y:
      --
      --  ...

      Y_Multiplier : constant Scalar :=
        Scalar (Height_Field'Length (2) - 1) / (Max (2) - Min (2));

      function Y (Point : in Point_3D) return Integer is

      begin
         return Integer ((Point (2) - Min (2)) * Y_Multiplier)
                  + Height_Field'First (2);
      end Y;

      ------------------------------------------------------------------------

      Locked_Heights : Boolean_Field (Height_Field'Range (1),
                                      Height_Field'Range (2));

   begin --  Interpolate
      --Height_Field := (others => (others => 0.0));
      Locked_Heights := (others => (others => False));

      for Index in Points'Range loop
         Height_Field (X (Points (Index)), Y (Points (Index))) :=
           Points (Index) (3);
         Locked_Heights (X (Points (Index)), Y (Points (Index))) := True;
      end loop;

      for Run in 1 .. Height_Field'Length (1) + Height_Field'Length (2) loop
         for X_Index in Height_Field'Range (1) loop
            for Y_Index in Height_Field'Range (2) loop
               if not Locked_Heights (X_Index, Y_Index) then
                  Adjust (X_Index, Y_Index);
               end if;
            end loop;
         end loop;
      end loop;
   end Interpolate;

   ---------------------------------------------------------------------------

end Generic_Surface_Interpolation;
