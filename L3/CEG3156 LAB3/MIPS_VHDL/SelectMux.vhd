library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SelectMUX is
    Port (
		i_ValueSelect : in STD_LOGIC_VECTOR(2 downto 0);
        i_InstrSelect : in STD_LOGIC_VECTOR(2 downto 0);
        i_Instruction1 : in STD_LOGIC_VECTOR(31 downto 0);
        i_Instruction2 : in STD_LOGIC_VECTOR(31 downto 0);
        i_Instruction3 : in STD_LOGIC_VECTOR(31 downto 0);
        i_Instruction4 : in STD_LOGIC_VECTOR(31 downto 0);
        i_Instruction5 : in STD_LOGIC_VECTOR(31 downto 0);
        A : in  STD_LOGIC_VECTOR (7 downto 0);
        B : in  STD_LOGIC_VECTOR (7 downto 0);
        C : in  STD_LOGIC_VECTOR (7 downto 0);
        D : in  STD_LOGIC_VECTOR (7 downto 0);
        E : in  STD_LOGIC_VECTOR (7 downto 0);
        F : in  STD_LOGIC_VECTOR (7 downto 0);
        o_MuxOut : out STD_LOGIC_VECTOR(7 downto 0);
        o_InstructionOut : out STD_LOGIC_VECTOR(31 downto 0)
	);
end SelectMUX;

architecture rtl of SelectMUX is

begin
    o_MuxOut <=  A when (i_ValueSelect = "000") else
            B when (i_ValueSelect = "001") else
            C when (i_ValueSelect = "010") else
            D when (i_ValueSelect = "011") else
            E when (i_ValueSelect = "100") else
            F;

    o_InstructionOut <= i_Instruction1 when (i_InstrSelect = "000") else
            i_Instruction2 when (i_InstrSelect = "001") else
            i_Instruction3 when (i_InstrSelect = "010") else
            i_Instruction4 when (i_InstrSelect = "011") else
            i_Instruction5 when (i_InstrSelect = "100") else
            "00000000000000000000000000000000";
end rtl;

