LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY oneBitRegister IS
	PORT(
		i_resetBar, i_load	: IN	STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		i_Value			: IN	STD_LOGIC;
		o_Value			: OUT	STD_LOGIC);
END oneBitRegister;

ARCHITECTURE rtl OF oneBitRegister IS
	SIGNAL int_Value, int_notValue : STD_LOGIC;

	COMPONENT enARdFF_2
		PORT(
			i_resetBar	: IN	STD_LOGIC;
			i_d		: IN	STD_LOGIC;
			i_enable	: IN	STD_LOGIC;
			i_clock		: IN	STD_LOGIC;
			o_q, o_qBar	: OUT	STD_LOGIC);
	END COMPONENT;

BEGIN

bit1: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => i_Value, 
			  i_enable => i_load,
			  i_clock => i_clock,
			  o_q => int_Value,
	          o_qBar => int_notValue);

	--Output
	o_Value	<= int_Value;

END rtl;
