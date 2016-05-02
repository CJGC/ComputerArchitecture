library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PC is
    Port ( CLK : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           PCin : in  STD_LOGIC_VECTOR (5 downto 0);
           address : out  STD_LOGIC_VECTOR (5 downto 0));
end PC;

architecture Behavioral of PC is

begin

	process(CLK,rst,Pcin)
	begin
		if(rst = '1')then
			address <= (others => '0');
		else	
			if(rising_edge(CLK))then
				address <= PCin;
			end if;
		end if;
	end process;

end Behavioral;

