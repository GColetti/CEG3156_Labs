library IEEE;
use IEEE.Std_Logic_1164.all;
use ieee.numeric_std.all;

entity aluMUX is 
	port( in1, in2, in3, in4: in std_logic_vector(31 downto 0);
			control: in std_logic_vector(1 downto 0);
			muxOUT: out std_logic_vector(31 downto 0));
			end aluMUX;
architecture aluMUX_arch of aluMUX is 
type t_array_mux is array (0 to 3) of std_logic_vector(31 downto 0);
signal array_mux  : t_array_mux;
begin
  array_mux(0)  <= in1;
  array_mux(1)  <= in2;
  array_mux(2)  <= in3;
  array_mux(3)  <= in4;
  muxOUT <= array_mux(to_integer(unsigned(control)));
  
end aluMUX_arch;