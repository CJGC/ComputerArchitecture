LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.std_logic_unsigned.all;
 
ENTITY instructionMemory_tb IS
END instructionMemory_tb;
 
ARCHITECTURE behavior OF instructionMemory_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT instructionMemory
    PORT(
         address : IN  std_logic_vector(31 downto 0);
         reset : IN  std_logic;
         outInstruction : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    
   --Inputs
   signal address : std_logic_vector(31 downto 0) := (others => '0');
   signal reset : std_logic := '0';

 	--Outputs
   signal outInstruction : std_logic_vector(31 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: instructionMemory PORT MAP (
          address => address,
          reset => reset,
          outInstruction => outInstruction
        );

   -- Stimulus process
   stim_proc: process
   begin		
      wait for 100 ns;
		address <= address + '1';
		wait for 100 ns;
		address <= address + '1';
		wait for 100 ns;
		address <= address + '1';
		wait for 100 ns;
		address <= address + '1';
		wait for 100 ns;
		address <= address + '1';
		wait for 100 ns;
		reset <= '1';
		address <= address + '1';
      wait;
   end process;

END;
