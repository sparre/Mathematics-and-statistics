------------------------------------------------------------------------------
--
--  procedure Mean_And_Variance (body)
--
--  Intended to test package Generic_Float_Statistics.
--
------------------------------------------------------------------------------
--  Update information:
--
--  2010.02.28 (Jacob Sparre Andersen)
--    Written.
--
--  (Insert additional update information above this line.)
------------------------------------------------------------------------------

with
  Ada.Characters.Latin_1,
  Ada.Float_Text_IO,
  Ada.Integer_Text_IO,
  Ada.Long_Float_Text_IO,
  Ada.Text_IO;
with
  Generic_Float_Statistics;

procedure Mean_And_Variance is

   ---------------------------------------------------------------------------
   --  package Float_Statistics:

   package Float_Statistics is new Generic_Float_Statistics
     (Maximum_Number_Of_Data_Points => 1_000_000,
      Data                          => Float,
      Squared_Data                  => Long_Float);

   ---------------------------------------------------------------------------

   use Ada.Float_Text_IO;
   use Ada.Integer_Text_IO;
   use Ada.Long_Float_Text_IO;
   use Ada.Text_IO;
   use Float_Statistics.Statistics;

   Stats : Object;
   Value : Float;
begin --  Mean_And_Variance
   while not End_Of_File (Standard_Input) loop
      Get (Value);
      Skip_Line;

      Append_Value (Target => Stats,
                    Value  => Value);
   end loop;

   Put (Number_Of_Values (Stats));

   Put (Ada.Characters.Latin_1.HT);
   if Number_Of_Values (Stats) > 0 then
      Put (Mean (Stats));
   else
      Put ("N/A");
   end if;

   Put (Ada.Characters.Latin_1.HT);
   if Number_Of_Values (Stats) > 1 then
      Put (Variance (Stats));
   else
      Put ("N/A");
   end if;

   New_Line;
end Mean_And_Variance;
