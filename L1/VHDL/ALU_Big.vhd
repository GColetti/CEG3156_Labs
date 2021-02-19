library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU_Big is
    Port ( A 	: in  STD_LOGIC_VECTOR (15 DOWNTO 0);
           B 	: in  STD_LOGIC_VECTOR (15 DOWNTO 0);
	   	   Sub 	: in STD_LOGIC;
           V,Z 	: out  STD_LOGIC;
           Sum 	: out  STD_LOGIC_VECTOR (15 DOWNTO 0));
end ALU_Big;

architecture rtl of ALU_Big is

component Full_Adder is
	port (  A : in STD_LOGIC;
			B : in STD_LOGIC;
			C_in : in STD_LOGIC;
			C_out : out STD_LOGIC;
			Sum : out STD_LOGIC);
end component Full_Adder;

signal carry,sum_int : STD_LOGIC_VECTOR(15 DOWNTO 0);
signal B_add_or_sub : STD_LOGIC_VECTOR(15 DOWNTO 0);


begin

Bit0: component Full_Adder
	port map (A => A(0),
				B => B_add_or_sub(0),
				C_in => Sub,
				Sum => sum_int(0),
				C_out => carry(0)
	);
	
Bit1: component Full_Adder
	port map (A => A(1),
				B => B_add_or_sub(1),
				C_in => carry(0),
				Sum => sum_int(1),
				C_out => carry(1)
	);

Bit2: component Full_Adder
	port map (A => A(2),
				B => B_add_or_sub(2),
				C_in => carry(1),
				Sum => sum_int(2),
				C_out => carry(2)
	);

Bit3: component Full_Adder
	port map (A => A(3),
				B => B_add_or_sub(3),
				C_in => carry(2),
				Sum => sum_int(3),
				C_out => carry(3)
	);

Bit4: component Full_Adder
	port map (A => A(4),
				B => B_add_or_sub(4),
				C_in => carry(3),
				Sum => sum_int(4),
				C_out => carry(4)
	);

Bit5: component Full_Adder
	port map (A => A(5),
				B => B_add_or_sub(5),
				C_in => carry(4),
				Sum => sum_int(5),
				C_out => carry(5)
	);
	
Bit6: component Full_Adder
	port map (A => A(6),
				B => B_add_or_sub(6),
				C_in => carry(5),
				Sum => sum_int(6),
				C_out => carry(6)
	);

Bit7: component Full_Adder
	port map (A => A(7),
				B => B_add_or_sub(7),
				C_in => carry(6),
				Sum => sum_int(7),
				C_out => carry(7)
	);

Bit8: component Full_Adder
	port map (A => A(8),
				B => B_add_or_sub(8),
				C_in => carry(7),
				Sum => sum_int(8),
				C_out => carry(8)
	);

Bit9: component Full_Adder
	port map (A => A(9),
				B => B_add_or_sub(9),
				C_in => carry(8),
				Sum => sum_int(9),
				C_out => carry(9)
	);

Bit10: component Full_Adder
	port map (A => A(10),
				B => B_add_or_sub(10),
				C_in => carry(9),
				Sum => sum_int(10),
				C_out => carry(10)
	);

Bit11: component Full_Adder
	port map (A => A(11),
				B => B_add_or_sub(11),
				C_in => carry(10),
				Sum => sum_int(11),
				C_out => carry(11)
	);

Bit12: component Full_Adder
	port map (A => A(12),
				B => B_add_or_sub(12),
				C_in => carry(11),
				Sum => sum_int(12),
				C_out => carry(12)
	);

Bit13: component Full_Adder
	port map (A => A(13),
				B => B_add_or_sub(13),
				C_in => carry(12),
				Sum => sum_int(13),
				C_out => carry(13)
	);

Bit14: component Full_Adder
	port map (A => A(14),
				B => B_add_or_sub(14),
				C_in => carry(13),
				Sum => sum_int(14),
				C_out => carry(14)
	);

Bit15: component Full_Adder
	port map (A => A(15),
				B => B_add_or_sub(15),
				C_in => carry(14),
				Sum => sum_int(15),
				C_out => carry(15)
	);


--Overflow Flag
V <= (carry(15) XOR carry(14)) or (carry(15) XOR carry(0));

--Zero Flag
Z <= not(sum_int(15) or sum_int(14) or sum_int(13) or sum_int(12) or sum_int(11) or sum_int(10) or sum_int(9) or sum_int(8) or sum_int(7) or sum_int(6) or sum_int(5) or sum_int(4) or sum_int(3) or sum_int(2) or sum_int(1) or sum_int(0));

--Sum
Sum <= sum_int;

--Subtraction (B 2's Comp.)
B_add_or_sub(0) <= (B(0) AND (NOT Sub)) OR ((NOT B(0)) AND Sub);
B_add_or_sub(1) <= (B(1) AND (NOT Sub)) OR ((NOT B(1)) AND Sub);
B_add_or_sub(2) <= (B(2) AND (NOT Sub)) OR ((NOT B(2)) AND Sub);
B_add_or_sub(3) <= (B(3) AND (NOT Sub)) OR ((NOT B(3)) AND Sub);
B_add_or_sub(4) <= (B(4) AND (NOT Sub)) OR ((NOT B(4)) AND Sub);
B_add_or_sub(5) <= (B(5) AND (NOT Sub)) OR ((NOT B(5)) AND Sub);
B_add_or_sub(6) <= (B(6) AND (NOT Sub)) OR ((NOT B(6)) AND Sub);
B_add_or_sub(7) <= (B(7) AND (NOT Sub)) OR ((NOT B(7)) AND Sub);
B_add_or_sub(8) <= (B(8) AND (NOT Sub)) OR ((NOT B(8)) AND Sub);
B_add_or_sub(9) <= (B(9) AND (NOT Sub)) OR ((NOT B(9)) AND Sub);
B_add_or_sub(10) <= (B(10) AND (NOT Sub)) OR ((NOT B(10)) AND Sub);
B_add_or_sub(11) <= (B(11) AND (NOT Sub)) OR ((NOT B(11)) AND Sub);
B_add_or_sub(12) <= (B(12) AND (NOT Sub)) OR ((NOT B(12)) AND Sub);
B_add_or_sub(13) <= (B(13) AND (NOT Sub)) OR ((NOT B(13)) AND Sub);
B_add_or_sub(14) <= (B(14) AND (NOT Sub)) OR ((NOT B(14)) AND Sub);
B_add_or_sub(15) <= (B(15) AND (NOT Sub)) OR ((NOT B(15)) AND Sub);

end rtl;