with Ada.Command_Line, Ada.Integer_Text_IO, Ada.Text_IO;

procedure Number_Of_Combinations is
   use Ada.Command_Line, Ada.Integer_Text_IO, Ada.Text_IO;
   Set, Subset : Natural;
begin
   if Argument_Count = 2 then
      begin
         Set    := Natural'Value (Argument (1));
         Subset := Natural'Value (Argument (2));
         if Subset > Set then
            Put_Line
              (File => Current_Error,
               Item => "The second argument to " & Command_Name &
                       " can't be larger than the first one.");
            Set_Exit_Status (Failure);
            return;
         end if;
      exception
         when others =>
            Put_Line
              (File => Current_Error,
               Item => Command_Name & " takes two non-negative arguments.");
            Set_Exit_Status (Failure);
            return;
      end;

      if Subset > Set - Subset then
         Subset := Set - Subset;
      end if;

      declare
         Result : Positive := 1;
      begin
         for Multiplier in reverse Set - Subset + 1 .. Set loop
            Result := Result * Multiplier;
         end loop;

         for Divisor in 1 .. Subset loop
            Result := Result / Divisor;
         end loop;

         Put (Item => Result, Width => 0);
         Set_Exit_Status (Success);
      end;
   else
      Put_Line (File => Current_Error,
                Item => Command_Name & " takes two non-negative arguments.");
      Set_Exit_Status (Failure);
   end if;
end Number_Of_Combinations;
