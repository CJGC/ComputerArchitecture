LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY SignExtensionUnit_tb IS
END SignExtensionUnit_tb;
 
ARCHITECTURE behavior OF SignExtensionUnit_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SignExtensionUnit
    PORT(
         IMM13 : IN  std_logic_vector(12 downto 0);
         IMM13Extended : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;

   --Inputs
   signal IMM13 : std_logic_vector(12 downto 0) := (others => '0');

 	--Outputs
   signal IMM13Extended : std_logic_vector(31 downto 0);

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SignExtensionUnit PORT MAP (
          IMM13 => IMM13,
          IMM13Extended => IMM13Extended
        ); 

   -- Stimulus process
   stim_proc: process
   begin
		IMM13 <= "0000000000101"; -- Positive number
      wait for 100 ns;
		IMM13 <= "1111111010101"; -- Negative number
      wait;
   end process;

END;
