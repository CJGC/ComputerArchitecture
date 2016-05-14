library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SignExtensionUnit is
    Port ( IMM13 : in  STD_LOGIC_VECTOR (12 downto 0);
			  Disp22 : in STD_LOGIC_VECTOR (21 downto 0);
			  Disp30 : in STD_LOGIC_VECTOR (29 downto 0);
			  Selector : in STD_LOGIC_VECTOR (1 downto 0);
           SignExtensionOut : out  STD_LOGIC_VECTOR (31 downto 0));
end SignExtensionUnit;

architecture Behavioral of SignExtensionUnit is

	impure function SignExtend(incompletePack : std_logic_vector;packOne : std_logic_vector;packZero : std_logic_vector;lastBit : integer) return std_logic_vector is
	variable completePack : std_logic_vector (31 downto 0);
	begin
		if(incompletePack(lastBit) = '1')then completePack := packOne&incompletePack; -- Negative number
		else completePack := packZero&incompletePack; -- Positive number
		end if;
		return completePack;
	end function;

begin

	process(Selector,IMM13,Disp22,Disp30)
	begin
		if(Selector = "00")then SignExtensionOut <= SignExtend(IMM13,"1111111111111111111","0000000000000000000",12); -- Extent IMM13
		elsif(Selector = "01")then SignExtensionOut <= SignExtend(Disp22,"1111111111","0000000000",21); -- Extent Disp22
		elsif(Selector = "10")then SignExtensionOut <= SignExtend(Disp30,"11","00",29); -- Extent Disp30
		end if;
	end process;

end Behavioral;
