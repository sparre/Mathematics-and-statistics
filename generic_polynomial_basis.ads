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

generic

   type Scalar is digits <>;

package Generic_Polynomial_Basis is

   ---------------------------------------------------------------------------
   --  function Order_0:

   function Order_0 (Item : in Scalar) return Scalar;

   ---------------------------------------------------------------------------
   --  function Order_1:

   function Order_1 (Item : in Scalar) return Scalar;

   ---------------------------------------------------------------------------
   --  function Order_2:

   function Order_2 (Item : in Scalar) return Scalar;

   ---------------------------------------------------------------------------
   --  function Order_3:

   function Order_3 (Item : in Scalar) return Scalar;

   ---------------------------------------------------------------------------
   --  function Order_4:

   function Order_4 (Item : in Scalar) return Scalar;

   ---------------------------------------------------------------------------
   --  function Order_5:

   function Order_5 (Item : in Scalar) return Scalar;

   ---------------------------------------------------------------------------

end Generic_Polynomial_Basis;
