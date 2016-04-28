library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity ALU is
    Port ( ALUOP : in  STD_LOGIC_VECTOR (5 downto 0);
           CRs1 : in  STD_LOGIC_VECTOR (31 downto 0);
           CRs2 : in  STD_LOGIC_VECTOR (31 downto 0);
           ALUResult : out  STD_LOGIC_VECTOR (31 downto 0));
end ALU;

architecture Behavioral of ALU is

begin

	process(ALUOP,CRs1,CRs2)
	begin
		case ALUOP is
			when "000000" => ALUResult <= CRs1 + CRs2; -- Adding CRs1 and CRs2
			when "000100" => ALUResult <= CRs1 - CRs2; -- SUB
			when "000001" => ALUResult <= CRs1 and CRs2; -- AND
			when "000010" => ALUResult <= CRs1 or CRs2; -- OR
			when "000011" => ALUResult <= CRs1 xor CRs2; -- XOR
			when "000101" => ALUResult <= CRs1 nand CRs2; -- ANDN
			when "000110" => ALUResult <= CRs1 nor CRs2; -- ORN
			when "000111" => ALUResult <= CRs1 xnor CRs2; -- XNOR
			when others => ALUResult <= (others => '1'); -- ERROR CASE
		end case;
	end process;

end Behavioral;
