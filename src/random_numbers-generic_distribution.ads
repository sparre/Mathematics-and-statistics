generic

   with function Distribution (X : in Float) return Float;

   Resolution   : Positive;
   X_Min, X_Max : Float;

package Random_Numbers.Generic_Distribution is

   procedure Reset renames Random_Numbers.Reset;
   --  Reset global generator.

   function Random return Float;
   --  Draw from the specified distribution.

end Random_Numbers.Generic_Distribution;
