library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux_2to1_32b is
    Port ( 
	sel : in STD_LOGIC;
        a : in STD_LOGIC_VECTOR (31 downto 0);
        b : in STD_LOGIC_VECTOR (31 downto 0);
        o_y : out STD_LOGIC_VECTOR (31 downto 0)
		);
end Mux_2to1_32b;

architecture Behavioral of Mux_2to1_32b is

	begin
		o_y <= 	a when sel = '0' else b;
			
end Behavioral;

