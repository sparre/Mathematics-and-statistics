------------------------------------------------------------------------------
--
--  package Generic_Students_T_Test (body)
--
--  Student's t-test - based on the example code on page 483 in
--  "Numerical Recipes in C".
--
------------------------------------------------------------------------------
--  Update information:
--
--  2005.05.16-24 (Jacob Sparre Andersen)
--    Written.
--
--  2005.06.15 (Jacob Sparre Andersen)
--    Added variants of the test procedures which also return the calculated
--      mean values of the tested data-sets.
--
--  (Insert additional update information above this line.)
------------------------------------------------------------------------------
--  Standard packages:

with Ada.Numerics.Generic_Elementary_Functions;

------------------------------------------------------------------------------
--  "Numerical Recipes" packages:

with Generic_Betacf;
with Generic_Betai;
with Generic_Gammln;

------------------------------------------------------------------------------

package body Generic_Students_T_Test is

   ---------------------------------------------------------------------------

   package Elementary_Functions is
      new Ada.Numerics.Generic_Elementary_Functions (Scalar);

   ---------------------------------------------------------------------------

   function Gammln is
     new Generic_Gammln (Scalar               => Scalar,
                         Elementary_Functions => Elementary_Functions);

   ---------------------------------------------------------------------------

   function Betacf is
     new Generic_Betacf (Scalar => Scalar);

   ---------------------------------------------------------------------------

   function Betai is
     new Generic_Betai (Scalar               => Scalar,
                        Betacf               => Betacf,
                        Gammln               => Gammln,
                        Elementary_Functions => Elementary_Functions);

   ---------------------------------------------------------------------------

   function Sum (Data : in     Scalar_Array) return Scalar is
      pragma Inline (Sum);
      Result : Scalar := 0.0;
   begin
      for Index in Data'Range loop
         Result := Result + Data (Index);
      end loop;
      return Result;
   end Sum;

   ---------------------------------------------------------------------------

   function Sum_Of_Squares (Data : in     Scalar_Array;
                            Mean : in     Scalar) return Scalar is
      pragma Inline (Sum_Of_Squares);
      Result : Scalar := 0.0;
   begin
      for Index in Data'Range loop
         Result := Result + (Data (Index) - Mean) ** 2;
      end loop;
      return Result;
   end Sum_Of_Squares;

   ---------------------------------------------------------------------------

   procedure Equal (Data_1  : in     Scalar_Array;
                    Data_2  : in     Scalar_Array;
                    Mean_1  :    out Scalar;
                    Mean_2  :    out Scalar;
                    P_Value :    out Probability) is
      use Elementary_Functions;

      N1 : constant Scalar := Scalar (Data_1'Length);
      N2 : constant Scalar := Scalar (Data_2'Length);

      Df : constant Scalar := Scalar (Data_1'Length + Data_2'Length - 2);

      Svar, T : Scalar;
   begin
      Mean_1 := Sum (Data_1) / N1;
      Mean_2 := Sum (Data_2) / N2;

      Svar := (Sum_Of_Squares (Data_1, Mean_1) +
               Sum_Of_Squares (Data_2, Mean_2)) / Df;

      T := (Mean_1 - Mean_2) / Sqrt (Svar * (1.0 / N1 + 1.0 / N2));

      P_Value := Betai (A => 0.5 * Df,
                        B => 0.5,
                        X => Df / (Df + T * T));
   end Equal;

   ---------------------------------------------------------------------------

   function P_Equal (Data_1 : in     Scalar_Array;
                     Data_2 : in     Scalar_Array) return Probability is
      use Elementary_Functions;

      N1 : constant Scalar := Scalar (Data_1'Length);
      N2 : constant Scalar := Scalar (Data_2'Length);

      Df : constant Scalar := Scalar (Data_1'Length + Data_2'Length - 2);

      Ave_1, Ave_2, Svar, T : Scalar;
   begin
      Ave_1 := Sum (Data_1) / N1;
      Ave_2 := Sum (Data_2) / N2;

      Svar := (Sum_Of_Squares (Data_1, Ave_1) +
               Sum_Of_Squares (Data_2, Ave_2)) / Df;

      T := (Ave_1 - Ave_2) / Sqrt (Svar * (1.0 / N1 + 1.0 / N2));

      return Betai (A => 0.5 * Df,
                    B => 0.5,
                    X => Df / (Df + T * T));
   end P_Equal;

   ---------------------------------------------------------------------------

   procedure Equal (Data_1  : in     Scalar_Array;
                    Data_2  : in     Scalar := 0.0;
                    Mean_1  :    out Scalar;
                    P_Value :    out Probability) is
      use Elementary_Functions;

      N1 : constant Scalar := Scalar (Data_1'Length);
      Df : constant Scalar := Scalar (Data_1'Length - 1);

      T : Scalar;
   begin
      Mean_1 := Sum (Data_1) / N1;

      T := (Mean_1 - Data_2) * Sqrt (N1 * Df / Sum_Of_Squares (Data_1, Mean_1));

      P_Value := Betai (A => 0.5 * Df,
                        B => 0.5,
                        X => Df / (Df + T * T));
   end Equal;

   ---------------------------------------------------------------------------

   function P_Equal (Data_1 : in     Scalar_Array;
                     Data_2 : in     Scalar := 0.0) return Probability is
      use Elementary_Functions;

      N1 : constant Scalar := Scalar (Data_1'Length);
      Df : constant Scalar := Scalar (Data_1'Length - 1);

      Ave_1, T : Scalar;
   begin
      Ave_1 := Sum (Data_1) / N1;

      T := (Ave_1 - Data_2) * Sqrt (N1 * Df / Sum_Of_Squares (Data_1, Ave_1));

      return Betai (A => 0.5 * Df,
                    B => 0.5,
                    X => Df / (Df + T * T));
   end P_Equal;

   ---------------------------------------------------------------------------

   procedure High_Low (Data_1   : in     Scalar_Array;
                       Data_2   : in     Scalar_Array;
                       P_1_High :    out Probability;
                       P_2_High :    out Probability) is
      use Elementary_Functions;

      N1 : constant Scalar := Scalar (Data_1'Length);
      N2 : constant Scalar := Scalar (Data_2'Length);

      Df : constant Scalar := Scalar (Data_1'Length + Data_2'Length - 2);

      Ave_1, Ave_2, Svar, T : Scalar;
   begin
      Ave_1 := Sum (Data_1) / N1;
      Ave_2 := Sum (Data_2) / N2;

      Svar := (Sum_Of_Squares (Data_1, Ave_1) +
               Sum_Of_Squares (Data_2, Ave_2)) / Df;

      T := (Ave_1 - Ave_2) / Sqrt (Svar * (1.0 / N1 + 1.0 / N2));

      if Ave_1 > Ave_2 then
         P_1_High := 1.0 - Betai (A => 0.5 * Df,
                                  B => 0.5,
                                  X => Df / (Df + T * T));
         P_2_High := 0.0;
      elsif Ave_1 < Ave_2 then
         P_1_High := 0.0;
         P_2_High := 1.0 - Betai (A => 0.5 * Df,
                                  B => 0.5,
                                  X => Df / (Df + T * T));
      else
         P_1_High := 0.0;
         P_2_High := 0.0;
      end if;
   end High_Low;

   ---------------------------------------------------------------------------

end Generic_Students_T_Test;
