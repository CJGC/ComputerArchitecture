library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SignExtensionUnit is
    Port ( IMM13 : in  STD_LOGIC_VECTOR (12 downto 0);
           IMM13Extended : out  STD_LOGIC_VECTOR (31 downto 0));
end SignExtensionUnit;

architecture Behavioral of SignExtensionUnit is

	signal packOne : std_logic_vector (31 downto 0) := (others=>'1');
	signal packZero : std_logic_vector (31 downto 0) := (others => '0');
	
begin

	process(IMM13,packOne,packZero)
	begin
		if(IMM13(12) = '1')then -- Negative number
			packOne(12 downto 0) <= IMM13;
			IMM13Extended <= packOne;
		else							-- Positive number
			packZero(12 downto 0) <= IMM13;
			IMM13Extended <= packZero;
		end if;
	end process;

end Behavioral;

