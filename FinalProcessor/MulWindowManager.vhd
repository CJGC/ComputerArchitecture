library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MulWindowManager is
    Port ( RD : in  STD_LOGIC_VECTOR (5 downto 0);
           Register07 : in  STD_LOGIC_VECTOR (5 downto 0);
           RfDest : in  STD_LOGIC;
           Mux_out : out  STD_LOGIC_VECTOR (5 downto 0));
end MulWindowManager;

architecture Behavioral of MulWindowManager is

begin
	process(RD,Register07,RfDest)
	begin
		if(RfDest = '1')then
			Mux_out <= Register07;
		else
			Mux_out <= RD;
		end if;
	end process;

end Behavioral;

