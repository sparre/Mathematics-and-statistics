------------------------------------------------------------------------------
--
--  package Generic_Polynomial_Basis (spec)
--
------------------------------------------------------------------------------
--  Update information:
--
--  2000.10.02 (Jacob Sparre Andersen)
--    Written.
--
--  (Insert additional update information above this line.)
------------------------------------------------------------------------------

package body Generic_Polynomial_Basis is

   ---------------------------------------------------------------------------
   --  function Order_0:

   function Order_0 (Item : in Scalar) return Scalar is

   begin
      return 1.0;
   end Order_0;

   ---------------------------------------------------------------------------
   --  function Order_1:

   function Order_1 (Item : in Scalar) return Scalar is

   begin
      return Item;
   end Order_1;

   ---------------------------------------------------------------------------
   --  function Order_2:

   function Order_2 (Item : in Scalar) return Scalar is

   begin
      return Item ** 2;
   end Order_2;

   ---------------------------------------------------------------------------
   --  function Order_3:

   function Order_3 (Item : in Scalar) return Scalar is

   begin
      return Item ** 3;
   end Order_3;

   ---------------------------------------------------------------------------
   --  function Order_4:

   function Order_4 (Item : in Scalar) return Scalar is

   begin
      return Item ** 4;
   end Order_4;

   ---------------------------------------------------------------------------
   --  function Order_5:

   function Order_5 (Item : in Scalar) return Scalar is

   begin
      return Item ** 5;
   end Order_5;

   ---------------------------------------------------------------------------

end Generic_Polynomial_Basis;
