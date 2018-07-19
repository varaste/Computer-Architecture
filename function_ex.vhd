--
--*******Defining  and using function******

library ieee;
use ieee.std_logic_1164.all;
entity function_ex is  
   port(a,b,c:in std_logic;
          cout:out std_logic);
end entity;
architecture behavior of function_ex is
--declaring function of carry        
function carry(bit1,bit2,bit3:in std_logic) return std_logic is
variable result:std_logic;
begin
result:=(bit1 AND bit2) OR (bit1 AND bit3) OR (bit2 AND bit3);
return result;
end carry;
--end declaring
begin
cout<=carry(a,b,c);	--(1)
end architecture;