library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use Ieee.numeric_std.all;

entity I1_reg is
    Port ( clk    :   in  std_logic; 
           load   :   in  std_logic;
           input  :   in  std_logic;
           output :   out std_logic
           );
end I1_reg;

architecture Behavioral of I1_reg is

signal temp : std_logic ;

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
