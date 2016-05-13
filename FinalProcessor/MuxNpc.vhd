library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MuxNpc is
    Port ( PcDisp30 : in  STD_LOGIC_VECTOR (31 downto 0);
           PcDisp22 : in  STD_LOGIC_VECTOR (31 downto 0);
           Pc : in  STD_LOGIC_VECTOR (31 downto 0);
           AluResult : in  STD_LOGIC_VECTOR (31 downto 0);
           PcSource : in  STD_LOGIC_VECTOR (1 downto 0);
           OutMux : out  STD_LOGIC_VECTOR (31 downto 0));
end MuxNpc;

architecture Behavioral of MuxNpc is

begin
	process(PcSource,PcDisp30,PcDisp22,Pc,AluResult)
	begin
		if(PcSource = "00")then -- CALL and LinkInstruction
			OutMux <= PcDisp30;
		elsif(PcSource = "01")then -- Branches
			OutMux <= PcDisp22;
		elsif(PcSource = "10")then -- PC
			OutMux <= Pc;
		elsif(PcSource = "11")then	-- AluResult
			OutMux <= AluResult;
		end if;
	end process;
end Behavioral;

