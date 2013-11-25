------------------------------------------------------------------------------
--
--  package Generic_Measurement_Values (body)
--
--  Package for handling values with limited measurement ranges.
--
------------------------------------------------------------------------------
--  Update information:
--
--  2004.07.11 (Jacob Sparre Andersen)
--    Written.
--
--  2004.07.16 (Jacob Sparre Andersen)
--    Added the posibility that measurements are undefined.
--
--  (Insert additional update information above this line.)
------------------------------------------------------------------------------
--  Standard packages:

------------------------------------------------------------------------------
--  Other packages:

------------------------------------------------------------------------------

package body Generic_Measurement_Values is

   function "+" (Left  : in Measurement;
                 Right : in Measurement) return Measurement is
      --  Excessive cyclomatic complexity:
      --  Would a look-up table be easier to understand?
   begin
      case Left.As is
         when Below =>
            case Right.As is
               when Below =>
                  return (As    => Below,
                          Value => Left.Value + Right.Value);
               when Exact =>
                  return (As    => Below,
                          Value => Left.Value + Right.Value);
               when Above =>
                  return (As => Undefined);
               when Undefined =>
                  return (As => Undefined);
            end case;
         when Exact =>
            case Right.As is
               when Below =>
                  return (As    => Below,
                          Value => Left.Value + Right.Value);
               when Exact =>
                  return (As    => Exact,
                          Value => Left.Value + Right.Value);
               when Above =>
                  return (As    => Above,
                          Value => Left.Value + Right.Value);
               when Undefined =>
                  return (As => Undefined);
            end case;
         when Above =>
            case Right.As is
               when Below =>
                  return (As => Undefined);
               when Exact =>
                  return (As    => Above,
                          Value => Left.Value + Right.Value);
               when Above =>
                  return (As    => Above,
                          Value => Left.Value + Right.Value);
               when Undefined =>
                  return (As => Undefined);
            end case;
         when Undefined =>
            return (As => Undefined);
      end case;
   end "+";

   function "+" (Left  : in Scalar;
                 Right : in Measurement) return Measurement is
   begin
      case Right.As is
         when Below =>
            return (As    => Below,
                    Value => Left + Right.Value);
         when Exact =>
            return (As    => Exact,
                    Value => Left + Right.Value);
         when Above =>
            return (As    => Above,
                    Value => Left + Right.Value);
         when Undefined =>
            return (As => Undefined);
      end case;
   end "+";

   function "+" (Left  : in Measurement;
                 Right : in Scalar) return Measurement is
   begin
      case Left.As is
         when Below =>
            return (As    => Below,
                    Value => Left.Value + Right);
         when Exact =>
            return (As    => Exact,
                    Value => Left.Value + Right);
         when Above =>
            return (As    => Above,
                    Value => Left.Value + Right);
         when Undefined =>
            return (As => Undefined);
      end case;
   end "+";

   function "-" (Right : in Limit) return Limit is
   begin
      case Right is
         when Below =>
            return Above;
         when Exact =>
            return Exact;
         when Above =>
            return Below;
         when Undefined =>
            return Undefined;
      end case;
   end "-";

   function "-" (Left  : in Measurement;
                 Right : in Measurement) return Measurement is
      --  Excessive cyclomatic complexity:
      --  Would a look-up table be easier to understand?
   begin
      case Left.As is
         when Below =>
            case Right.As is
               when Below =>
                  return (As => Undefined);
               when Exact =>
                  return (As    => Below,
                          Value => Left.Value - Right.Value);
               when Above =>
                  return (As    => Below,
                          Value => Left.Value - Right.Value);
               when Undefined =>
                  return (As => Undefined);
            end case;
         when Exact =>
            case Right.As is
               when Below =>
                  return (As    => Above,
                          Value => Left.Value - Right.Value);
               when Exact =>
                  return (As    => Exact,
                          Value => Left.Value - Right.Value);
               when Above =>
                  return (As    => Below,
                          Value => Left.Value - Right.Value);
               when Undefined =>
                  return (As => Undefined);
            end case;
         when Above =>
            case Right.As is
               when Below =>
                  return (As    => Above,
                          Value => Left.Value - Right.Value);
               when Exact =>
                  return (As    => Above,
                          Value => Left.Value - Right.Value);
               when Above =>
                  return (As => Undefined);
               when Undefined =>
                  return (As => Undefined);
            end case;
         when Undefined =>
            return (As => Undefined);
      end case;
   end "-";

   function "-" (Left  : in Scalar;
                 Right : in Measurement) return Measurement is
   begin
      case Right.As is
         when Below =>
            return (As    => Above,
                    Value => Left - Right.Value);
         when Exact =>
            return (As    => Exact,
                    Value => Left - Right.Value);
         when Above =>
            return (As    => Below,
                    Value => Left - Right.Value);
         when Undefined =>
            return (As => Undefined);
      end case;
   end "-";

   function "-" (Left  : in Measurement;
                 Right : in Scalar) return Measurement is
   begin
      case Left.As is
         when Below =>
            return (As    => Below,
                    Value => Left.Value - Right);
         when Exact =>
            return (As    => Exact,
                    Value => Left.Value - Right);
         when Above =>
            return (As    => Above,
                    Value => Left.Value - Right);
         when Undefined =>
            return (As => Undefined);
      end case;
   end "-";

   function To_Scalar (Item : in Measurement) return Scalar is
   begin
      if Item.As = Exact then
         return Item.Value;
      else
         raise Not_An_Exact_Measurement;
      end if;
   end To_Scalar;

end Generic_Measurement_Values;
