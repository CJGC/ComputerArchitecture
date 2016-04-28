library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity Adder is
    Port ( AdderInput1 : in  STD_LOGIC_VECTOR (5 downto 0);
           nPCout_PCin : in  STD_LOGIC_VECTOR (5 downto 0);
           AdderOut : out  STD_LOGIC_VECTOR (5 downto 0));
end Adder;

architecture Behavioral of Adder is

begin
	AdderOut <= nPCout_PCin + AdderInput1;
end Behavioral;

