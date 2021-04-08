library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity zero_extend is
    Port ( 
	inic 	: in STD_LOGIC;
        extend 	: out  STD_LOGIC_VECTOR (31 downto 0)
		);
end zero_extend;

architecture rtl of zero_extend is

	begin
		extend <= x"0000000" & "000" & inic;

end rtl;

