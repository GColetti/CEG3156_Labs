Library IEEE;
use ieee.std_logic_1164.all;

entity fullAdder1bit is
	port(
	Cin, x, y: IN std_logic; Sum, Carry: OUT std_logic
	);
end fullAdder1bit;

architecture arch_fullAdder1bit of fullAdder1bit is 
begin 
Sum <= x XOR y XOR Cin ;
 Carry <= (x AND y) OR (Cin AND x) OR (Cin AND y) ;
end arch_fullAdder1bit;