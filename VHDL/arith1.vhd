library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;	-- (1)

entity arith1 is
port(
	a, b :in std_logic_vector(3 downto 0);
	q : out std_logic_vector(3 downto 0)
	);
end;

architecture behavior of arith1 is
begin
	q <= signed(a) + signed(b);  	--(2)
end;
