library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ProcessorModule is
    Port ( CLK : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           aluResult : out  STD_LOGIC_VECTOR (31 downto 0));
end ProcessorModule;

architecture Behavioral of ProcessorModule is
	
	COMPONENT nPC
	PORT(
		CLK : IN std_logic;
		nPCin : IN std_logic_vector(5 downto 0);
		rst : IN std_logic;          
		nPCout_PCin : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;

	COMPONENT PC
	PORT(
		CLK : IN std_logic;
		rst : IN std_logic;
		PCin : IN std_logic_vector(5 downto 0);          
		address : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
	
	COMPONENT Adder
	PORT(
		AdderInput1 : IN std_logic_vector(5 downto 0);
		nPCout_PCin : IN std_logic_vector(5 downto 0);          
		AdderOut : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
	
		COMPONENT instructionMemory
	PORT(
		address : IN std_logic_vector(5 downto 0);
		reset : IN std_logic;          
		outInstruction : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

		COMPONENT registerFile
	PORT(
		reset : IN std_logic;
		registerSource1 : IN std_logic_vector(5 downto 0);
		registerSource2 : IN std_logic_vector(5 downto 0);
		registerDestination : IN std_logic_vector(5 downto 0);
		dataToWrite : IN std_logic_vector(31 downto 0);          
		contentRegisterSource1 : OUT std_logic_vector(31 downto 0);
		contentRegisterSource2 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT CU
	PORT(
		OP : IN std_logic_vector(1 downto 0);
		OP3 : IN std_logic_vector(5 downto 0);          
		ALUOP : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
	
		COMPONENT ALU
	PORT(
		ALUOP : IN std_logic_vector(5 downto 0);
		Carry : IN std_logic;
		CRs1 : IN std_logic_vector(31 downto 0);
		Operand2 : IN std_logic_vector(31 downto 0);
		ALUResult : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT Mux
	PORT(
		CRs2 : IN std_logic_vector(31 downto 0);
		IMM13 : IN std_logic_vector(31 downto 0);
		I : IN std_logic;          
		OutMux : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT SignExtensionUnit
	PORT(
		IMM13 : IN std_logic_vector(12 downto 0);          
		IMM13Extended : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT PSRModifier
	PORT(
		CRs1 : IN std_logic_vector(31 downto 0);
		Operand2 : IN std_logic_vector(31 downto 0);
		AluOp : IN std_logic_vector(5 downto 0);
		AluResult : IN std_logic_vector(31 downto 0);          
		NZVC : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;

	COMPONENT PSR
	PORT(
		CLK : IN std_logic;
		Reset : IN std_logic;
		nCWP : IN std_logic;
		Operand2 : IN std_logic_vector(31 downto 0);
		NZVC : IN std_logic_vector(3 downto 0);          
		Carry : OUT std_logic;
		CWP : OUT std_logic
		);
	END COMPONENT;

	COMPONENT WindowsManager
	PORT(
		OP : IN std_logic_vector(1 downto 0);
		OP3 : IN std_logic_vector(5 downto 0);
		RS1 : IN std_logic_vector(4 downto 0);
		RS2 : IN std_logic_vector(4 downto 0);
		RD : IN std_logic_vector(4 downto 0);
		CWP : IN std_logic;          
		nRS1 : OUT std_logic_vector(5 downto 0);
		nRS2 : OUT std_logic_vector(5 downto 0);
		nRD : OUT std_logic_vector(5 downto 0);
		nCWP : OUT std_logic
		);
	END COMPONENT;

	signal instructionMemoryOut, crs1, crs2, aluResults, IMM13Extended, Operand2 : STD_LOGIC_VECTOR (31 downto 0) :=(others=>'0');
	signal aluOP : STD_LOGIC_VECTOR(5 downto 0) :=(others=>'0');
	signal nPCout_PCin, adderOut, address, nrs1, nrs2, nrd : STD_LOGIC_VECTOR(5 downto 0) :=(others => '0');
	signal nzvc : STD_LOGIC_VECTOR(3 downto 0) :=(others=>'0');
	signal carry,cwp,ncwp : STD_LOGIC := '0';
	
begin
	Inst_nPC: nPC PORT MAP( -- nPC
		CLK => CLK,
		nPCin => adderOut,
		nPCout_PCin => nPCout_PCin,
		rst => rst
	);

	Inst_PC: PC PORT MAP( -- PC
		CLK => CLK,
		rst => rst,
		PCin => nPCout_PCin,
		address => address
	);
	
	Inst_Adder: Adder PORT MAP( -- Adder
		AdderInput1 => "000001",
		nPCout_PCin => nPCout_PCin,
		AdderOut => adderOut
	);

	Inst_instructionMemory: instructionMemory PORT MAP( -- Instruction memory
		address => address,
		reset => rst,
		outInstruction => instructionMemoryOut
	);
	
	Inst_WindowsManager: WindowsManager PORT MAP( -- Windows manager
		OP => instructionMemoryOut(31 downto 30),
		OP3 => instructionMemoryOut(24 downto 19),
		RS1 => instructionMemoryOut(18 downto 14),
		RS2 => instructionMemoryOut(4 downto 0),
		RD => instructionMemoryOut(29 downto 25),
		CWP => cwp,
		nRS1 => nrs1,
		nRS2 => nrs2,
		nRD => nrd,
		nCWP => ncwp
	);	
	
	Inst_SignExtensionUnit: SignExtensionUnit PORT MAP( -- Sign extension unit
		IMM13 => instructionMemoryOut(12 downto 0),
		IMM13Extended => IMM13Extended
	);
	
	Inst_registerFile: registerFile PORT MAP( -- Register file
		reset => rst,
		registerSource1 => nrs1,
		registerSource2 => nrs2,
		registerDestination => nrd,
		dataToWrite => aluResults,
		contentRegisterSource1 => crs1,
		contentRegisterSource2 => crs2
	);

	Inst_Mux: Mux PORT MAP( -- Multiplixer
		CRs2 => crs2,
		IMM13 => IMM13Extended,
		I => instructionMemoryOut(13),
		OutMux => Operand2
	);

	Inst_CU: CU PORT MAP( -- Control unit
		OP => instructionMemoryOut(31 downto 30),
		OP3 => instructionMemoryOut(24 downto 19),
		ALUOP => aluOP
	);
	
	Inst_ALU: ALU PORT MAP( -- Arithmetic logical unit
		ALUOP => aluOP,
		Carry => carry,
		CRs1 => crs1,
		Operand2 => Operand2,
		ALUResult => aluResults
	);

	Inst_PSRModifier: PSRModifier PORT MAP( -- PSR Modifier
		CRs1 => crs1,
		Operand2 => Operand2,
		AluOp => aluOP,
		AluResult => aluResults,
		NZVC => nzvc
	);

	Inst_PSR: PSR PORT MAP( -- PSR
		CLK => CLK,
		Reset => rst,
		nCWP => ncwp,
		Operand2 => Operand2,
		NZVC => nzvc,
		Carry => carry,
		CWP => cwp
	);

	aluResult <= aluResults;
end Behavioral;

