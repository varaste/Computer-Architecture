library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use Ieee.numeric_std.all;

entity F_reg is
    Port ( clk    :   in  std_logic; 
           set    :   in  std_logic;
           reset  :   in  std_logic;
           output :   out std_logic
           );
end F_reg;

architecture Behavioral of F_reg is

signal temp : std_logic ;

begin
  output <= temp ;
  process ( clk ) 
   begin 
     if clk'event and clk = '1' then
       if set = '1' then 
          temp <= '1' ;     
       elsif ( reset ='1' ) then
          temp <= '0';
       else
          temp <= temp;        
     end if ;
   end if ;  
  end process ;
     
 
end Behavioral;
