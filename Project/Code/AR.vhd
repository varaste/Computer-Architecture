library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use Ieee.numeric_std.all;

entity AR is
    Port ( clk  :   in std_logic; 
           load :   in STD_LOGIC;
           inc :    in STD_LOGIC;
           input  : in  unsigned (9 downto 0);
           output : out unsigned (9 downto 0));
end AR;

architecture Behavioral of AR is

signal temp : unsigned ( 9 downto 0 ) ;

begin
  output <= temp ;
  process ( clk ) 
   begin 
     if clk'event and clk = '1' then
       if load = '1' then 
          temp <= input ;
       elsif inc = '1' then 
          temp <= temp + "0000000001";     
       else
          temp <= temp;     
     end if ;
   end if ;  
  end process ;
     
 
end Behavioral;
