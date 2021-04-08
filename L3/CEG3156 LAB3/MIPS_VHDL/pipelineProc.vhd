library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pipelineProc is
    Port (GClock 		: in  STD_LOGIC;
		GReset 			: in std_logic;
		ValueSelect, InstrSelect 	: in STD_LOGIC_VECTOR(2 downto 0);
		MuxOut 			: out STD_LOGIC_VECTOR(7 downto 0);
    	IntructionOut 	: out STD_LOGIC_VECTOR(31 downto 0);
    	BranchOut		: out std_logic;
    	ZeroOut			: out std_logic;
    	MemWriteOut		: out std_logic;
    	RegWriteOut		: out std_logic
	);
end pipelineProc;

architecture rtl of pipelineProc is

	COMPONENT PC
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		din : IN std_logic_vector(31 downto 0);          
		dout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT Instruction_Memory
	PORT(
		dir : IN std_logic_vector(31 downto 0);          
		instr : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT Alu_PCnext
	PORT(
		PC : IN std_logic_vector(31 downto 0);          
		PCnext : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT ControlUnit
	PORT(
		OpCode : IN std_logic_vector(5 downto 0);
		Funct : IN std_logic_vector(5 downto 0);          
		MemtoReg : OUT std_logic;
		MemWrite : OUT std_logic;
		Branch : OUT std_logic;
		AluSrc : OUT std_logic;
		RegDst : OUT std_logic;
		RegWrite : OUT std_logic;
		jump : OUT std_logic;
		AluCtrl : OUT std_logic_vector(2 downto 0)
		);
	END COMPONENT;
	
	component Datamemory
	port (
		address: in STD_LOGIC_VECTOR (31 downto 0);
		write_data: in STD_LOGIC_VECTOR (31 downto 0);
		MemWrite: in STD_LOGIC;
		clk: in STD_LOGIC;
		read_data: out STD_LOGIC_VECTOR (31 downto 0)
	);
	end component;
	
	COMPONENT Register_File
	PORT(
		clk : IN std_logic;
		we3 : IN std_logic;
		A1 : IN std_logic_vector(4 downto 0);
		A2 : IN std_logic_vector(4 downto 0);
		A3 : IN std_logic_vector(4 downto 0);
		WD3 : IN std_logic_vector(31 downto 0);          
		RD1 : OUT std_logic_vector(31 downto 0);
		RD2 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT ALU
	PORT(
		a : IN std_logic_vector(31 downto 0);
		b : IN std_logic_vector(31 downto 0);
		func : IN std_logic_vector(2 downto 0);          
		zero : out std_logic;
		rslt : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT SignExtend
	PORT(
		din : IN std_logic_vector(15 downto 0);          
		dout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT Mux_2to1_32b
	PORT(
		sel : IN std_logic;
		A : IN std_logic_vector(31 downto 0);
		B : IN std_logic_vector(31 downto 0);          
		o_y : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT SL2
	PORT(
		din : IN std_logic_vector(31 downto 0);          
		dout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	
	COMPONENT rippleAdder32bit
	PORT(
		x,y: in std_logic_vector(31 downto 0);
		i_Cin : in std_logic;
		Sum: out std_logic_vector(31 downto 0);
		Carry: out std_logic
	);
	END COMPONENT;
	
	
	COMPONENT Mux_2to1_5bits
	PORT(
		sel : IN std_logic;
		a : IN std_logic_vector(4 downto 0);
		b : IN std_logic_vector(4 downto 0);          
		o_y : OUT std_logic_vector(4 downto 0)
		);
	END COMPONENT;

	COMPONENT SelectMUX is
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
	end COMPONENT;
	
	signal memtoreg,branch,alusrc,regdst,regwrite,jump,zero,memwrite : std_logic;
	signal aluctrl : std_logic_vector(2 downto 0);

	signal pc_in,pc_out,instr: std_logic_vector(31 downto 0);
	
	alias code_op : std_logic_vector(5 downto 0) is instr(31 downto 26);
	alias funct : std_logic_vector(5 downto 0) is instr(5 downto 0);
	
	alias rs : std_logic_vector(4 downto 0) is instr(25 downto 21);
	alias rt : std_logic_vector(4 downto 0) is instr(20 downto 16);
	alias rd : std_logic_vector(4 downto 0) is instr(15 downto 11);
	alias shamt : std_logic_vector(4 downto 0) is instr(10 downto 6);
	alias inmd : std_logic_vector(15 downto 0) is instr(15 downto 0);
	alias addr : std_logic_vector(25 downto 0) is instr(25 downto 0);
	
	signal pc_out_next: std_logic_vector(31 downto 0);
	signal sal_rt_o_rd : std_logic_vector(4 downto 0);
	
	signal srca,srcb,rd2,alu_result,extsig_out,readdata : std_logic_vector(31 downto 0);
	signal shift_out,pc_branch,result_mem : std_logic_vector(31 downto 0);

	signal addr32,addr32_corri,addr32_pc_next,pc_next_j : std_logic_vector(31 downto 0);
	signal pcsrc : std_logic;

	signal int_other : std_logic_vector(7 downto 0);
	
	signal int_MuxOut : std_LOGIC_VECTOR(7 downto 0);
	signal int_instr_out: STD_LOGIC_VECTOR(31 downto 0);
	
	begin

		Inst_ControlUnit: ControlUnit PORT MAP(
			OpCode => code_op,
			Funct => funct,
			MemtoReg => memtoreg,
			MemWrite => memwrite,
			Branch => branch,
			AluSrc => alusrc,
			RegDst => regdst,
			RegWrite => regwrite,
			jump => jump,
			AluCtrl => aluctrl
		);
		

		Inst_PC: PC PORT MAP(
			clk => GClock,
			reset => GReset,
			din => pc_next_j,
			dout => pc_out
		);
		
		Inst_Instruction_Memory: Instruction_Memory PORT MAP(
			dir => pc_out,
			instr =>instr
		);
		
		Memory: Datamemory PORT MAP(
			address => alu_result,
			write_data => rd2 ,
			MemWrite => memwrite,
			clk => GClock,
			read_data => readdata
		
		);
		
		
		ALU_branch: rippleAdder32bit PORT MAP(
			x => pc_out,
			y => x"00000004",
			i_Cin => '0',
			Sum => pc_out_next
		);
		
		
		Inst_Mux_rt_o_rd: Mux_2to1_5bits PORT MAP(
			sel => regdst,
			a => rt,
			b => rd,
			o_y => sal_rt_o_rd
		);
		
		
		Inst_Register_File: Register_File PORT MAP(
			clk => GClock,
			we3 => regwrite,
			A1 => rs,
			A2 => rt,
			A3 => sal_rt_o_rd,
			RD1 => srca,
			RD2 => rd2,
			WD3 => result_mem
		);

		Inst_Mux_extSign_o_red2: Mux_2to1_32b PORT MAP(
			sel => alusrc,
			A => rd2,
			B => extsig_out,
			o_y => srcb
		);
		
		Inst_ALU: ALU PORT MAP(
			a => srca,
			b => srcb,
			func => aluctrl,
			zero=> zero,
			rslt => alu_result
		);
		
		
		Inst_SignExtend: SignExtend PORT MAP(
			din => inmd,
			dout => extsig_out
		);
		
		
		Inst_SL2: SL2 PORT MAP(
			din => extsig_out,
			dout => shift_out
		);
		
		
		ALU_sum_shift: rippleAdder32bit PORT MAP(
			x => shift_out,
			y => pc_out_next,
			i_Cin => '0',
			Sum => pc_branch,
			Carry => open

		);
		
		pcsrc <= branch and zero;
		
		Inst2_Mux_2to1_32b: Mux_2to1_32b PORT MAP(
			sel => pcsrc,
			A => pc_out_next,
			B => pc_branch,
			o_y => pc_in
		);
		

		Inst3_Mux_2to1_32b: Mux_2to1_32b PORT MAP(
			sel => memtoreg,
			A => alu_result,
			B => readdata,
			o_y => result_mem
		);

		addr32_pc_next <= pc_out_next(31 downto 28) & addr & "00";
		--IntructionOut <= addr32_pc_next;

		Mux_instru_j: Mux_2to1_32b PORT MAP(
			sel => jump,
			A => pc_in,
			B => addr32_pc_next,
			o_y => pc_next_j
		);
		
		--Other control signals for MuxOut
		int_other <= '0' & regdst & jump & memwrite & memtoreg & aluctrl(1 downto 0) & alusrc;
		
		SelectMUX1: SelectMUX PORT MAP (
			i_ValueSelect => ValueSelect,
	        A => instr(7 downto 0),
	        B => alu_result(7 downto 0),
	        C => srca(7 downto 0),
	        D => rd2(7 downto 0),
	        E => result_mem(7 downto 0),
	        F => int_other,
	        i_InstrSelect => InstrSelect;
	        i_Instruction1 =>
	        i_Instruction2 =>
	        i_Instruction3 =>
	        i_Instruction4 =>
	        i_Instruction5 =>
	        o_MuxOut => int_MuxOut
	        o_InstructionOut => int_instr_out;
		);
		
		--Instruc 1-5 
		IntructionOut <= int_instr_out;

		--Set MuxOut
		MuxOut <= int_MuxOut;

		--Other output control signals 
		BranchOut <= branch;
    	ZeroOut	<= zero;	
    	MemWriteOut <= memwrite;	
		
end rtl;

