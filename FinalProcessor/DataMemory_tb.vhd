LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY DataMemory_tb IS
END DataMemory_tb;
 
ARCHITECTURE behavior OF DataMemory_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DataMemory
    PORT(
         WriteEnable : IN  std_logic;
         Rst : IN  std_logic;
         Data : IN  std_logic_vector(31 downto 0);
         Address : IN  std_logic_vector(4 downto 0);
         DataOut : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;

   --Inputs
   signal WriteEnable : std_logic := '0'; -- Reading mode
   signal Rst : std_logic := '0'; -- Disable reset mode
   signal Data : std_logic_vector(31 downto 0) := (others => '0'); -- Data to write
   signal Address : std_logic_vector(4 downto 0) := (others => '0'); -- Address to write or read

 	--Outputs
   signal DataOut : std_logic_vector(31 downto 0);

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DataMemory PORT MAP (
          WriteEnable => WriteEnable,
          Rst => Rst,
          Data => Data,
          Address => Address,
          DataOut => DataOut
        );

   -- Stimulus process
   stim_proc: process
   begin		
      wait for 100 ns;
		Data <= (others => '1');
		WriteEnable <= '1'; -- Writing mode
		wait for 100 ns;
		Rst <= '1'; -- enabled reset mode
		wait for 100 ns;
		Rst <= '0'; -- disabled reset mode
		WriteEnable <= '0'; -- Reading mode
      wait;
   end process;

END;
