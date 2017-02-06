with Ada.Integer_Text_IO;
with Ada.Text_IO;

with Generic_Fractions;

procedure Fractions is
   package F is new Generic_Fractions (Max => 20);

   use Ada.Integer_Text_IO, Ada.Text_IO;
   use F;
begin
   for A in Integer range -20 .. 20 loop
      for B in Integer range -20 .. 20 loop
         if B /= 0 then
            Put (A, Width => 3);
            Put (" / ");
            Put (B, Width => 2);
            Put (" = ");
            Put (Image (A / B));
            New_Line;
         end if;
      end loop;
   end loop;
end Fractions;
