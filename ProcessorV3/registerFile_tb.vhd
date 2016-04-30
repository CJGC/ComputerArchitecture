LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.std_logic_unsigned.all;

ENTITY registerFile_tb IS
END registerFile_tb;
 
ARCHITECTURE behavior OF registerFile_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT registerFile
    PORT(
         reset : IN  std_logic;
         registerSource1 : IN  std_logic_vector(4 downto 0);
         registerSource2 : IN  std_logic_vector(4 downto 0);
         registerDestination : IN  std_logic_vector(4 downto 0);
         dataToWrite : IN  std_logic_vector(31 downto 0);
         contentRegisterSource1 : OUT  std_logic_vector(31 downto 0);
         contentRegisterSource2 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;

   --Inputs
   signal reset : std_logic := '0';
   signal registerSource1 : std_logic_vector(4 downto 0) := (others => '0');
   signal registerSource2 : std_logic_vector(4 downto 0) := "00001";
   signal registerDestination : std_logic_vector(4 downto 0) := (others => '0');
   signal dataToWrite : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal contentRegisterSource1 : std_logic_vector(31 downto 0);
   signal contentRegisterSource2 : std_logic_vector(31 downto 0);

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: registerFile PORT MAP (
          reset => reset,
          registerSource1 => registerSource1,
          registerSource2 => registerSource2,
          registerDestination => registerDestination,
          dataToWrite => dataToWrite,
          contentRegisterSource1 => contentRegisterSource1,
          contentRegisterSource2 => contentRegisterSource2
        );

   -- Stimulus process
   stim_proc: process
   begin
      wait for 100 ns;
		registerSource1 <= registerSource1 + "10";
		registerSource2 <= registerSource2 + "10";
      wait for 100 ns;
		registerSource1 <= registerSource1 + "10";
		registerSource2 <= registerSource2 + "10";
		wait for 100 ns;
		dataToWrite <= (others => '1');
		registerDestination <= registerDestination + '1';
		registerSource1 <= (others => '0');
		registerSource2 <= (others => '0');
		wait for 100 ns;
		registerDestination <= registerDestination + '1';
		registerSource1 <= registerSource1 + '1';
		wait for 100 ns;
		reset <= '1';
		registerDestination <= registerDestination + '1';
		registerSource1 <= registerSource1 + '1';
      wait;
   end process;

END;
