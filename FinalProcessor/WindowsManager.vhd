library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity WindowsManager is
    Port ( OP : in  STD_LOGIC_VECTOR (1 downto 0);
           OP3 : in  STD_LOGIC_VECTOR (5 downto 0);
           RS1 : in  STD_LOGIC_VECTOR (4 downto 0);
           RS2 : in  STD_LOGIC_VECTOR (4 downto 0);
           RD : in  STD_LOGIC_VECTOR (4 downto 0);
           CWP : in  STD_LOGIC;
           nRS1 : out  STD_LOGIC_VECTOR (5 downto 0);
           nRS2 : out  STD_LOGIC_VECTOR (5 downto 0);
           nRD : out  STD_LOGIC_VECTOR (5 downto 0);
           nCWP : out  STD_LOGIC;
			  Register07 : out std_logic_vector (5 downto 0));
end WindowsManager;

architecture Behavioral of WindowsManager is

	impure function setR(Rn : STD_LOGIC_VECTOR; CWP : STD_LOGIC) return STD_LOGIC_VECTOR is
	variable newRegister : std_logic_vector (5 downto 0);
	begin--  		In registers 24 - 31
		if(Rn >= "11000" and Rn <= "11111")then
			newRegister := conv_std_logic_vector(conv_integer(Rn) - (conv_integer(CWP) * 16),6);
		else-- 				Local register 16 - 23 and Out registers 8 - 15
			if((Rn >= "10000" and Rn <= "10111") or (Rn >= "01000" and Rn <= "01111"))then
				newRegister := conv_std_logic_vector(conv_integer(Rn) + (conv_integer(CWP) * 16),6);
			else -- 		Global register 0 - 7
				if(Rn >= "00000" and Rn <= "00111")then
					newRegister := '0'&Rn; -- Concatenate 0 with Rn
 				end if;
			end if;
		end if;
		return newRegister;
	end function;

begin
	process(OP,OP3,RS1,RS2,RD,CWP)
	begin --							  SAVE
		if(OP = "10" and (OP3 = "111100"))then
			nCWP <= '0'; -- new current windows pointer
		else --							 RESTORE
			if(OP = "10" and (OP3 = "111101"))then
				nCWP <= '1'; -- new current windows pointer
			end if;
		end if;
		nRS1 <= setR(RS1,CWP); -- new register source 1
		nRS2 <= setR(RS2,CWP); -- new register source 2
		nRD <= setR(RD,CWP); -- new register destiny
		Register07 <= conv_std_logic_vector(conv_integer(CWP)*16 + 15,6); -- 07 out
	end process;
end Behavioral;