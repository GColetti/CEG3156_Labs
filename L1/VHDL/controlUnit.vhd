  
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY controlUnit IS
	PORT (
		in_Clk, in_resetBar			   					: IN STD_LOGIC; 
		in_ExpDiff				   						: IN STD_LOGIC_VECTOR (6 downto 0);
		in_Exp_F, in_IncDec_V							: IN STD_LOGIC;
		in_sLR_out				  						: IN STD_LOGIC_VECTOR(10 downto 0);
		o_WRFP_A, o_WRFP_B,  o_WRFP_C					: OUT STD_LOGIC;
		o_WRexpDiff, o_WRALU_B,	o_FP_C 		  			: OUT STD_LOGIC; 
		o_Mux_A,o_Mux_B,o_Mux_Exp  						: OUT STD_LOGIC; 
		o_ShR,o_ShR,o_IncDec_En, o_shLR 				: OUT STD_LOGIC;
		o_IncDec_Sel,  o_shLR_Sel 		   				: OUT STD_LOGIC_VECTOR(1 downto 0);
		o_State											: OUT STD_LOGIC_VECTOR(10 downto 0); 
		o_Con											: OUT STD_LOGIC_VECTOR(3 downto 0));
		
END controlUnit;

architecture rtl of controlUnit is 

	--Signals
	signal int_CNT_Sel, int_CNT_En, int_zeroDiff, int_CNT_zero : STD_LOGIC; 
	SIGNAL int_sLR_Z, int_Norm, int_V		: STD_LOGIC; 
	SIGNAL int_x							: STD_LOGIC_VECTOR(3 downto 0);
	SIGNAL int_d 							: STD_LOGIC_VECTOR(10 downto 1);
	SIGNAL int_C, int_Cin					: STD_LOGIC_VECTOR(3 downto 0);	
	SIGNAL int_State, int_N	 				: STD_LOGIC_VECTOR(10 downto 0);
	SIGNAL int_sLR 							: STD_LOGIC_VECTOR(10 downto 0);
	SIGNAL int_CNT_out						: STD_LOGIC_VECTOR(6 downto 0);

	COMPONENT enARdFF_2 IS
		PORT(
			i_resetBar	: IN	STD_LOGIC;
			i_d		: IN	STD_LOGIC;
			i_enable	: IN	STD_LOGIC;
			i_clock		: IN	STD_LOGIC;
			o_q, o_qBar	: OUT	STD_LOGIC);
	END COMPONENT;

	COMPONENT enARdFF_2b IS
		PORT(
			i_resetBar	: IN	STD_LOGIC;
			i_d		: IN	STD_LOGIC;
			i_enable	: IN	STD_LOGIC;
			i_clock		: IN	STD_LOGIC;
			o_q, o_qBar	: OUT	STD_LOGIC);
	END COMPONENT;

	COMPONENT elevenbitFA IS
		PORT (in_A, in_B 		 	: IN STD_LOGIC_VECTOR(10 downto 0);
			Cin	 	 	 			: IN STD_LOGIC;
			o_Sum			 		: OUT STD_LOGIC_VECTOR(10 downto 0);
			o_C_Out, o_V			: OUT STD_LOGIC);
	END COMPONENT;

	COMPONENT seven_bit_counter IS
		PORT(i_resetbar, i_clock, i_en, i_dec 	: IN STD_LOGIC;
			i_load								: IN STD_LOGIC_VECTOR(6 downto 0);
			o_value								: OUT STD_LOGIC_VECTOR(6 downto 0));
	END COMPONENT;


