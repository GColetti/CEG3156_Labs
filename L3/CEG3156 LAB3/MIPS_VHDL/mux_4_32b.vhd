library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_4_32b is
    Port ( 
		sel : in  STD_LOGIC_VECTOR (1 downto 0);
        a : in  STD_LOGIC_VECTOR (31 downto 0);
        b : in  STD_LOGIC_VECTOR (31 downto 0);
        c : in  STD_LOGIC_VECTOR (31 downto 0);
        d : in  STD_LOGIC_VECTOR (31 downto 0);
        o_y : out  STD_LOGIC_VECTOR (31 downto 0)
		);
end mux_4_32b;

architecture Behavioral of mux_4_32b is

	begin
		o_y <= 	a when (sel = "00") else
				b when (sel = "01") else
				c when (sel = "10") else
				d;

end Behavioral;

