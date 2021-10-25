library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity mux_2x1_16bit is
 Port (A : in  unsigned(15 downto 0 );
       B : in  unsigned(15 downto 0 );
       S : in  std_logic;
       O : out unsigned(15 downto 0 )
 );
end mux_2x1_16bit;

architecture Behavioral of mux_2x1_16bit is
begin
      O <= A when S = '0' else
           B;
     
end Behavioral;