BEGIN 

	int_V <= in_IncDec_V;
	int_ZDiff <= NOT((in_Exp_Diff(6) OR in_Exp_Diff(5) OR in_Exp_Diff(4) OR in_Exp_Diff(3) OR in_Exp_Diff(2) OR in_Exp_Diff(1) OR in_Exp_Diff(0) ) );
	int_shLR_Z <= NOT((int_shLR(10) OR int_shLR(9) OR int_shLR(8) OR int_shLR(7) OR int_shLR(6) OR int_shLR(5) OR int_shLR(4) OR int_shLR(3) OR int_shLR(2) OR int_shLR(1) OR int_shLR(0) ) );
	int_CNT_zero <= NOT((int_CNT_out(6) OR int_CNT_out(5) OR int_CNT_out(4) OR int_CNT_out(3) OR int_CNT_out(2) OR int_CNT_out(1) OR int_CNT_out(0) ) );
	int_Norm <= int_shLR(8) AND NOT(int_shLR(9)) AND NOT(int_shLR(10)) ;

	int_x(0) <= NOT(int_shLR_Z) AND NOT(int_V) AND NOT(int_Norm);
	int_x(1) <= NOT(int_shLR(9)) AND int_shLR(8) AND NOT(int_V) AND int_Norm;
	int_x(2) <= NOT(int_shLR_Z) AND NOT(int_V) AND int_Norm;
	int_x(3) <= NOT(int_shLR(9)) AND NOT(int_shLR(8));

	int_Cin(0) <= int_State(0);
	int_Cin(1) <= int_State(3);
	int_Cin(2) <= int_State(5) OR int_State(6);
	int_Cin(3) <= int_State(7) OR int_State(8);

	int_d(1) <= int_C(0) AND in_Exp_flag AND NOT(int_ZDiff);
	int_d(2) <= int_C(0) AND NOT(in_Exp_flag) AND NOT(int_ZDiff);
	int_d(4) <= int_C(0) AND int_ZDiff;
	int_d(3) <= int_State(1) OR int_State(2) OR (int_C(1) AND NOT(int_CNT_zero) );
	int_d(5) <= int_C(1) AND int_CNT_zero;
	int_d(6) <= int_State(4);
	int_d(7) <= (int_sLR(9) AND int_C(2)) OR ( int_shLR(9) AND int_x(0) AND int_C(3) ) ;
	int_d(8) <= (int_w AND int_C(2) ) OR (int_x(0) AND int_C(3) AND int_x(3) );
	int_d(9) <= (int_x(1) AND int_C(2) ) OR (int_x(2) AND int_C(3) );
	int_d(10) <= (int_C(3) AND int_shLR_zero) OR int_State(10) ; 

	int_N(0) <=in_shLR_out(0) XOR in_shLR_out(10);
	int_N(1) <=in_shLR_out(1) XOR in_shLR_out(10);
	int_N(2) <=in_shLR_out(2) XOR in_shLR_out(10);
	int_N(3) <=in_shLR_out(3) XOR in_shLR_out(10);
	int_N(4) <=in_shLR_out(4) XOR in_shLR_out(10);
	int_N(5) <=in_shLR_out(5) XOR in_shLR_out(10);
	int_N(6) <=in_shLR_out(6) XOR in_shLR_out(10);
	int_N(7) <=in_shLR_out(7) XOR in_shLR_out(10);
	int_N(8) <=in_shLR_out(8) XOR in_shLR_out(10);
	int_N(9) <=in_shLR_out(9) XOR in_shLR_out(10);
	int_N(10) <=in_shLR_out(10) XOR in_shLR_out(10);

	int_CNT_Sel <= int_State(1) OR int_State(2);
	int_CNT_En  <= int_State(1) OR int_State(2) OR int_State(3);

	Count : seven_bit_counter
	PORT MAP(
		i_resetBar => in_resetbar
		i_clock	=> in_Clk
		i_en => int_CNT_En
		i_dec => int_CNT_Sel
		i_load	=> in_ExpDiff
		o_Value => int_CNT_out


	Add: elevenbitFA
	PORT MAP (in_A => int_N,
		in_B => "00000000000",
		Cin	=> in_shLR_out(10),
		o_Sum => int_shLR		 	
	END elevenbitFA;

	DFF_s0 : enARdFF_2b -- Reset => 1
	PORT MAP(
		i_resetBar => in_resetbar,
		i_d		=>'0',
		i_enable =>'1',
		i_clock	=>in_clk,
		o_q		=>int_State(0));

	DFF_s1 : enARdFF_2
	PORT MAP(
		i_resetBar	=>in_resetbar,
		i_d		=> int_d(1),
		i_enable	=>'1',
		i_clock		=>in_clk,
		o_q		=>int_State(1));

	DFF_s2 : enARdFF_2
	PORT MAP(
		i_resetBar	=>in_resetbar,
		i_d		=>int_d(2),
		i_enable	=>'1',
		i_clock		=>in_clk,
		o_q		=>int_State(2));

	DFF_s3 : enARdFF_2
	PORT MAP(
		i_resetBar	=>in_resetbar,
		i_d		=>int_d(3),
		i_enable	=>'1',
		i_clock		=>in_clk,
		o_q		=>int_State(3));

	DFF_s4 : enARdFF_2
	PORT MAP(
		i_resetBar	=>in_resetbar,
		i_d		=>int_d(4),
		i_enable	=>'1',
		i_clock		=>in_clk,
		o_q		=>int_State(4));

	DFF_s5 : enARdFF_2
	PORT MAP(
		i_resetBar	=>in_resetbar,
		i_d		=>int_d(5),
		i_enable	=>'1',
		i_clock		=>in_clk,
		o_q		=>int_State(5));

	DFF_s6 : enARdFF_2
	PORT MAP(
		i_resetBar	=>in_resetbar,
		i_d		=>int_d(6),
		i_enable	=>'1',
		i_clock		=>in_clk,
		o_q		=>int_State(6));

	DFF_s7 : enARdFF_2
	PORT MAP(
		i_resetBar	=>in_resetbar,
		i_d		=>int_d(7),
		i_enable	=>'1',
		i_clock		=>in_clk,
		o_q		=>int_State(7));

	DFF_s8 : enARdFF_2
	PORT MAP(
		i_resetBar	=>in_resetbar,
		i_d		=>int_d(8),
		i_enable	=>'1',
		i_clock		=>in_clk,
		o_q		=>int_State(8));

	DFF_s9 : enARdFF_2
	PORT MAP(
		i_resetBar	=>in_resetbar,
		i_d		=>int_d(9),
		i_enable	=>'1',
		i_clock		=>in_clk,
		o_q		=>int_State(9));

	DFF_s10 : enARdFF_2
	PORT MAP(
		i_resetBar	=>in_resetbar,
		i_d		=>int_d(10),
		i_enable	=>'1',
		i_clock		=>in_clk,
		o_q		=>int_State(10));

	DFF_c1 : enARdFF_2
	PORT MAP(
		i_resetBar	=>in_resetbar,
		i_d		 =>int_c1_in,
		i_enable =>'1',
		i_clock	 =>in_clk,
		o_q		 =>int_c1);

	DFF_c2 : enARdFF_2
	PORT MAP(
		i_resetBar	=>in_resetbar,
		i_d		=>int_c2_in,
		i_enable =>'1',
		i_clock	=>in_clk,
		o_q		=>int_c2);

	DFF_c3 : enARdFF_2
	PORT MAP(
		i_resetBar	=>in_resetbar,
		i_d		 =>int_c3_in,
		i_enable =>'1',
		i_clock	 =>in_clk,
		o_q		 =>int_c3);

	DFF_c4 : enARdFF_2
	PORT MAP(
		i_resetBar	=>in_resetbar,
		i_d		 =>int_c4_in,
		i_enable =>'1',
		i_clock	 =>in_clk,
		o_q		 =>int_c4);

	--Control Signals
	o_WRFP_A 	 <= int_State(0);
	o_WRFP_B 	 <= int_State(0); 
	o_WRFP_C 	 <= int_State(9) OR int_State(10);
	o_WRexpDiff	 <= int_State(0); 
	o_WRALU_B 	 <= int_State(1) OR int_State(2) OR int_State(4);
	o_FP_C	 	 <= int_State(10);
	o_Mux_A	 	 <= int_State(2);
	o_Mux_B	 	 <= int_State(1) OR int_State(4);  
	o_Mux_Exp	 <= int_State(5) AND in_Exp_F ;
	o_SR_En		 <= int_State(1) OR int_State(2) OR int_State(3) OR int_State(4);
    o_SR_Sel	 <= int_State(1) OR int_State(2) OR int_State(4);
	o_IncDec_En	 <= int_State(4) OR int_State(5) OR int_State(7) OR int_State(8);   
   	o_sLR_En	 <= int_State(5) OR int_State(6) OR int_STATES(7) OR int_State(8); 
	o_IncDec_Sel(0) <= int_State(4) OR int_State(5) OR int_State(8);
	o_IncDec_Sel(1) <= int_State(4) OR int_State(5);
	o_sLR_Sel(0) 	 <= int_State(5) OR int_State(6) OR int_State(8);
	o_sLR_Sel(1)	 <= int_State(5) OR int_State(6); 

	o_State <= int_State;
	o_Con(0) <= int_c1;
	o_Con(1) <= int_c2;
	o_Con(2) <= int_c3;
	o_Con(3) <= int_c4;