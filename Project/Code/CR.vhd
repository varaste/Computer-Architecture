library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use Ieee.numeric_std.all;

entity CR is
    Port ( clk  :   in std_logic; 
           load :   in STD_LOGIC;
           input  : in  unsigned (7 downto 0);
           output : out unsigned (7 downto 0));
end CR;

architecture Behavioral of CR is

signal temp : unsigned ( 7 downto 0 ) ;

begin
  output <= temp ;
  process ( clk ) 
   begin 
     if clk'event and clk = '1' then
       if load = '1' then 
          temp <= input ;     
       else
          temp <= temp;     
     end if ;
   end if ;  
  end process ;
     
 
end Behavioral;
