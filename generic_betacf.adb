function Generic_Betacf (A, B, X : Scalar) return Scalar is
   Qap, Qam, Qab, Em, Tem, D : Scalar;
   Bz                        : Scalar;
   Bm                        : Scalar := 1.0;
   Bp, Bpp                   : Scalar;
   Az, Am                    : Scalar := 1.0;
   Ap, App, Aold             : Scalar;
begin
   Qab := A + B;
   Qap := A + 1.0;
   Qam := A - 1.0;
   Bz := 1.0 - Qab * X /Qap;

   for M in 1 .. Itmax loop
      Em := Scalar (M);
      Tem := Em + Em;
      D := Em * (B - Em) * X / ((Qam + Tem) * (A + Tem));
      Ap := Az + D * Am;
      Bp := Bz + D * Bm;
      D := -(A + Em) * (Qab + Em) * X / ((Qap + Tem) * (A + Tem));
      App := Ap + D * Az;
      Bpp := Bp + D * Bz;
      Aold := Az;
      Am := Ap / Bpp;
      Bm := Bp / Bpp;
      Az := App / Bpp;
      Bz := 1.0;

      if abs (Az - Aold) < EPS * abs (Az) then
         return Az;
      end if;
   end loop;

   raise Constraint_Error;
end Generic_Betacf;
