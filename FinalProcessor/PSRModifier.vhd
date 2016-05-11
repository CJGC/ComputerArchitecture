library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PSRModifier is
    Port ( CRs1 : in  STD_LOGIC_VECTOR (31 downto 0);
           Operand2 : in  STD_LOGIC_VECTOR (31 downto 0);
           AluOp : in  STD_LOGIC_VECTOR (5 downto 0);
           AluResult : in  STD_LOGIC_VECTOR (31 downto 0);
           NZVC : out  STD_LOGIC_VECTOR (3 downto 0));
end PSRModifier;

architecture Behavioral of PSRModifier is

	impure function ZeroBitSet(AluResult : STD_LOGIC_VECTOR) return STD_LOGIC is
	begin
		if(AluResult = x"00000000")then
			return '1';
		else
			return '0';
		end if;
	end function;

begin

	process(CRs1,Operand2,AluOp,AluResult)
	begin					-- Logical Instructions
							-- Andcc, Nandcc, Orcc, Norcc, Xorcc, Xnorcc
		if((AluOp = "010001") or (AluOP = "010101") or (AluOP = "010010" )or (AluOP = "010110") or (AluOP = "010011") or (AluOP = "010111")) then
			NZVC(1 downto 0) <= "00"; -- V and C
							-- Addcc, Addxcc
		elsif((AluOp = "010000") or (AluOp = "011000"))then -- Add instruction
			NZVC(1) <= (CRs1(31) and Operand2(31) and (not AluResult(31))) or ((not CRs1(31)) and (not Operand2(31)) and AluResult(31)); -- V
			NZVC(0) <= (CRs1(31) and Operand2(31)) or ((not AluResult(31)) and (CRs1(31) or Operand2(31))); -- C
							-- Subcc, Subxcc
		elsif((AluOp = "010100") or (AluOP = "011100"))then -- Sub instructions
			NZVC(1) <= (CRs1(31) and (not Operand2(31)) and (not AluResult(31))) or ((not CRs1(31)) and Operand2(31) and AluResult(31)); -- V
			NZVC(0) <= ((not CRs1(31)) and Operand2(31)) or (AluResult(31) and ((not CRs1(31)) or Operand2(31))); -- C
		end if;
		NZVC(3) <= AluResult(31); -- N
		NZVC(2) <= ZeroBitSet(AluResult); -- Z
	end process;

end Behavioral;
