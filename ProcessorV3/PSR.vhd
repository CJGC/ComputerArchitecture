library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PSR is
    Port ( CLK : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Operand2 : in  STD_LOGIC_VECTOR (31 downto 0);
           NZVC : in  STD_LOGIC_VECTOR (3 downto 0);
           Carry : out  STD_LOGIC);
end PSR;

architecture Behavioral of PSR is

	-- [31:28], [27:24], [23:20], [19:14],  [13], [12], [11:8], [7], [6], [5], [4:0]
	-- [Impl],   [Ver],   [ICC], [Reserved],[EC], [EF], [PIL],  [S], [PS],[ET],[CWP]
	signal PSRRegister : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');

begin

	process(CLK,Reset,Operand2,NZVC)
	begin
		if(Reset = '1') then
			Carry <= '0';
		else
			if(rising_edge(CLK)) then
				PSRRegister(23 downto 20) <= NZVC; -- [ICC]
				Carry <= PSRRegister(20); -- C bit
			end if;
		end if;
	end process;

end Behavioral;

