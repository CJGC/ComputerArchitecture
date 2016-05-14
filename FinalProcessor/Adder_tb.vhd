LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Adder_tb IS
END Adder_tb;
 
ARCHITECTURE behavior OF Adder_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Adder
    PORT(
         Input1 : IN  std_logic_vector(31 downto 0);
         Input2 : IN  std_logic_vector(31 downto 0);
         AdderOut : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    
   --Inputs
   signal Input1 : std_logic_vector(31 downto 0) := (others => '1');
   signal Input2 : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal AdderOut : std_logic_vector(31 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Adder PORT MAP (
          Input1 => Input1,
          Input2 => Input2,
          AdderOut => AdderOut
        );

   -- Stimulus process
   stim_proc: process
   begin
      wait for 100 ns;
		Input2 <= AdderOut;
		wait for 100 ns;
		Input2 <= AdderOut;
		wait for 100 ns;
		Input2 <= AdderOut;
      wait;
   end process;

END;
