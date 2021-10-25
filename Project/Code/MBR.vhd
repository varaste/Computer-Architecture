library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use Ieee.numeric_std.all;

entity MBR is
    Port ( clk  :   in std_logic; 
           load :   in STD_LOGIC;
           inc :    in STD_LOGIC;
           --rst :    in STD_LOGIC;
           dec :    in STd_LOGIC;
           input  : in  unsigned (15 downto 0);
           output1 : out unsigned ( 15 downto 0 ) ;
           output2 : out unsigned (15 downto 0));
end MBR;

architecture Behavioral of MBR is

signal temp : unsigned ( 15 downto 0 ) ;

begin
  output1 <= temp ;
  output2 <= temp ;
  process ( clk ) 
   begin 
     if clk'event and clk = '1' then
       if load = '1' then 
          temp <= input ;
       elsif inc = '1' then 
          temp <= temp +  "0000000000000001";
--       elsif rst ='1' then
--          temp <= ( others => '0') ;
       elsif dec = '1' then
           temp <= temp - "0000000000000001";
       else
          temp <= temp;     
     end if ;
   end if ;  
  end process ;
     
 
end Behavioral;
