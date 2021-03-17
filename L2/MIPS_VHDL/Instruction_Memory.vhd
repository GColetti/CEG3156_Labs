library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Instruction_Memory is
    Port ( 
		dir : in  STD_LOGIC_VECTOR (31 downto 0);
        instr : out  STD_LOGIC_VECTOR (31 downto 0)
		);
end Instruction_Memory;

architecture rtl of Instruction_Memory is
	type mem is array(0 to 67) of std_logic_vector(7 downto 0);
	constant code : mem:=(
		
		-- Registers load
		x"20",x"04",x"00",x"04",
		x"20",x"05",x"00",x"05",
		x"20",x"06",x"00",x"06",
		x"20",x"07",x"00",x"07",
		
		-- Instructions
		x"8C",x"02",x"00",x"00",	-- lw $2, 0;    
		x"8C",x"03",x"03",x"01",	-- lw $3, 1; 

		x"00",x"14",x"48",x"22",	-- sub $1, $2, $3; 
		x"01",x"2B",x"60",x"25",	-- or $4, $1, $3;
		x"AC",x"04",x"00",x"03",	-- sw $4, 3;

		x"14",x"B4",x"48",x"20",	-- add $1, $2, $3; 014B4820
		x"AC",x"01",x"00",x"04",	-- sw $1, 4;
		
		x"8C",x"02",x"00",x"03",	-- lw $2, 3;
		x"8C",x"03",x"00",x"04",	-- lw $3, 4;
		x"08",x"00",x"00",x"11" 	-- j 11 (jump to PC = 44)
		
		x"11",x"29",x"00",x"D4", 	-- beq $1, $1, -44;
		x"11",x"2A",x"00",x"F8", 	-- beq $1, $2, -8; 
		
		others=> x"00"
	);

	begin
		process(dir)
		begin
			instr(31 downto 24)<=code(conv_integer(dir));
			instr(23 downto 16)<=code(conv_integer(dir)+1);
			instr(15 downto 8)<= code(conv_integer(dir)+2);
			instr(7 downto 0)<=code(conv_integer(dir)+3);
		end process;
		
end rtl;