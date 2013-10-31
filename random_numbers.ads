package Random_Numbers is

   procedure Reset;
   --  Reset the global generator.

   function Uniform return Float;
   --  Draw from a uniform distribution between 0 and 1.

   function Gauss return Float;
   --  Draw from a Gaussian distribution.

end Random_Numbers;
