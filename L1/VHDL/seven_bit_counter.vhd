LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY seven_bit_counter IS
	PORT(
		i_resetbar, i_clock, i_en, i_dec: IN	STD_LOGIC;
		i_load							: IN	STD_LOGIC_VECTOR(6 downto 0);
		o_value							: OUT	STD_LOGIC_VECTOR(6 downto 0));
END seven_bit_counter;

ARCHITECTURE rtl OF seven_bit_counter IS

signal int_value, int_subval, int_r : STD_LOGIC_VECTOR(6 downto 0);

	COMPONENT enARdFF_2
		PORT(
			i_resetBar	: IN	STD_LOGIC;
			i_d			: IN	STD_LOGIC;
			i_enable	: IN	STD_LOGIC;
			i_clock		: IN	STD_LOGIC;
			o_q, o_qBar	: OUT	STD_LOGIC);
	END COMPONENT;

	COMPONENT sevenBitSubtractor is
		PORT(
		i_Bin 		: IN STD_LOGIC;
		i_A,i_B  	: IN STD_LOGIC_VECTOR (6 DOWNTO 0);
		o_Dout    	: OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
		o_Bout		: OUT STD_LOGIC);
	end COMPONENT;

	COMPONENT mux_2to1_b is
	    Port ( SEL : in  STD_LOGIC;
	           A   : in  STD_LOGIC_VECTOR (6 downto 0);
	           B   : in  STD_LOGIC_VECTOR (6 downto 0);
	           Y   : out STD_LOGIC_VECTOR (6 downto 0));
	end COMPONENT;

BEGIN

	-- Concurrent Signal Assignment
	int_value <= i_load;

	MUX:
	PORT MAP(SEL <= i_dec,
	           A  <= int_load,
	           B  <= int_subval,
	           Y  <= int_r);

	DEC: sevenBitSubtractor
	PORT MAP(
		i_Bin => "0",
		in_A => int_value, 
		in_B => "0000001", 		
		o_Result => int_subval);

	DFF_0 : enARdFF_2
	PORT MAP(
		i_resetBar	=> i_resetbar,
		i_d			=> int_r(0),
		i_enable	=> in_en,
		i_clock		=> in_clk,
		o_q			=> int_value(0),
		o_qBar		=> open);

	DFF_1 : enARdFF_2
	PORT MAP(
		i_resetBar	=> i_resetbar,
		i_d			=> int_r(1),
		i_enable	=> in_en,
		i_clock		=> in_clk,
		o_q			=> int_value(1),
		o_qBar		=> open);

	DFF_2 : enARdFF_2
	PORT MAP(
		i_resetBar	=> i_resetbar,
		i_d			=> int_r(2),
		i_enable	=> in_en,
		i_clock		=> in_clk,
		o_q			=> int_value(2),
		o_qBar		=> open);

	DFF_3 : enARdFF_2
	PORT MAP(
		i_resetBar	=> i_resetbar,
		i_d			=> int_r(3),
		i_enable	=> in_en,
		i_clock		=> in_clk,
		o_q			=> int_value(3),
		o_qBar		=> open);

	DFF_4 : enARdFF_2
	PORT MAP(
		i_resetBar	=> i_resetbar,
		i_d			=> int_r(4),
		i_enable	=> in_en,
		i_clock		=> in_clk,
		o_q			=> int_value(4),
		o_qBar		=> open);

	DFF_5 : enARdFF_2
	PORT MAP(
		i_resetBar	=> i_resetbar,
		i_d			=> int_r(5),
		i_enable	=> in_en,
		i_clock		=> in_clk,
		o_q			=> int_value(5),
		o_qBar		=> open);

	DFF_6 : enARdFF_2
	PORT MAP(
		i_resetBar	=> i_resetbar,
		i_d			=> int_r(6),
		i_enable	=> in_en,
		i_clock		=> in_clk,
		o_q			=> int_value(6),
		o_qBar		=> open);

	-- Output Driver
	o_value	<= int_value;
	
		

END rtl;
