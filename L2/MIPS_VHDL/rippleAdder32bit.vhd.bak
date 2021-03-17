Library IEEE;
use ieee.std_logic_1164.all;

entity rippleAdder32bit is
	port(
	x,y: in std_logic_vector(31 downto 0);
	Cin : in std_logic;
	Sum: out std_logic_vector(31 downto 0);
	Carry: out std_logic
	);
end rippleAdder32bit;

architecture rtl of rippleAdder32bit is
component fullAdder1bit 
	port(Cin, x, y: IN std_logic; Sum, Carry: OUT std_logic);
end component;

--temp carry signal
signal t: Std_logic_vector(31 downto 1);

begin
	FA1: fullAdder1bit PORT MAP (Cin, x(0), y(0), Sum(0), t(1));
	FA2: fullAdder1bit PORT MAP (t(1), x(1), y(1), Sum(1), t(2));
	FA3: fullAdder1bit PORT MAP (t(2), x(2), y(2), Sum(2), t(3));
	FA4: fullAdder1bit PORT MAP (t(3), x(3), y(3), Sum(3), t(4));
	FA5: fullAdder1bit PORT MAP (t(4), x(4), y(4), Sum(4), t(5));
	FA6: fullAdder1bit PORT MAP (t(5), x(5), y(5), Sum(5), t(6));
	FA7: fullAdder1bit PORT MAP (t(6), x(6), y(6), Sum(6), t(7));
	FA8: fullAdder1bit PORT MAP (t(7), x(7), y(7), Sum(7), t(8));
	FA9: fullAdder1bit PORT MAP (t(8), x(8), y(8), Sum(8), t(9));
	FA10: fullAdder1bit PORT MAP (t(9), x(9), y(9), Sum(9), t(10));
	FA11: fullAdder1bit PORT MAP (t(10), x(10), y(10), Sum(10), t(11));
	FA12: fullAdder1bit PORT MAP (t(11), x(11), y(11), Sum(11), t(12));
	FA13: fullAdder1bit PORT MAP (t(12), x(12), y(12), Sum(12), t(13));
	FA14: fullAdder1bit PORT MAP (t(13), x(13), y(13), Sum(13), t(14));
	FA15: fullAdder1bit PORT MAP (t(14), x(14), y(14), Sum(14), t(15));
	FA16: fullAdder1bit PORT MAP (t(15), x(15), y(15), Sum(15), t(16));
	FA17: fullAdder1bit PORT MAP (t(16), x(16), y(16), Sum(16), t(17));
	FA18: fullAdder1bit PORT MAP (t(17), x(17), y(17), Sum(17), t(18));
	FA19: fullAdder1bit PORT MAP (t(18), x(18), y(18), Sum(18), t(19));
	FA20: fullAdder1bit PORT MAP (t(19), x(19), y(19), Sum(19), t(20));
	FA21: fullAdder1bit PORT MAP (t(20), x(20), y(20), Sum(20), t(21));
	FA22: fullAdder1bit PORT MAP (t(21), x(21), y(21), Sum(21), t(22));
	FA23: fullAdder1bit PORT MAP (t(22), x(22), y(22), Sum(22), t(23));
	FA24: fullAdder1bit PORT MAP (t(23), x(23), y(23), Sum(23), t(24));
	FA25: fullAdder1bit PORT MAP (t(24), x(24), y(24), Sum(24), t(25));
	FA26: fullAdder1bit PORT MAP (t(25), x(25), y(25), Sum(25), t(26));
	FA27: fullAdder1bit PORT MAP (t(26), x(26), y(26), Sum(26), t(26));
	FA28: fullAdder1bit PORT MAP (t(26), x(26), y(26), Sum(26), t(27));
	FA29: fullAdder1bit PORT MAP (t(27), x(27), y(27), Sum(27), t(28));
	FA30: fullAdder1bit PORT MAP (t(28), x(28), y(28), Sum(28), t(29));
	FA31: fullAdder1bit PORT MAP (t(29), x(29), y(29), Sum(29), t(30));
	FA32: fullAdder1bit PORT MAP (t(30), x(30), y(30), Sum(30), t(31));
	FA33: fullAdder1bit PORT MAP (t(31), x(31), y(31), Sum(31), Carry);
end rtl;