library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity CallAndBranchAdder is
    Port ( PC : in  STD_LOGIC_VECTOR (31 downto 0);
           Disp : in  STD_LOGIC_VECTOR (31 downto 0);
           AdderOut : out  STD_LOGIC_VECTOR (31 downto 0));
end CallAndBranchAdder;

architecture Behavioral of CallAndBranchAdder is

begin
	AdderOut <= PC + Disp;
end Behavioral;
