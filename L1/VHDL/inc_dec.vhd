library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity inc_dec is
    Port ( inc 		: in  STD_LOGIC;
           in_A 	: in  SIGNED (6 downto 0);
           out_Y   	: out STD_LOGIC_VECTOR (6 downto 0));
end inc_dec;

architecture rtl of inc_dec is

signal inc_int, dec_int : SIGNED (6 downto 0);

begin

	inc_int <= in_A + 1;
	dec_int <= in_A - 1;

	--Output
    	out_Y <= std_logic_vector(inc_int) when inc = '1' else std_logic_vector(dec_int);
end rtl;