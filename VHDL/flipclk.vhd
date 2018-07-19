library IEEE;
use IEEE.std_logic_1164.all;

entity flipclk is
    port (
        d,rst: in STD_LOGIC;
        clk: in STD_LOGIC;
        q: out STD_LOGIC
        );
end flipclk;
architecture flipclk_arch of flipclk is
begin
process (clk,rst)
begin
   if rst='0' then
   q<='0';
   elsif (clk'event and clk='1') then
       q<=d;
   end if;    
end process;
end flipclk_arch;