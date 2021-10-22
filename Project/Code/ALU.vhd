library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
port ( A      : in  unsigned ( 7 downto 0 );
       B      : in  unsigned ( 7 downto 0 );
       opcode : in  unsigned ( 3 downto 0 );
       cf     : out std_logic;
       zf     : out std_logic;
       O      : out unsigned ( 7 downto 0 )
       );
end ALU;      
 architecture Behave of ALU is 
  signal tmp : unsigned ( 8 downto 0 );
  signal A1 , B1 : unsigned ( 8 downto 0 );
  begin
      O <= tmp (7 downto 0 );
      A1 <= '0' & A ;
      B1 <= '0' & B ;
      with opcode  select tmp  <= 
                         tmp       when "0000" ,
                        (A1 + B1)    when "0001" , 
                        (A1 - B1)    when "0010" , -- A <= AC
                        (A1 and B1 ) when "0011" , 
                        (A1 or  B1 ) when "0100" , 
                        (A1 xor B1 ) when others ; 
                               
   process ( tmp ) 
     begin 
        if tmp = "000000000" then
           
           zf <= '1';
        
        else
           
           zf <= '0';  
           
        end if;     
        
        if tmp(8) = '1' then 
           
           cf <= '1';
           
        else
           
           cf <= '0';  
        
        end if ;
     end process ;                                    
   end Behave ;                            