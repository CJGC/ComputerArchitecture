LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.std_logic_unsigned.all;
 
ENTITY CU_tb IS
END CU_tb;
 
ARCHITECTURE behavior OF CU_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CU
    PORT(
         OP : IN  std_logic_vector(1 downto 0);
         OP3 : IN  std_logic_vector(5 downto 0);
			WriteEnable : out STD_LOGIC;
         ALUOP : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;

   --Inputs
   signal OP : std_logic_vector(1 downto 0) := "10";
   signal OP3 : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
	signal WriteEnable : std_logic;
   signal ALUOP : std_logic_vector(5 downto 0);

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CU PORT MAP (
          OP => OP,
          OP3 => OP3,
			 WriteEnable => WriteEnable,
          ALUOP => ALUOP
        );
	
   -- Stimulus process
   stim_proc: process
   begin		
      wait for 100 ns;
		OP3 <= ALUOP + '1';
      wait for 100 ns;
		OP3 <= ALUOP + '1';
      wait for 100 ns;
		OP3 <= ALUOP + '1';
		wait for 100 ns;
		OP <= "11";
		OP3 <= "000100"; -- STORE
		wait for 100 ns;
		OP3 <= "000000"; -- LOAD
      wait;
   end process;

END;
