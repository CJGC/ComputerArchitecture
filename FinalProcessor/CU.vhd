library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CU is
    Port ( OP : in  STD_LOGIC_VECTOR (1 downto 0);
           OP3 : in  STD_LOGIC_VECTOR (5 downto 0);
           ALUOP : out  STD_LOGIC_VECTOR (5 downto 0));
end CU;

architecture Behavioral of CU is

begin

	process(OP,OP3)
	begin
		if(OP = "10") then -- Arithmetic instructions
			case OP3 is
				when "000000" => ALUOP <= OP3; -- ADD
				when "000001" => ALUOP <= OP3; -- AND
				when "000010" => ALUOP <= OP3; -- OR
				when "000011" => ALUOP <= OP3; -- XOR
				when "000100" => ALUOP <= OP3; -- SUB
				when "000101" => ALUOP <= OP3; -- ANDN
				when "000110" => ALUOP <= OP3; -- ORN
				when "000111" => ALUOP <= OP3; -- XNOR
				when "010001" => ALUOP <= OP3; -- Andcc
				when "010101" => ALUOP <= OP3; -- Nandcc
				when "010010" => ALUOP <= OP3; -- Orcc
				when "010110" => ALUOP <= OP3; -- Norcc
				when "010011" => ALUOP <= OP3; -- Xorcc
				when "010111" => ALUOP <= OP3; -- Xnorcc
				when "010000" => ALUOP <= OP3; -- Addcc
				when "001000" => ALUOP <= OP3; -- Addx
				when "011000" => ALUOP <= OP3; -- Addxcc
				when "010100" => ALUOP <= OP3; -- Subcc
				when "001100" => ALUOP <= OP3; -- Subx
				when "011100" => ALUOP <= OP3; -- subxcc
				when "111100" => ALUOP <= OP3; -- SAVE
				when "111101" => ALUOP <= OP3; -- RESTORE
				when others => ALUOP <= "111111"; -- ERROR CASE
			end case;
--		else
--			if(OP = "00")then
--				ALUOP <= "111111"; --ERROR CASE
--			else
--				if(OP = "01")then
--					ALUOP <= "111111"; --ERROR CASE
--				else
--					if(OP = "11")then
--						ALUOP <= "111111"; --ERROR CASE
--					end if;
--				end if;
--			end if;
		end if;
	end process;
	
end Behavioral;
