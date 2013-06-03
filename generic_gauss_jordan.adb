------------------------------------------------------------------------------
--
--  procedure Generic_Gauss_Jordan (body)
--
--  Gauss-Jordan elimination implemented as in Numerical Recipes.
--
------------------------------------------------------------------------------
--  Update information:
--
--  2000.10.02 (Jacob Sparre Andersen)
--    Written.
--
--  2000.10.05 (Jacob Sparre Andersen)
--    Corrected some errors.
--
--  (Insert additional update information above this line.)
------------------------------------------------------------------------------

procedure Generic_Gauss_Jordan (A : in out Matrices.Matrix;
                                B : in out Matrices.Matrix) is

   use Matrices;

   Singular_Matrix : exception;

   n : constant Positive := Width (A);
   m : constant Positive := Width (B);

   ipiv   : array (1 .. n) of Natural;
   pivinv : Scalar;

   big        : Scalar;
   irow, icol : Positive := 1;

   dum : Scalar;

   indxc, indxr : array (1 .. n) of Natural;

begin --  Generic_Gauss_Jordan
   if Width (A) /= Height (A) then
      raise Mismatching_Dimensions;
   elsif Height (A) /= Height (B) then
      raise Mismatching_Dimensions;
   else
      ipiv := (others => 0);

      for i in 1 .. n loop
         big := 0.0;

         for j in 1 .. n loop
            if ipiv (j) /= 1 then
               for k in 1 .. n loop
                  if ipiv (k) = 0 then
                     if abs Element (A, j, k) >= big then
                        big := Element (A, j, k);
                        irow := j;
                        icol := k;
                     end if;
                  elsif ipiv (k) > 1 then
                     raise Singular_Matrix;
                  end if;
               end loop;
            end if;
         end loop;

         ipiv (icol) := ipiv (icol) + 1;

         if irow /= icol then
            for l in 1 .. n loop
               dum := Element (A, irow, l);
               Set (A, irow, l, Element (A, icol, l));
               Set (A, icol, l, dum);
            end loop;

            for l in 1 .. m loop
               dum := Element (B, irow, l);
               Set (B, irow, l, Element (B, icol, l));
               Set (B, icol, l, dum);
            end loop;
         end if;

         indxr (i) := irow;
         indxc (i) := icol;

         if Element (A, icol, icol) = 0.0 then
            raise Singular_Matrix;
         end if;

         pivinv := 1.0 / Element (A, icol, icol);
         Set (A, icol, icol, 1.0);

         for l in 1 .. n loop
            Set (A, icol, l, Element (A, icol, l) * pivinv);
         end loop;

         for l in 1 .. m loop
            Set (B, icol, l, Element (B, icol, l) * pivinv);
         end loop;

         for ll in 1 .. n loop
            if ll /= icol then
               dum := Element (A, ll, icol);
               Set (A, ll, icol, 0.0);

               for l in 1 .. n loop
                  Set (A, ll, l,
                       Element (A, ll, l) - Element (A, icol, l) * dum);
               end loop;

               for l in 1 .. m loop
                  Set (B, ll, l,
                       Element (B, ll, l) - Element (B, icol, l) * dum);
               end loop;
            end if;
         end loop;
      end loop;

      for l in reverse 1 .. n loop
         if indxr (l) /= indxc (l) then
            for k in 1 .. n loop
               dum := Element (A, k, indxr (l));
               Set (A, k, indxr (l), Element (A, k, indxc (l)));
               Set (A, k, indxc (l), dum);
            end loop;
         end if;
      end loop;
   end if;
end Generic_Gauss_Jordan;
