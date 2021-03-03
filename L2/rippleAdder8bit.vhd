Library IEEE;
use ieee.std_logic_1164.all;

entity rippleAdder8bit is
	port(
	x,y: in std_logic_vector(7 downto 0);
	Cin : in std_logic;
	Sum: out std_logic_vector(7 downto 0);
	Carry: out std_logic
	);
end rippleAdder8bit;
architecture arch_rippleAdder8bit of rippleAdder8bit is
component fullAdder1bit 
port(Cin, x, y: IN std_logic; Sum, Carry: OUT std_logic);
end component;
--temp carry signal
signal t: Std_logic_vector(7 downto 1);

begin
FA1: fullAdder1bit PORT MAP (Cin, x(0), y(0), Sum(0), t(1));
FA2: fullAdder1bit PORT MAP (t(1), x(1), y(1), Sum(1), t(2));
FA3: fullAdder1bit PORT MAP (t(2), x(2), y(2), Sum(2), t(3));
FA4: fullAdder1bit PORT MAP (t(3), x(3), y(3), Sum(3), t(4));
FA5: fullAdder1bit PORT MAP (t(4), x(4), y(4), Sum(4), t(5));
FA6: fullAdder1bit PORT MAP (t(5), x(5), y(5), Sum(5), t(6));
FA7: fullAdder1bit PORT MAP (t(6), x(6), y(6), Sum(6), t(7));
FA8: fullAdder1bit PORT MAP (t(7), x(7), y(7), Sum(7), Carry);
end arch_rippleAdder8bit;