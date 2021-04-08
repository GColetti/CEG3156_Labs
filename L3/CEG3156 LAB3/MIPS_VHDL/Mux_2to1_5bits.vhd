library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux_2to1_5bits is
    Port ( 
	sel : in  STD_LOGIC;
        a : in  STD_LOGIC_VECTOR (4 downto 0);
        b : in  STD_LOGIC_VECTOR (4 downto 0);
        o_y : out  STD_LOGIC_VECTOR (4 downto 0)
		);
end Mux_2to1_5bits;

architecture rtl of Mux_2to1_5bits is

	begin
		o_y <= 	a when sel ='0' else b;

end rtl;
