------------------------------------------------------------------------------
--
--  package Generic_Students_T_Test (spec)
--
--  Student's t-test - based on the example code on page 483 in
--  "Numerical Recipes in C".
--
------------------------------------------------------------------------------
--  Update information:
--
--  2005.05.16-23 (Jacob Sparre Andersen)
--    Written.
--
--  2005.06.15 (Jacob Sparre Andersen)
--    Added variants of the test procedures which also return the calculated
--      mean values of the tested data-sets.
--
--  (Insert additional update information above this line.)
------------------------------------------------------------------------------
--  Standard packages:

------------------------------------------------------------------------------

generic

   type Scalar is digits <>;

   type Indices is (<>);

   type Scalar_Array is array (Indices range <>) of Scalar;

package Generic_Students_T_Test is

   ---------------------------------------------------------------------------

   subtype Probability is Scalar range 0.0 .. 1.0;

   ---------------------------------------------------------------------------

   procedure Equal (Data_1  : in     Scalar_Array;
                    Data_2  : in     Scalar_Array;
                    Mean_1  :    out Scalar;
                    Mean_2  :    out Scalar;
                    P_Value :    out Probability);

   ---------------------------------------------------------------------------

   function P_Equal (Data_1 : in     Scalar_Array;
                     Data_2 : in     Scalar_Array) return Probability;

   ---------------------------------------------------------------------------

   procedure Equal (Data_1  : in     Scalar_Array;
                    Data_2  : in     Scalar := 0.0;
                    Mean_1  :    out Scalar;
                    P_Value :    out Probability);

   ---------------------------------------------------------------------------

   function P_Equal (Data_1 : in     Scalar_Array;
                     Data_2 : in     Scalar := 0.0) return Probability;

   ---------------------------------------------------------------------------

   procedure High_Low (Data_1   : in     Scalar_Array;
                       Data_2   : in     Scalar_Array;
                       P_1_High :    out Probability;
                       P_2_High :    out Probability);

   ---------------------------------------------------------------------------

end Generic_Students_T_Test;
