library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity rounder is
    Port (clock 	: in STD_LOGIC;
           in_a		: in  STD_LOGIC_VECTOR(11 downto 0);
           out_r   	: out STD_LOGIC_VECTOR(7 downto 0));
end rounder;

architecture rtl of rounder is

begin
	--Output
    out_r <= in_a(11 downto 5) & (in_a(4) or in_a(3));  

end rtl;







