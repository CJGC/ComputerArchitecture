library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nPC is
    Port ( CLK : in  STD_LOGIC;
           nPCin : in  STD_LOGIC_VECTOR (31 downto 0);
           nPCout_PCin : out  STD_LOGIC_VECTOR (31 downto 0);
           rst : in  STD_LOGIC);
end nPC;

architecture Behavioral of nPC is

begin
	process(CLK,rst,nPCin)
	begin
		if(rst = '1')then
			nPCout_PCin <= (others => '0');
		else	
			if(rising_edge(CLK))then
				nPCout_PCin <= nPCin;
			end if;
		end if;
	end process;
end Behavioral;