library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ProcessorModule is
    Port ( CLK : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           outProcessor : out  STD_LOGIC_VECTOR (31 downto 0));
end ProcessorModule;

architecture Behavioral of ProcessorModule is
	
	COMPONENT nPC
	PORT(
		CLK : IN std_logic;
		nPCin : IN std_logic_vector(31 downto 0);
		rst : IN std_logic;          
		nPCout_PCin : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT PC
	PORT(
		CLK : IN std_logic;
		rst : IN std_logic;
		PCin : IN std_logic_vector(31 downto 0);          
		address : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT Adder
	PORT(
		Input1 : IN std_logic_vector(31 downto 0);
		Input2 : IN std_logic_vector(31 downto 0);          
		AdderOut : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT instructionMemory
	PORT(
		address : IN std_logic_vector(31 downto 0);
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
		we : IN std_logic;
		dataToWrite : IN std_logic_vector(31 downto 0);          
		contentRegisterSource1 : OUT std_logic_vector(31 downto 0);
		contentRegisterSource2 : OUT std_logic_vector(31 downto 0);
		contentRegisterDestination : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT CU
	PORT(
		OP : IN std_logic_vector(1 downto 0);
		OP2 : IN std_logic_vector(2 downto 0);
		OP3 : IN std_logic_vector(5 downto 0);
		COND : IN std_logic_vector(3 downto 0);
		ICC : IN std_logic_vector(3 downto 0);
		WriteEnableDm : OUT std_logic;
		WriteEnableRf : OUT std_logic;
		RfDest : OUT std_logic;
		RfSource : OUT std_logic_vector(1 downto 0);
		PCSource : OUT std_logic_vector(1 downto 0);
		ALUOP : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
	
	COMPONENT ALU
	PORT(
		ALUOP : IN std_logic_vector(5 downto 0);
		CRs1 : IN std_logic_vector(31 downto 0);
		Operand2 : IN std_logic_vector(31 downto 0);
		Carry : IN std_logic;
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

	COMPONENT MulWindowManager
	PORT(
		RD : IN std_logic_vector(5 downto 0);
		Register07 : IN std_logic_vector(5 downto 0);
		RfDest : IN std_logic;          
		Mux_out : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;

	COMPONENT SignExtensionUnit
	PORT(
		IMM13 : IN std_logic_vector(12 downto 0);
		Disp22 : IN std_logic_vector(21 downto 0);
		Disp30 : IN std_logic_vector(29 downto 0);
		Selector : IN std_logic_vector(1 downto 0);
		SignExtensionOut : OUT std_logic_vector(31 downto 0)
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
		NZVC : IN std_logic_vector(3 downto 0);
		ICC : OUT std_logic_vector(3 downto 0);		
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
		nCWP : OUT std_logic;
		Register07 : out std_logic_vector (5 downto 0)
		);
	END COMPONENT;

	COMPONENT DataMemory
	PORT(
		WriteEnable : IN std_logic;
		Rst : IN std_logic;
		Data : IN std_logic_vector(31 downto 0);
		Address : IN std_logic_vector(4 downto 0);          
		DataOut : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT MuxDataMemory
	PORT(
		dataMemory : IN std_logic_vector(31 downto 0);
		aluResult : IN std_logic_vector(31 downto 0);
		pc : IN std_logic_vector(31 downto 0);
		rfSource : IN std_logic_vector(1 downto 0);          
		outMux : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT MuxNpc
	PORT(
		PcDisp30 : IN std_logic_vector(31 downto 0);
		PcDisp22 : IN std_logic_vector(31 downto 0);
		Pc : IN std_logic_vector(31 downto 0);
		AluResult : IN std_logic_vector(31 downto 0);
		PcSource : IN std_logic_vector(1 downto 0);          
		OutMux : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	signal instructionMemoryOut,nPCout_PCin,address,nPCAdderResult,crs1,crs2,crd,aluResult : STD_LOGIC_VECTOR (31 downto 0) :=(others=>'0');
	signal signExtensionOut,Operand2,dataMemoryOut,dataToReg,disp22AdderResult : STD_LOGIC_VECTOR (31 downto 0) :=(others=>'0');
	signal disp30AdderResult,nextInstruction : STD_LOGIC_VECTOR (31 downto 0) :=(others=>'0');
	signal nrs1,nrs2,nrd,register07,aluOP,rd : STD_LOGIC_VECTOR(5 downto 0) :=(others => '0');
	signal nzvc,icc : STD_LOGIC_VECTOR(3 downto 0) :=(others=>'0');
	signal rfSource,pcSource : STD_LOGIC_VECTOR(1 downto 0) :=(others=>'0');
	signal carry,cwp,ncwp,weRf,weDm,rfDest : STD_LOGIC := '0';
	
begin
	Inst_nPC: nPC PORT MAP( -- nPC
		CLK => CLK,
		nPCin => nextInstruction,
		nPCout_PCin => nPCout_PCin,
		rst => rst
	);

	Inst_PC: PC PORT MAP( -- PC
		CLK => CLK,
		rst => rst,
		PCin => nPCout_PCin,
		address => address
	);
	
	Inst_Adder_nPC: Adder PORT MAP( -- Adder nPC
		Input1 => "00000000000000000000000000000001",
		Input2 => nPCout_PCin,
		AdderOut => nPCAdderResult
	);
	
	Inst_Adder_disp22: Adder PORT MAP( -- Adder disp 22
		Input1 => address,
		Input2 => signExtensionOut,
		AdderOut => disp22AdderResult
	);
	
	Inst_Adder_disp30: Adder PORT MAP( -- Adder disp 30
		Input1 => address,
		Input2 => signExtensionOut,
		AdderOut => disp30AdderResult
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
		nRD => rd,
		nCWP => ncwp,
		Register07 => register07
	);
	
	Inst_SignExtensionUnit: SignExtensionUnit PORT MAP( -- Sign extension unit
		IMM13 => instructionMemoryOut(12 downto 0),
		Disp22 => instructionMemoryOut(21 downto 0),
		Disp30 => instructionMemoryOut(29 downto 0),
		Selector => instructionMemoryOut(31 downto 30),
		SignExtensionOut => signExtensionOut
	);
	
	Inst_registerFile: registerFile PORT MAP( -- Register file
		reset => rst,
		registerSource1 => nrs1,
		registerSource2 => nrs2,
		registerDestination => nrd,
		we => weRf,
		dataToWrite => dataToReg,
		contentRegisterSource1 => crs1,
		contentRegisterSource2 => crs2,
		contentRegisterDestination => crd
	);

	Inst_Mux: Mux PORT MAP( -- Multiplexer
		CRs2 => crs2,
		IMM13 => signExtensionOut,
		I => instructionMemoryOut(13),
		OutMux => Operand2
	);

	Inst_CU: CU PORT MAP( -- Control unit
		OP => instructionMemoryOut(31 downto 30),
		OP2 => instructionMemoryOut(24 downto 22),
		OP3 => instructionMemoryOut(24 downto 19),
		COND => instructionMemoryOut(28 downto 25),
		ICC => icc,
		WriteEnableDm => weDm,
		WriteEnableRf => weRf,
		RfDest => rfDest,
		RfSource => rfSource,
		PCSource => pcSource,
		ALUOP => aluOP
	);
	
	Inst_ALU: ALU PORT MAP( -- Arithmetic logical unit
		ALUOP => aluOP,
		CRs1 => crs1,
		Operand2 => Operand2,
		Carry => carry,
		ALUResult => aluResult
	);

	Inst_PSRModifier: PSRModifier PORT MAP( -- PSR Modifier
		CRs1 => crs1,
		Operand2 => Operand2,
		AluOp => aluOP,
		AluResult => aluResult,
		NZVC => nzvc
	);

	Inst_PSR: PSR PORT MAP( -- PSR
		CLK => CLK,
		Reset => rst,
		nCWP => ncwp,
		NZVC => nzvc,
		ICC => icc,
		Carry => carry,
		CWP => cwp
	);

	Inst_DataMemory: DataMemory PORT MAP( -- Data memory
		WriteEnable => weDm,
		Rst => rst,
		Data => crd,
		Address => aluResult(4 downto 0),
		DataOut => dataMemoryOut
	);

	Inst_MulWindowManager: MulWindowManager PORT MAP( -- Windows manager multiplexer
		RD => rd,
		Register07 => register07,
		RfDest => rfDest,
		Mux_out => nrd
	);

	Inst_MuxDataMemory: MuxDataMemory PORT MAP( -- Data memory multiplexer
		dataMemory => dataMemoryOut,
		aluResult => aluResult,
		pc => address,
		rfSource => rfSource,
		outMux => dataToReg
	);

	Inst_MuxNpc: MuxNpc PORT MAP( -- Next program counter multiplexer
		PcDisp30 => disp30AdderResult,
		PcDisp22 => disp22AdderResult,
		Pc => nPCAdderResult,
		AluResult => aluResult,
		PcSource => pcSource,
		OutMux => nextInstruction
	);
	
	outProcessor <= dataToReg;
end Behavioral;
