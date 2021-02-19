
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY oneBitSubtractor IS
	PORT(
		i_BorrowIn		: IN	STD_LOGIC;
		i_Ai, i_Bi		: IN	STD_LOGIC;
		o_Diff, o_BorrowOut	: OUT	STD_LOGIC);
END oneBitSubtractor;

ARCHITECTURE rtl OF oneBitSubtractor IS
	SIGNAL int_CarryOut1, int_CarryOut2, int_CarryOut3: STD_LOGIC;

BEGIN


o_Diff <= i_Ai xor i_Bi xor i_BorrowIn;

o_BorrowOut <= ((not i_Ai) and i_Bi) or ((not i_Ai) and i_BorrowIn) or (i_Bi and i_BorrowIn);




END rtl;
