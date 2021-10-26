library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RAM is
    Port ( clk          :  in  STD_LOGIC;
           address      :  in  unsigned (9 downto 0);
           wen          :  in  STD_LOGIC;
           data_in      :  in  unsigned (15 downto 0);
           data_out     :  out unsigned (15 downto 0)
           );
end RAM;

architecture Behavioral of RAM is

subtype Ram_block  is unsigned (15 downto 0);
type    Mem is array (0 to 1023) of Ram_block;
-----------------------------------
begin
process(clk)
    variable RAM : Mem := (others => (others => '0'));
begin     
    if clk'event and clk = '1' then
       if  wen = '1' then
           RAM(to_integer(address))(9 downto 0) := data_in(9 downto 0 ) ;
       else
           data_out <= RAM(to_integer(address));    
      end if;
    end if; 
end process;

end Behavioral;