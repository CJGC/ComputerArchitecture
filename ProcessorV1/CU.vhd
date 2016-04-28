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
