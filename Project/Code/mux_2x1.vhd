library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity mux_2x1_10bit is
 Port (A : in  unsigned(9 downto 0 );
       B : in  unsigned(9 downto 0 );
       S : in  std_logic;
       O : out unsigned(9 downto 0 )
 );
end mux_2x1_10bit;

architecture Behavioral of mux_2x1_10bit is
begin
      O <= A when S = '0' else
           B;
     
end Behavioral;