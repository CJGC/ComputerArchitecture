LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Mux_tb IS
END Mux_tb;

ARCHITECTURE behavior OF Mux_tb IS 

    -- Component Declaration for the Unit Under Test (UUT) 
    COMPONENT Mux
    PORT(
         CRs2 : IN  std_logic_vector(31 downto 0);
         IMM13 : IN  std_logic_vector(31 downto 0);
         I : IN  std_logic;
         OutMux : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;

   --Inputs
   signal CRs2 : std_logic_vector(31 downto 0) := (others => '0');
   signal IMM13 : std_logic_vector(31 downto 0) := (others => '1');
   signal I : std_logic := '0';

 	--Outputs
   signal OutMux : std_logic_vector(31 downto 0);
	
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Mux PORT MAP (
          CRs2 => CRs2,
          IMM13 => IMM13,
          I => I,
          OutMux => OutMux
        );

   -- Stimulus process
   stim_proc: process
   begin		
      wait for 100 ns;
		I <= '1';
      wait;
   end process;

END;
