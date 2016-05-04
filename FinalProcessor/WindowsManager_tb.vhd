LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY WindowsManager_tb IS
END WindowsManager_tb;
 
ARCHITECTURE behavior OF WindowsManager_tb IS  
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT WindowsManager
    PORT(
         OP : IN  std_logic_vector(1 downto 0);
         OP3 : IN  std_logic_vector(5 downto 0);
         RS1 : IN  std_logic_vector(4 downto 0);
         RS2 : IN  std_logic_vector(4 downto 0);
         RD : IN  std_logic_vector(4 downto 0);
         CWP : IN  std_logic;
         nRS1 : OUT  std_logic_vector(5 downto 0);
         nRS2 : OUT  std_logic_vector(5 downto 0);
         nRD : OUT  std_logic_vector(5 downto 0);
         nCWP : OUT  std_logic
        );
    END COMPONENT;

   --Inputs
   signal OP : std_logic_vector(1 downto 0) := "10";
   signal OP3 : std_logic_vector(5 downto 0) := "111100"; -- SAVE
   signal RS1 : std_logic_vector(4 downto 0) := "11000"; -- In register 24
   signal RS2 : std_logic_vector(4 downto 0) := "11001"; -- In register 25
   signal RD : std_logic_vector(4 downto 0) := "01000"; -- Out register 8
   signal CWP : std_logic := '0'; -- Window 0

 	--Outputs
   signal nRS1 : std_logic_vector(5 downto 0);
   signal nRS2 : std_logic_vector(5 downto 0);
   signal nRD : std_logic_vector(5 downto 0);
   signal nCWP : std_logic;

BEGIN 
	-- Instantiate the Unit Under Test (UUT)
   uut: WindowsManager PORT MAP (
          OP => OP,
          OP3 => OP3,
          RS1 => RS1,
          RS2 => RS2,
          RD => RD,
          CWP => CWP,
          nRS1 => nRS1,
          nRS2 => nRS2,
          nRD => nRD,
          nCWP => nCWP
        );

   -- Stimulus process
   stim_proc: process
   begin
      wait for 100 ns;
		OP3 <= "111101"; -- RESTORE
		CWP <= '1'; -- Windows 1
      wait for 100 ns;
		OP3 <= "111100"; -- SAVE
		CWP <= '0'; -- Windows 0
		wait for 100 ns;
		RS1 <= "00000"; -- Global register 0
		RS2 <= "00001"; -- Global register 1
		wait for 100 ns;
		OP3 <= "111101"; -- RESTORE
		CWP <= '1'; -- Windows 1
		wait;
   end process;

END;
