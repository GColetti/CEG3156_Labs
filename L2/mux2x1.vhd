library IEEE;
use IEEE.Std_Logic_1164.all;

entity mux2x1 is 
	port( v1, v2 : in std_logic;
	sel : in std_logic;
	output: out std_logic);
	end mux2x1;
architecture arch_mux2x1 of mux2x1 is 
signal muxout, val1, val2, muxsel : std_logic;
begin 
val1<=v1;
val2<=v2;
muxsel<=sel;
muxout<=(muxsel AND val1) or (muxsel AND (not val2)) or (val1 AND val2);
output<=muxout;
end arch_mux2x1;