------------------------------------------------------------------------------
--
--  procedure Test_Floating_Point_Statistics (body)
--
--  Intended to test package Generic_Float_Statistics.
--
------------------------------------------------------------------------------
--  Update information:
--
--  1997.03.19 (Jacob Sparre Andersen)
--    Written.
--
--  (Insert additional update information above this line.)
------------------------------------------------------------------------------

with Ada.Float_Text_IO;
with Ada.Integer_Text_IO;
with Ada.Long_Float_Text_IO;
with Ada.Text_IO;

with Generic_Float_Statistics;

procedure Test_Floating_Point_Statistics is

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

begin --  Test_Floating_Point_Statistics
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
end Test_Floating_Point_Statistics;
