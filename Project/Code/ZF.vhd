library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use Ieee.numeric_std.all;

entity ZF is
    Port ( clk    :   in std_logic ;
           set    :   in  std_logic;
           output :   out std_logic
           );
end ZF;

architecture Behavioral of ZF is
 begin
 process (clk) 
  begin 
  
  if clk'event and clk = '1' then
     
     if set = '1' then
        
        output <= '1' ;
     
     else 
        
        output <= '0';
   
     end if;    
    
  end if;
end process ;
 
end Behavioral;
