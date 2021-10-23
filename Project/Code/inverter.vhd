library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use Ieee.numeric_std.all;

entity inverter is
    Port ( input  : in unsigned (7 downto 0);
           output : out unsigned (7 downto 0));
end inverter;

architecture Behavioral of inverter is

begin
output <= not input ;

end Behavioral;
