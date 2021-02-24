LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY elevenbit_FA IS
	PORT (in_A, in_B 		 	: IN STD_LOGIC_VECTOR(10 downto 0);
		Cin	 	 	 			: IN STD_LOGIC;
		o_Sum			 		: OUT STD_LOGIC_VECTOR(10 downto 0);
		o_C_Out, o_V			: OUT STD_LOGIC);
END elevenbit_FA;

ARCHITECTURE rtl OF elevenbit_FA IS

SIGNAL int_S, int_C : STD_LOGIC_VECTOR(10 downto 0);

Component Full_Adder is
    Port ( A 		: in  STD_LOGIC;
           B 		: in  STD_LOGIC;
           C_in 	: in  STD_LOGIC;
           Sum 		: out STD_LOGIC;
           C_out	: out STD_LOGIC);
end Component;
	
BEGIN
	FA_0: Full_Adder
	PORT MAP(
		A => in_A(0), 
		B => in_B(0), 		
		C_in => Cin,
		Sum => int_S(0),
	 	C_out =>int_C(0));

	FA_1: Full_Adder
	PORT MAP(
		A => in_A(1), 
		B => in_B(1), 		
		C_in => int_C(0),
		Sum => int_S(1),
	 	C_out =>int_C(1));

	FA_2: Full_Adder
	PORT MAP(
		A => in_A(2), 
		B => in_B(2), 		
		C_in => int_C(1),
		Sum => int_S(2),
	 	C_out =>int_C(2) );

	FA_3: Full_Adder
	PORT MAP(
		A => in_A(3), 
		B => in_B(3), 		
		C_in => int_C(2),
		Sum => int_S(3),
	 	C_out =>int_C(3) );
	
	FA_4: Full_Adder
	PORT MAP(
		A => in_A(4), 
		B => in_B(4), 		
		C_in => int_C(3),
		Sum => int_S(4),
	 	C_out =>int_C(4) );

	FA_5: Full_Adder
	PORT MAP(
		A => in_A(5), 
		B => in_B(5), 		
		C_in => int_C(4),
		Sum => int_S(5),
	 	C_out =>int_C(5) );

	FA_6: Full_Adder
	PORT MAP(
		A => in_A(6), 
		B => in_B(6), 		
		C_in => int_C(5),
		Sum => int_S(6),
	 	C_out =>int_C(6) );

	FA_7: Full_Adder
	PORT MAP(
		A => in_A(7), 
		B => in_B(7), 		
		C_in => int_C(6),
		Sum => int_S(7),
	 	C_out =>int_C(7) );

	FA_8: Full_Adder
	PORT MAP(
		A => in_A(8), 
		B => in_B(8), 		
		C_in => int_C(7),
		Sum => int_S(8),
	 	C_out =>int_C(8) );

	FA_9: Full_Adder
	PORT MAP(
		A => in_A(9), 
		B => in_B(9), 		
		C_in => int_C(8),
		Sum => int_S(9),
	 	C_out =>int_C(9) );
	
	FA_10: Full_Adder
	PORT MAP(
		A => in_A(10), 
		B => in_B(10), 		
		C_in => int_C(9),
		Sum => int_S(10),
	 	C_out =>int_C(10));

	--Output driver
	o_Sum 	<= int_S;
	o_C_Out <= int_C(10);
	o_V 	<= int_C(10) XOR int_C(9);

END rtl;