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
	begin
		if(Rn >= "11000" and Rn <= "11111")then --In registers 24 - 31
			newRegister := conv_std_logic_vector(conv_integer(Rn) - (conv_integer(CWP) * 16),6);						
		elsif((Rn >= "10000" and Rn <= "10111") or (Rn >= "01000" and Rn <= "01111"))then -- Local register 16 - 23 and Out registers 8 - 15
				newRegister := conv_std_logic_vector(conv_integer(Rn) + (conv_integer(CWP) * 16),6);
		elsif(Rn >= "00000" and Rn <= "00111")then --Global register 0 - 7
					newRegister := '0'&Rn; -- Concatenate 0 with Rn
		end if;
		return newRegister;
	end function;

begin
	process(OP,OP3,RS1,RS2,RD,CWP)
	begin
		if(OP = "10" and (OP3 = "111100"))then-- SAVE
			nCWP <= '0'; -- New current windows pointer
		elsif(OP = "10" and (OP3 = "111101"))then -- RESTORE
			nCWP <= '1'; -- New current windows pointer
		end if;
		nRS1 <= setR(RS1,CWP); -- New register source 1
		nRS2 <= setR(RS2,CWP); -- New register source 2
		nRD <= setR(RD,CWP); -- New register destination
		Register07 <= conv_std_logic_vector(conv_integer(CWP)*16 + 15,6); -- Register 07
	end process;
end Behavioral;