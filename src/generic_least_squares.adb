------------------------------------------------------------------------------
--
--  package Generic_Least_Squares (body)
--
------------------------------------------------------------------------------
--  Update information:
--
--  2000.10.02 (Jacob Sparre Andersen)
--    Written.
--
--  (Insert additional update information above this line.)
------------------------------------------------------------------------------

package body Generic_Least_Squares is

   ---------------------------------------------------------------------------

   procedure Fit (x, y    : in     Matrices.Scalar_Array;
                  Basis   : in     Function_Array_Type;
                  Weights :    out Matrices.Scalar_Array) is

      use Matrices;

      A : Matrix (N => x'Length, M => Basis'Length);
      B : Matrix (N => x'Length, M => 1);

      Alpha : Matrix (N => Basis'Length, M => Basis'Length);
      Beta  : Matrix (N => Basis'Length, M => 1);

   begin --  Fit
      if x'First = y'First and then x'Last = y'Last
                           and then Basis'First = Weights'First
                           and then Basis'Last = Weights'Last
      then
         for i in x'Range loop
            for j in Basis'Range loop
               Set (A, i, j, Basis (j) (x (i)));
            end loop;
         end loop;

         for i in y'Range loop
            Set (B, i, 1, y (i));
         end loop;

         Alpha := Transpose (A) * A;
         Beta  := Transpose (A) * B;

         Gauss_Jordan (Alpha, Beta);

         for Index in 1 .. Height (Beta) loop
            Weights (Index) := Element (Beta, Index, 1);
         end loop;
      else
         raise Program_Error;
      end if;
   end Fit;

   ---------------------------------------------------------------------------

end Generic_Least_Squares;
