library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MuxDataMemory is
    Port ( dataMemory : in  STD_LOGIC_VECTOR (31 downto 0);
           aluResult : in  STD_LOGIC_VECTOR (31 downto 0);
           pc : in  STD_LOGIC_VECTOR (31 downto 0);
           rfSource : in  STD_LOGIC_VECTOR (1 downto 0);
           outMux : out  STD_LOGIC_VECTOR (31 downto 0));
end MuxDataMemory;

architecture Behavioral of MuxDataMemory is

begin
	process(rfSource,dataMemory,aluResult,pc)
	begin
		if(rfSource = "00")then -- Let pass data memory
			outMux <= dataMemory;
		elsif(rfSource = "01")then -- Let pass alu result
			outMux <= aluResult;
		elsif(rfSource = "10")then -- Let pass pc
			outMux <= pc;
		end if;
	end process;

end Behavioral;

