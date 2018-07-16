library IEEE;
use IEEE.std_logic_1164.all;

entity flipt is
    port (
        t,clk: in STD_LOGIC;
        q: buffer STD_LOGIC
    );
end flipt;

architecture flipt_arch of flipt is
begin
process (clk)
begin
	if (clk'event and clk='1') then
		if t='1' then
		q<=not(q);
		else
		q<=q;
		end if;
	end if;
end process;
end flipt_arch;