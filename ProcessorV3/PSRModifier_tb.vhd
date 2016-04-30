LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY PSRModifier_tb IS
END PSRModifier_tb;
 
ARCHITECTURE behavior OF PSRModifier_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT PSRModifier
    PORT(
         CRs1 : IN  std_logic_vector(31 downto 0);
         Operand2 : IN  std_logic_vector(31 downto 0);
         AluOp : IN  std_logic_vector(5 downto 0);
         AluResult : IN  std_logic_vector(31 downto 0);
         NZVC : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;

   --Inputs
   signal CRs1 : std_logic_vector(31 downto 0) := (others => '0');
   signal Operand2 : std_logic_vector(31 downto 0) := (others => '1');
   signal AluOp : std_logic_vector(5 downto 0) := "010000"; -- ADDcc between CRs1 and Operand2
   signal AluResult : std_logic_vector(31 downto 0) := (others => '1'); -- Result from CRs1 + Operand2

 	--Outputs
   signal NZVC : std_logic_vector(3 downto 0);

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PSRModifier PORT MAP (
          CRs1 => CRs1,
          Operand2 => Operand2,
          AluOp => AluOp,
          AluResult => AluResult,
          NZVC => NZVC
        );

   -- Stimulus process
   stim_proc: process
   begin		
      wait for 100 ns;
      wait;
   end process;

END;
