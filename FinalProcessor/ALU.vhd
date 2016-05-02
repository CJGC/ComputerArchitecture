library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity ALU is
    Port ( ALUOP : in  STD_LOGIC_VECTOR (5 downto 0);
           CRs1 : in  STD_LOGIC_VECTOR (31 downto 0);
           Operand2 : in  STD_LOGIC_VECTOR (31 downto 0);
			  Carry : in STD_LOGIC;
           ALUResult : out  STD_LOGIC_VECTOR (31 downto 0));
end ALU;

architecture Behavioral of ALU is

begin

	process(ALUOP,CRs1,Operand2,Carry)
	begin
		case ALUOP is
			when "000000" => ALUResult <= CRs1 + Operand2; -- Adding CRs1 and Operand2
			when "000100" => ALUResult <= CRs1 - Operand2; -- SUB
			when "000001" => ALUResult <= CRs1 and Operand2; -- AND
			when "000010" => ALUResult <= CRs1 or Operand2; -- OR
			when "000011" => ALUResult <= CRs1 xor Operand2; -- XOR
			when "000101" => ALUResult <= CRs1 nand Operand2; -- ANDN
			when "000110" => ALUResult <= CRs1 nor Operand2; -- ORN
			when "000111" => ALUResult <= CRs1 xnor Operand2; -- XNOR
			when "010001" => ALUResult <= CRs1 and Operand2; -- Andcc
			--when "010101" => ALUResult <= CRs1 nand Operand2; -- andncc
			when "010010" => ALUResult <= CRs1 or Operand2; -- Orcc
			when "010110" => ALUResult <= CRs1 nor Operand2; -- Norcc
			when "010011" => ALUResult <= CRs1 xor Operand2; -- Xorcc
			--when "010111" => ALUResult <= CRs1 xnor Operand2; -- Xnorcc
			when "010000" => ALUResult <= CRs1 + Operand2; -- Addcc
			when "001000" => ALUResult <= CRs1 + Operand2 + Carry; -- Addx
			when "011000" => ALUResult <= CRs1 + Operand2 + Carry; -- Addxcc
			when "010100" => ALUResult <= CRs1 - Operand2; -- Subcc
			when "001100" => ALUResult <= CRs1 - Operand2 - Carry; -- Subx
			when "011100" => ALUResult <= CRs1 - Operand2 - Carry; -- subxcc
			when others => ALUResult <= (others => '1'); -- ERROR CASE
		end case;
	end process;

end Behavioral;
