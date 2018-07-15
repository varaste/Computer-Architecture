library ieee;
use ieee.std_logic_1164.all;
entity counter_int is
    port (clk:in std_logic;
           count:out Integer range 0 to 255);
end counter_int;
architecture behavioral of counter_int is
    begin
counter:process(clk)
        variable cnt:Integer range 0 to 255;	--(1)
        begin
         if (clk'event AND clk='1')then
		 cnt:=cnt+1;				--(2)
		 end if;
		count<=cnt;
		end process;
end;