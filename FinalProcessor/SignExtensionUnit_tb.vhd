LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY SignExtensionUnit_tb IS
END SignExtensionUnit_tb;
 
ARCHITECTURE behavior OF SignExtensionUnit_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SignExtensionUnit
    PORT(
         IMM13 : IN  std_logic_vector(12 downto 0);
         Disp22 : IN  std_logic_vector(21 downto 0);
         Disp30 : IN  std_logic_vector(29 downto 0);
         Selector : IN  std_logic_vector(1 downto 0);
         SignExtensionOut : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;

   --Inputs
   signal IMM13 : std_logic_vector(12 downto 0) := (others => '0');
   signal Disp22 : std_logic_vector(21 downto 0) := "0101010101010101010010";
   signal Disp30 : std_logic_vector(29 downto 0) := (others => '0');
   signal Selector : std_logic_vector(1 downto 0) := (others => '0'); -- Extent Disp22

 	--Outputs
   signal SignExtensionOut : std_logic_vector(31 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SignExtensionUnit PORT MAP (
          IMM13 => IMM13,
          Disp22 => Disp22,
          Disp30 => Disp30,
          Selector => Selector,
          SignExtensionOut => SignExtensionOut
        );

   -- Stimulus process
   stim_proc: process
   begin
      wait for 100 ns;
		Disp30 <= "101010101010101010101010101010";
      Selector <= "01"; -- Extent Disp 30
		wait for 100 ns;
		IMM13 <= "0000000001010";
		Selector <= "10"; -- Extent IMM13
		wait for 100 ns;
		IMM13 <= "0000000000000";
		Selector <= "11"; -- Extent IMM13
		wait;
   end process;

END;
