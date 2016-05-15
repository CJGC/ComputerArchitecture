library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CU is
    Port ( OP : in  STD_LOGIC_VECTOR (1 downto 0);
			  OP2 : in STD_LOGIC_VECTOR (2 downto 0);
           OP3 : in  STD_LOGIC_VECTOR (5 downto 0);
			  COND : in STD_LOGIC_VECTOR (3 downto 0);
			  ICC : in STD_LOGIC_VECTOR (3 downto 0);
			  WriteEnableDm : out STD_LOGIC;
			  WriteEnableRf : out STD_LOGIC;
			  RfDest : out STD_LOGIC; -- Mux windows manager
			  RfSource : out STD_LOGIC_VECTOR (1 downto 0); -- Mux data memory
			  PCSource : out STD_LOGIC_VECTOR (1 downto 0); -- Mux npc
           ALUOP : out  STD_LOGIC_VECTOR (5 downto 0));
end CU;

architecture Behavioral of CU is
	signal BranchAux : std_logic := '0'; -- This signal will allow me to trim some code
	signal ArithAux : std_logic_vector (1 downto 0); -- This signal will allow me to trim some code
begin
	process(OP,OP2,OP3,COND,ICC,BranchAux,ArithAux)
	begin
		if(OP = "00")then -- Branch and NOP FORMAT 2
			if(OP2 = "010")then -- Branch on integer conditional codes
				BranchAux <= '0'; -- 0 indicates that don't not fulfilled the ICC code or is branch never case
				if(COND = "1000")then BranchAux <= '1'; -- Branch always ; BranchAux = 1 indicates that fulfilled the ICC code
				elsif(COND = "0000")then BranchAux <= '0'; -- Branch never
				elsif((COND = "1001")and(not(ICC(2)) = '1'))then BranchAux <= '1'; -- Branch on not equal ; Not z
				elsif((COND = "0001")and(ICC(2) = '1'))then BranchAux <= '1'; -- Branch on equal ; Z
				elsif((COND = "1010")and((not(ICC(2) or (ICC(3) xor ICC(1)))) = '1'))then BranchAux <= '1'; -- Branch on greater ; not(Z or (N xor V))
				elsif((COND = "0010")and((ICC(2) or (ICC(3) xor ICC(1))) = '1'))then BranchAux <= '1'; -- Branch on less or equal ; Z or (N xor V)
				elsif((COND = "1011")and((not(ICC(3) xor ICC(1))) = '1'))then BranchAux <= '1'; -- Branch on greater or equal ; not(N xor V)
				elsif((COND = "0011")and((ICC(3) xor ICC(1)) = '1'))then BranchAux <= '1'; -- Branch on less ; N xor V
				elsif((COND = "1100")and((not(ICC(0) or ICC(2))) = '1'))then BranchAux <= '1'; -- Branch on greater unsigned ; not(C or Z)
				elsif((COND = "0100")and((ICC(0) or ICC(2)) = '1'))then BranchAux <= '1'; -- Branch on less or equal unsigned ; C or Z
				elsif((COND = "1101")and(not(ICC(0)) = '1'))then BranchAux <= '1'; -- Branch on carry clear ; Not C
				elsif((COND = "0101")and(ICC(0) = '1'))then BranchAux <= '1'; -- Branch on carry set ; C
				elsif((COND = "1110")and(not(ICC(3)) = '1'))then BranchAux <= '1'; -- Branch on positive
				elsif((COND = "0110")and(ICC(3) = '1'))then BranchAux <= '1'; -- Branch on negative ; N
				elsif((COND = "1111")and(not(ICC(1)) = '1'))then BranchAux <= '1'; -- Branch on overflow clear ; Not V
				elsif((COND = "0111")and(ICC(1) = '1'))then BranchAux <= '1'; -- Branch on overflow set ; V
				end if;
				if(BranchAux = '0')then -- for no fulfilled ICC case or Branch never case
					PCSource <= "10"; -- Enable pc as mux out
				elsif(BranchAux = '1')then	-- for fulfilled ICC case
					PCSource <= "01"; -- Enable branches as mux out
				end if;
				RfSource <= "00"; -- Let pass data memory content, but it doesn't matter
			elsif(OP2 = "100")then -- NOP (No operation)
				RfSource <= "01"; -- Let pass Alu result
				PCSource <= "10"; -- Enable pc as mux out
			end if;
			WriteEnableDm <= '0'; -- Disable writing on data memory
			WriteEnableRf <= '0'; -- Disable writing on register file
			RfDest <= '0'; -- Let pass register destination, but it doesn't matter
			ALUOP <= "111111"; -- Error case, because it isn't arithmetic case
		elsif(OP = "01")then -- CALL FORMAT 1
			WriteEnableDm <= '0'; -- Disable writing on data memory
			WriteEnableRf <= '1'; -- Enable writing on register file
			RfDest <= '1'; -- Let pass 07 register
			RfSource <= "10"; -- Let pass PC as mux out
			PCSource <= "00"; -- Enable CALL and LinkInstruction as mux out
			ALUOP <= "111111"; -- Error case, because it ins't arithmetic case
		elsif(OP = "10") then -- Arithmetic instructions FORMAT 3
			case OP3 is
				when "000000" => ArithAux <= "00";-- ADD; ArithAux = 00 is an Arithmetic, logical and conditional code cases
				when "000001" => ArithAux <= "00"; -- AND
				when "000010" => ArithAux <= "00"; -- OR
				when "000011" => ArithAux <= "00"; -- XOR
				when "000100" => ArithAux <= "00"; -- SUB
				when "000101" => ArithAux <= "00"; -- ANDN
				when "000110" => ArithAux <= "00"; -- ORN
				when "000111" => ArithAux <= "00"; -- XNOR
				when "010001" => ArithAux <= "00"; -- Andcc
				when "010101" => ArithAux <= "00"; -- Nandcc
				when "010010" => ArithAux <= "00"; -- Orcc
				when "010110" => ArithAux <= "00"; -- Norcc
				when "010011" => ArithAux <= "00"; -- Xorcc
				when "010111" => ArithAux <= "00"; -- Xnorcc
				when "010000" => ArithAux <= "00"; -- Addcc
				when "001000" => ArithAux <= "00"; -- Addx
				when "011000" => ArithAux <= "00"; -- Addxcc
				when "010100" => ArithAux <= "00"; -- Subcc
				when "001100" => ArithAux <= "00"; -- Subx
				when "011100" => ArithAux <= "00"; -- subxcc
				when "111100" => ArithAux <= "00"; -- SAVE
				when "111101" => ArithAux <= "00"; -- RESTORE
				when "111000" => ArithAux <= "01"; -- JMPL; ArithAux = 01 is a Jump and link case
				when others => ArithAux <= "11"; -- ERROR CASE; ArithAux = 11 is an error case
			end case;
			if(ArithAux = "00")then -- For arithmetic, logical and conditional codes cases
				WriteEnableRf <= '1'; -- Enable writing on register file
				RfSource <= "01"; -- Let pass arithmetic as mux out
				PCSource <= "10"; -- Enable PC as mux out
				ALUOP <= OP3; -- Arithmetic, logical, JMPL and conditional codes operations	
			elsif(ArithAux = "01")then -- For JMPL case
				WriteEnableRf <= '1'; -- Enable writing on register file
				RfSource <= "10"; -- Let pass pc as mux out
				PCSource <= "11"; -- Enable alu result as mux out
				ALUOP <= OP3; -- Arithmetic, logical, JMPL and conditional codes operations
			elsif(ArithAux = "11")then -- For error cases
				WriteEnableRf <= '0'; -- Disable writing on register file
				RfSource <= "01"; -- Let pass arithmetic error case as mux out
				PCSource <= "10"; -- Enable PC as mux out
				ALUOP <= "111111"; -- This will tell alu that is an error case
			end if;
			RfDest <= '0'; -- Let pass register destination
			WriteEnableDm <= '0'; -- Disable writing on data memory
		elsif(OP = "11")then -- LOAD and STORE FORMAT 3
			case OP3 is
				when "000100" => -- STORE
					WriteEnableDm <= '1'; -- Enable writing on data memory
					WriteEnableRf <=  '0'; -- Disable writing on register file
					RfSource <= "01"; -- Let pass arithmetic as mux out
					ALUOP <= "000000"; -- Add operation
				when "000000" => -- LOAD
					WriteEnableDm <= '0'; -- Disable writing on data memory
					WriteEnableRf <= '1'; -- Enable writing on register file
					RfSource <= "00"; -- Let pass data memory as mux out
					ALUOP <= "000000"; -- Add operation
				when others => -- Error cases
					WriteEnableDm <= '0'; -- Disable writing on data memory
					WriteEnableRF <= '0'; -- Disable writing on register file
					RfSource <= "01"; -- Let pass arithmetic as mux out
					ALUOP <= "111111"; -- This will tell alu that is an error case
			end case;
			PCSource <= "10"; -- Enable PC as mux out
			RfDest <= '0'; -- Let pass register destination
		end if;
	end process;
end Behavioral;
