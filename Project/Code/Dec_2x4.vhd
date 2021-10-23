library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use Ieee.numeric_std.all;

entity Dec_2x4 is

    Port ( input          : in  unsigned (1 downto 0);  -- 2-bit input from sequence counter
           output         : out unsigned (3 downto 0)  -- 4-bit output ( O ) to control unit
           );
        
end Dec_2x4;

architecture Behavioral of Dec_2x4 is
      begin
         with input select  output  <=
              "0001" when "00" , 
              "0010" when "01" ,
              "0100" when "10" ,
              "1000" when others ;
             
end Behavioral;