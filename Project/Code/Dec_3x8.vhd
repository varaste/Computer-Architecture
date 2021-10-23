library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity Dec_3x8 is

    Port ( input          : in  unsigned (2 downto 0);  -- 3-bit input from sequence counter
           output         : out unsigned (7 downto 0)  -- 8-bit output ( O ) to control unit
           );
        
end Dec_3x8;

architecture Behavioral of Dec_3x8 is
      begin
         with input select  output  <=
              "00000001" when "000" , 
              "00000010" when "001" ,
              "00000100" when "010" ,
              "00001000" when "011" ,
              "00010000" when "100" ,
              "00100000" when "101" ,
              "01000000" when "110" ,
              "10000000" when others ;
              
             
end Behavioral;