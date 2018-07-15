
Entity  buffer1 is
port	(a : in bit ;
	 b : in bit ;
	 c : in bit ;
 	 y1: buffer bit ; 
 	 y2: out bit);
end ;	

architecture dataflow of  buffer1 is
begin
        y1<= a  and  b  ;
        y2<= y1 or  c  ;
end dataflow;
