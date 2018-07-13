
library ieee;
use ieee.std_logic_1164.all;
package utility2 is
--Declaration part
--declaraing types
type tshift is (shiftpass, shl, shr,rotl, rotr);--(1)
--declaring constants
constant andop:std_logic_vector(3 downto 0):="0001";--(2)
constant ordop:std_logic_vector(3 downto 0):="0010";--(3)
end utility2;		--(4)

library ieee;
use ieee.std_logic_1164.all;
use work.utility2.all;		--(1)
entity ALU is
   port(a,b:in std_logic_vector(7 downto 0);
         sel:in std_logic_vector(3 downto 0);
         c:out std_logic_vector (7 downto 0));
end;
architecture behavior of ALU is
begin
   process(a,b,sel)
     begin
        if sel=andop then
        c<=a AND b;		--(2)
        else 
        c<=a OR b;      --(3)
        end if;
   end process;
end behavior;      