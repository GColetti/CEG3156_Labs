library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Full_Adder is
    Port ( A 		: in  STD_LOGIC;
           B 		: in  STD_LOGIC;
           C_in 	: in  STD_LOGIC;
           Sum 		: out STD_LOGIC;
           C_out	: out STD_LOGIC);
end Full_Adder;

architecture rtl of Full_Adder is

signal A_Bnot_Cnot, Anot_B_Cnot, Anot_Bnot_C, ABC : STD_LOGIC;
signal AC, BC, AB : STD_LOGIC;

begin

	A_Bnot_Cnot <= A and (not B) and (not C_in);
	Anot_B_Cnot <= (not A) and B and (not C_in);
	Anot_Bnot_C <= (not A) and (not B) and C_in;
	ABC <= A and B and C_in;
	AC <= A and C_in;
	BC <= B and C_in;
	AB <= A and B;
	
	Sum <= A_Bnot_Cnot or Anot_B_Cnot or Anot_Bnot_C or ABC;
	C_out <= AC or BC or AB;

end rtl;