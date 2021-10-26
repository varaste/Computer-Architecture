library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use Ieee.numeric_std.all;

entity PC is
    Port ( clk  :   in std_logic; 
           load :   in STD_LOGIC;
           inc :    in STD_LOGIC;
           rst :    in STD_LOGIC;
           input  : in  unsigned (9 downto 0);
           output : out unsigned (9 downto 0));
end PC;

architecture Behavioral of PC is

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
       elsif rst ='1' then
          temp <= ( others => '0') ;
       else
          temp <= temp;     
     end if ;
   end if ;  
  end process ;
     
 
end Behavioral;
