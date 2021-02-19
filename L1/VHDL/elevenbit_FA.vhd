LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY elevenbitFA IS
	PORT (in_A, in_B 		 	: IN STD_LOGIC_VECTOR(10 downto 0);
		Cin	 	 	 			: IN STD_LOGIC;
		o_Sum			 		: OUT STD_LOGIC_VECTOR(10 downto 0);
		o_C_Out, o_V			: OUT STD_LOGIC);
END elevenbitFA;

ARCHITECTURE struct OF elevenbitFA IS

SIGNAL int_S, int_C : STD_LOGIC_VECTOR(10 downto 0);

Component Full_Adder is
    Port ( A 		: in  STD_LOGIC;
           B 		: in  STD_LOGIC;
           C_in 	: in  STD_LOGIC;
           Sum 		: out STD_LOGIC;
           C_out	: out STD_LOGIC);
end Component;
	
BEGIN
	FA_0: FullAdder
	PORT MAP(
		A => in_A(0), 
		B => in_B(0), 		
		C_in => in_C,
		Sum => int_S(0),
	 	C_out =>int_C(0));

	FA_1: FullAdder
	PORT MAP(
		in_A => in_A(1), 
		in_B => in_B(1), 		
		in_C => int_C(0),
		o_Result => int_S(1),
	 	o_CarryOut =>int_C(1) );

	FA_2: FullAdder
	PORT MAP(
		in_A => in_A(2), 
		in_B => in_B(2), 		
		in_C => int_C(1),
		o_Result => int_S(2),
	 	o_CarryOut =>int_C(2) );

	FA_3: FullAdder
	PORT MAP(
		in_A => in_A(3), 
		in_B => in_B(3), 		
		in_C => int_C(2),
		o_Result => int_S(3),
	 	o_CarryOut =>int_C(3) );
	
	FA_4: FullAdder
	PORT MAP(
		in_A => in_A(4), 
		in_B => in_B(4), 		
		in_C => int_C(3),
		o_Result => int_S(4),
	 	o_CarryOut =>int_C(4) );

	FA_5: FullAdder
	PORT MAP(
		in_A => in_A(5), 
		in_B => in_B(5), 		
		in_C => int_C(4),
		o_Result => int_S(5),
	 	o_CarryOut =>int_C(5) );

	FA_6: FullAdder
	PORT MAP(
		in_A => in_A(6), 
		in_B => in_B(6), 		
		in_C => int_C(5),
		o_Result => int_S(6),
	 	o_CarryOut =>int_C(6) );

	FA_7: FullAdder
	PORT MAP(
		in_A => in_A(7), 
		in_B => in_B(7), 		
		in_C => int_C(6),
		o_Result => int_S(7),
	 	o_CarryOut =>int_C(7) );

	FA_8: FullAdder
	PORT MAP(
		in_A => in_A(8), 
		in_B => in_B(8), 		
		in_C => int_C(7),
		o_Result => int_S(8),
	 	o_CarryOut =>int_C(8) );

	FA_9: FullAdder
	PORT MAP(
		in_A => in_A(9), 
		in_B => in_B(9), 		
		in_C => int_C(8),
		o_Result => int_S(9),
	 	o_CarryOut =>int_C(9) );
	
	FA_block10: FullAdder
	PORT MAP(
		in_A => in_A(10), 
		in_B => in_B(10), 		
		in_C => int_C(9),
		o_Result => int_S(10),
	 	o_CarryOut =>int_C(10) );

	--Output driver
	o_Sum 	<= int_S;
	o_C_Out <= int_C(10);
	o_V 	<= int_C(10) XOR int_C(9);

END struct;