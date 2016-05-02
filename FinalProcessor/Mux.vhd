library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux is
    Port ( CRs2 : in  STD_LOGIC_VECTOR (31 downto 0);
           IMM13 : in  STD_LOGIC_VECTOR (31 downto 0);
           I : in STD_LOGIC;
			  OutMux : out  STD_LOGIC_VECTOR (31 downto 0));
end Mux;

architecture Behavioral of Mux is

begin
	process(I,CRs2,IMM13)
	begin
		if(I = '1')then
			OutMux <= IMM13;
		else
			OutMux <= CRs2;
		end if;
	end process;
end Behavioral;
