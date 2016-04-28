LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Adder_tb IS
END Adder_tb;
 
ARCHITECTURE behavior OF Adder_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Adder
    PORT(
         AdderInput1 : IN  std_logic;
         nPCout_PCin : IN  std_logic_vector(5 downto 0);
         AdderOut : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    
   --Inputs
   signal AdderInput1 : std_logic := '1';
   signal nPCout_PCin : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal AdderOut : std_logic_vector(5 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Adder PORT MAP (
          AdderInput1 => AdderInput1,
          nPCout_PCin => nPCout_PCin,
          AdderOut => AdderOut
        );

   -- Stimulus process
   stim_proc: process
   begin
      wait for 100 ns;
		nPCout_PCin <= AdderOut;
		wait for 100 ns;
		nPCout_PCin <= AdderOut;
		wait for 100 ns;
		nPCout_PCin <= AdderOut;
      wait;
   end process;

END;
