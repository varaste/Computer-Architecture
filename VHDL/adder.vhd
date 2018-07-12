entity adder_int is
port (a,b:in integer range 0 to 7;
		c:out integer range 0 to 15);
end;
architecture behave of adder_int is
begin
	c<=a+b;
end;