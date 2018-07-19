library IEEE;
use IEEE.std_logic_1164.all;

entity flipwait is
    port (
        clk: in STD_LOGIC;
        d: in STD_LOGIC;
        q: out STD_LOGIC
    );
end flipwait;

architecture flipwait_arch of flipwait is
begin
   process
      begin
         wait until clk='1';
         q<=d;
   end process;      
end flipwait_arch;