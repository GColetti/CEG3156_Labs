LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity mux4 is
  port(i0, i1, i2, i3, s0, s1 : IN STD_LOGIC; y : OUT STD_LOGIC);
end mux4;

architecture rtl of mux4 is
  signal a1, b1, c1, d1 : STD_LOGIC;
begin
    a1 <= i0 and not(s1) and not(s0);
    b1 <= i1 and not(s1) and s0;
    c1 <= i2 and s1 and not(s0);
    d1 <= i3 and s1 and s0;
    y <= a1 or b1 or c1 or d1;
end rtl;
