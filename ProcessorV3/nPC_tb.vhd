LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.std_logic_unsigned.all;

ENTITY nPC_tb IS
END nPC_tb;
 
ARCHITECTURE behavior OF nPC_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT nPC
    PORT(
         CLK : IN  std_logic;
         nPCin : IN  std_logic_vector(5 downto 0);
         nPCout_PCin : OUT  std_logic_vector(5 downto 0);
         rst : IN  std_logic
        );
    END COMPONENT;

   --Inputs
   signal CLK : std_logic := '0';
   signal nPCin : std_logic_vector(5 downto 0) := (others => '0');
   signal rst : std_logic := '0';

 	--Outputs
   signal nPCout_PCin : std_logic_vector(5 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: nPC PORT MAP (
          CLK => CLK,
          nPCin => nPCin,
          nPCout_PCin => nPCout_PCin,
          rst => rst
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      wait for 100 ns;
		nPCin <= nPCout_PCin + '1';
		wait for 100 ns;
		nPCin <= nPCout_PCin + '1';
		rst <= '1';
      wait;
   end process;

END;
