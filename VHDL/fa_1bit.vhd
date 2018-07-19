library IEEE;
use IEEE.std_logic_1164.all;

entity fa_1bit is
    port (
        a: in STD_LOGIC;
        b: in STD_LOGIC;
        cin: in STD_LOGIC;
        sum: out STD_LOGIC;
        cout: out STD_LOGIC
    );
end fa_1bit;

architecture fa_1bit_arch of fa_1bit is
--component declaration,specifies component interface
        component  ha_1bit  port(x,y :in std_logic;
	                       s,c :out std_logic);
        end component;
--signal declaration
        signal im1, im2, im3 :std_logic;                        
begin 
        ha1: ha_1bit  port map (x=>a, y=>b, s=>im1, c=>im2);      --(1)
        ha2: ha_1bit  port map (x=>im1, y=>cin, s=>sum, c=>im3);  --(2)
        cout <= im2 or im3;					  --(3)  
end fa_1bit_arch;


library ieee;
use ieee.std_logic_1164.all;

entity ha_1bit is
	port (x,y :in std_logic;
	      s,c :out std_logic);
end ha_1bit;
architecture gate_level of ha_1bit is
begin
        s <= x xor y;
        c <= x and y;
end gate_level;