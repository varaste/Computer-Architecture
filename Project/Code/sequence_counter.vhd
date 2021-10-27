library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity sequence_counter is
Port ( reset , clk : in std_logic;
       output      : out unsigned ( 1 downto 0 ));
end sequence_counter;

architecture Behavioral of sequence_counter is
  signal tmp: unsigned (1 downto 0);

begin
process (clk)
begin

 if (clk'event and clk='1') then
   if (reset ='1') then
     tmp <= "00";
     elsif  ( tmp = "11") then
      tmp <= "00";
      else
      tmp <= tmp + "01";
  end if;
   end if ;
 end process;
 output<= tmp;
end Behavioral;