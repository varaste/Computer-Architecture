library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use Ieee.numeric_std.all;

entity AC is
    Port ( clk  :   in std_logic; 
           load :   in STD_LOGIC;
           inc :    in STD_LOGIC;
           rst :    in STD_LOGIC;
           sr  :    in STD_LOGIC;
           sl  :    in STD_LOGIC;
           input  : in  unsigned (7 downto 0);
           output : out unsigned (7 downto 0));
end AC;

architecture Behavioral of AC is

signal temp : unsigned ( 7 downto 0 ) ;

begin
  output <= temp ;
  process ( clk ) 
   begin 
     if clk'event and clk = '1' then
       if load = '1' then 
          temp <= input ;
       elsif inc = '1' then 
          temp <= temp + "00000001";
       elsif rst ='1' then
          temp <= ( others => '0') ;
       elsif sr = '1' then
          temp <= temp srl 1; 
       elsif sl = '1' then
          temp <= temp sll 1;
       else 
          temp <= temp;           
     end if ;
   end if ;  
  end process ;
     
 
end Behavioral;
