with
  Ada.Float_Text_IO,
  Ada.Integer_Text_IO,
  Ada.Long_Float_Text_IO,
  Ada.Text_IO;
with
  Generic_Float_Statistics;

procedure Test_Floating_Point_Statistics is

   package Float_Statistics is new Generic_Float_Statistics
     (Maximum_Number_Of_Data_Points => 1_000_000,
      Data                          => Float,
      Squared_Data                  => Long_Float);

   use Ada.Float_Text_IO, Ada.Integer_Text_IO, Ada.Long_Float_Text_IO,
       Ada.Text_IO;
   use Float_Statistics.Statistics;

   Stats : Object;
   Value : Float;
begin
   loop
      Put ("Data: ");
      Get (Value);
      Skip_Line;

      exit when Value < 0.0;

      Append_Value (Target => Stats,
                    Value  => Value);

      Put ("   N = ");
      Put (Number_Of_Values (Stats));

      if Number_Of_Values (Stats) > 0 then
         Put ("  <x> = ");
         Put (Mean (Stats));

         if Number_Of_Values (Stats) > 1 then
            Put ("  var(x) = ");
            Put (Variance (Stats));
         end if;
      end if;
      New_Line (2);
   end loop;
exception
   when End_Error =>
      null;
end Test_Floating_Point_Statistics;
