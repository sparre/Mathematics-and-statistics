------------------------------------------------------------------------------
--
--  generic package Random_Numbers.Generic_Distribution (spec)
--
------------------------------------------------------------------------------
--  Update information:
--
--  1998.04.05 (Jacob Sparre Andersen)
--    Written.
--
--  (Insert additional update information above this line.)
------------------------------------------------------------------------------

generic

   with function Distribution (X : in Float) return Float;

   Resolution   : Positive;
   X_Min, X_Max : Float;

package Random_Numbers.Generic_Distribution is

   ---------------------------------------------------------------------------  
   --  procedure Reset:

   procedure Reset;

   ---------------------------------------------------------------------------
   --  function Random:

   function Random return Float;

   ---------------------------------------------------------------------------

end Random_Numbers.Generic_Distribution;
