LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.std_logic_unsigned.all;
 
ENTITY ALU_tb IS
END ALU_tb;
 
ARCHITECTURE behavior OF ALU_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         ALUOP : IN  std_logic_vector(5 downto 0);
         CRs1 : IN  std_logic_vector(31 downto 0);
         CRs2 : IN  std_logic_vector(31 downto 0);
         ALUResult : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    
   --Inputs
   signal ALUOP : std_logic_vector(5 downto 0) := (others => '0'); -- Add
   signal CRs1 : std_logic_vector(31 downto 0) := "00000000000000000000000000000001";
   signal CRs2 : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal ALUResult : std_logic_vector(31 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          ALUOP => ALUOP,
          CRs1 => CRs1,
          CRs2 => CRs2,
          ALUResult => ALUResult
        );

   -- Stimulus process
   stim_proc: process
   begin
      wait for 100 ns;
		ALUOP <= ALUOP + '1'; -- And
		wait for 100 ns;
		ALUOP <= ALUOP + '1'; -- Or
		wait for 100 ns;
		ALUOP <= ALUOP + '1'; -- Xor
		wait for 100 ns;
		ALUOP <= ALUOP + '1'; -- Sub
		wait for 100 ns;
		ALUOP <= ALUOP + '1'; -- AndN
		wait for 100 ns;
		ALUOP <= ALUOP + '1'; -- OrN
		wait for 100 ns;
		ALUOP <= ALUOP + '1'; -- Xnor
		wait for 100 ns;
		ALUOP <= ALUOP + '1'; -- Error case
      wait;
   end process;

END;
