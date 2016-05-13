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
         registerSource1 : IN  std_logic_vector(5 downto 0);
         registerSource2 : IN  std_logic_vector(5 downto 0);
         registerDestination : IN  std_logic_vector(5 downto 0);
			we : in std_logic;
         dataToWrite : IN  std_logic_vector(31 downto 0);
         contentRegisterSource1 : OUT  std_logic_vector(31 downto 0);
         contentRegisterSource2 : OUT  std_logic_vector(31 downto 0);
			contentRegisterDestination : OUT std_logic_vector (31 downto 0)
        );
    END COMPONENT;

   --Inputs
   signal reset : std_logic := '0';
   signal registerSource1 : std_logic_vector(5 downto 0) := (others => '0');
   signal registerSource2 : std_logic_vector(5 downto 0) := "000001";
   signal registerDestination : std_logic_vector(5 downto 0) := (others => '0');
   signal we : std_logic := '1';
	signal dataToWrite : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal contentRegisterSource1 : std_logic_vector(31 downto 0);
   signal contentRegisterSource2 : std_logic_vector(31 downto 0);
	signal contentRegisterDestination : std_logic_vector(31 downto 0);

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: registerFile PORT MAP (
          reset => reset,
          registerSource1 => registerSource1,
          registerSource2 => registerSource2,
          registerDestination => registerDestination,
			 we => we,
          dataToWrite => dataToWrite,
          contentRegisterSource1 => contentRegisterSource1,
          contentRegisterSource2 => contentRegisterSource2,
			 contentRegisterDestination => contentRegisterDestination
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
		we <= '0';
		registerDestination <= registerDestination + '1';
		registerSource1 <= registerSource1 + '1';
		wait for 100 ns;
		reset <= '1';
		registerDestination <= registerDestination + '1';
		registerSource1 <= registerSource1 + '1';
      wait;
   end process;

END;
