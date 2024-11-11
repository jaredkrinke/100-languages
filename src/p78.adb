with Ada.Containers.Indefinite_Vectors;
with Ada.Text_IO;

use Ada.Text_IO;

procedure Main is
   package Integer_Vectors is new Ada.Containers.Indefinite_Vectors (Index_Type => Natural, Element_Type => Integer);
   use Integer_Vectors;

   P : Vector;
   N : Integer := 1;
   Pn : Integer;

   -- Compute partition function using recurrence relation
   function Partition (N : Integer) return Integer is
      K : Integer := 1;
      Sign : Integer := 1;
      Result : Integer := 0;
      Index : Integer;
   begin
      loop
         Index := N - (K * (3 * K - 1) / 2);
         if Index < 0 then
            return Result;
         end if;
         Result := Result + Sign * P.Element (Index);

         Index := N - (K * (3 * K + 1) / 2);
         if Index < 0 then
            return Result;
         end if;
         Result := Result + Sign * P.Element (Index);

         K := K + 1;
         Sign := -1 * Sign;
      end loop;
   end Partition;
begin
   P.Append (1);

   loop
      -- Note: Since we're only adding, we can throw out higher digits
      Pn := Partition (N) rem 1000000;
      P.Append (Pn);
      exit when Pn = 0;
      N := N + 1;
   end loop;

   Put_Line (Integer'Image (N));
end Main;
