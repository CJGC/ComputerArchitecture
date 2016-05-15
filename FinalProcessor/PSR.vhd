library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PSR is
    Port ( CLK : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
			  nCWP : in STD_LOGIC;
           NZVC : in  STD_LOGIC_VECTOR (3 downto 0);
			  ICC : out STD_LOGIC_VECTOR (3 downto 0);
           Carry : out  STD_LOGIC;
			  CWP : out STD_LOGIC);
end PSR;

architecture Behavioral of PSR is
	-- [31:28], [27:24], [23:20], [19:14],  [13], [12], [11:8], [7], [6], [5], [4:0]
	-- [Impl],   [Ver],   [ICC], [Reserved],[EC], [EF], [PIL],  [S], [PS],[ET],[CWP]
begin

	process(CLK,Reset,nCWP,NZVC)
	begin
		if(Reset = '1') then
			Carry <= '0'; -- Default value
			CWP <= '0'; -- Windows 0 ; Default value
			ICC <= "0000"; -- Default value
		else
			if(rising_edge(CLK)) then
				Carry <= NZVC(0); -- C bit
				CWP <= nCWP; -- CWP bit
				ICC <= NZVC; -- NZVC
			end if;
		end if;
	end process;

end Behavioral;
