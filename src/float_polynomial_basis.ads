------------------------------------------------------------------------------
--
--  package Float_Polynomial_Basis (spec)
--
------------------------------------------------------------------------------
--  Update information:
--
--  2000.10.02 (Jacob Sparre Andersen)
--    Written.
--
--  (Insert additional update information above this line.)
------------------------------------------------------------------------------

with Generic_Polynomial_Basis;

package Float_Polynomial_Basis is
  new Generic_Polynomial_Basis (Scalar => Float);
