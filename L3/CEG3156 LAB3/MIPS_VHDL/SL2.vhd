library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SL2 is
    Port ( 
		din : in  STD_LOGIC_VECTOR (31 downto 0);
        dout : out  STD_LOGIC_VECTOR (31 downto 0)
		);
end SL2;

architecture rtl of SL2 is

	begin
		dout <= din(29 downto 0) & "00"; --Multiply with 4

end rtl;

