library IEEE;
use IEEE.Std_Logic_1164.all;

entity singleCycleProc is 
	port(
	ValueSelect: in std_logic_vector(2 downto 0);
	GCLock, GReset: in std_logic;
	MuxOut: out std_logic_vector (7 downto 0);
	instructionOut: out std_logic_vector (31 downto 0);
	memWriteOut, branchOut, zeroOut, regWriteOut: out std_logic
	);
	end singleCycleProc;
	