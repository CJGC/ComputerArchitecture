LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY PSR_tb IS
END PSR_tb;
 
ARCHITECTURE behavior OF PSR_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PSR
    PORT(
         CLK : IN  std_logic;
         Reset : IN  std_logic;
			nCWP : IN STD_LOGIC;
         Operand2 : IN  std_logic_vector(31 downto 0);
         NZVC : IN  std_logic_vector(3 downto 0);
         Carry : OUT  std_logic;
			ICC : OUT STD_LOGIC_VECTOR (3 downto 0);
			CWP : OUT STD_LOGIC
        );
    END COMPONENT;

   --Inputs
   signal CLK : std_logic := '1';
   signal Reset : std_logic := '0';
	signal nCWP : std_logic := '0'; -- Window 0
   signal Operand2 : std_logic_vector(31 downto 0) := (others => '0');
   signal NZVC : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal Carry : std_logic;
	signal ICC : STD_LOGIC_VECTOR (3 downto 0);
	signal CWP : STD_LOGIC;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PSR PORT MAP (
          CLK => CLK,
          Reset => Reset,
			 nCWP => nCWP,
          Operand2 => Operand2,
          NZVC => NZVC,
          Carry => Carry,
			 ICC => ICC,
			 CWP => CWP
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
		NZVC <= "0001";
		nCWP <= '1';
		wait for 100 ns;
		Reset <= '1';
      wait;
   end process;

END;
