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
			OP2 : IN STD_LOGIC_VECTOR (2 downto 0);
         OP3 : IN  std_logic_vector(5 downto 0);
			COND : in STD_LOGIC_VECTOR (3 downto 0);
			ICC : in STD_LOGIC_VECTOR (3 downto 0);
			WriteEnableDM : out STD_LOGIC;
			WriteEnableRf : out STD_LOGIC;
			RfDest : out STD_LOGIC;
			RfSource : out STD_LOGIC_VECTOR (1 downto 0);
			PCSource : out STD_LOGIC_VECTOR (1 downto 0);
         ALUOP : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;

   --Inputs
   signal OP : std_logic_vector(1 downto 0) := "00"; -- Branch and Nop FORMAT 2
	signal OP2 : std_logic_vector(2 downto 0) := "010"; -- Branch on integer conditional codes
   signal OP3 : std_logic_vector(5 downto 0) := (others => '0'); -- Integer operation
	signal COND : std_logic_vector(3 downto 0) := "1000"; -- Branch always
	signal ICC : std_logic_vector(3 downto 0) := "0000"; -- Not z

 	--Outputs
	signal WriteEnableDM : std_logic;
	signal WriteEnableRf : std_logic;
	signal RfDest : std_logic;
	signal RfSource : std_logic_vector (1 downto 0);
	signal PCSource : std_logic_vector (1 downto 0);
   signal ALUOP : std_logic_vector(5 downto 0);

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CU PORT MAP (
          OP => OP,
			 OP2 => OP2,
          OP3 => OP3,
			 COND => COND,
			 ICC => ICC,
			 WriteEnableDM => WriteEnableDM,
			 WriteEnableRf => WriteEnableRf,
			 RfDest => RfDest,
			 RfSource => RfSource,
			 PCSource => PCSource,
          ALUOP => ALUOP
        );
	
   -- Stimulus process
   stim_proc: process
   begin		
      wait for 100 ns;
		COND <= "0000"; -- Branch never
		wait for 100 ns;
		COND <= "1001"; -- Branch on not equal
		wait for 100 ns;
		ICC <= "0100"; -- Zero on ; NZVC
		COND <= "0001"; -- Branch on equal
		wait for 100 ns;
		COND <= "1010"; -- Branch on greater
		ICC <= "0001"; -- Not Z,N,V ; NZVC
		wait for 100 ns;
		COND <= "0010"; -- Branch on less or equal
		ICC <= "1101"; -- Z,N,not V ; NZVC
		wait for 100 ns;
		COND <= "1011"; -- Branch on greater or equal
		ICC <= "1111"; -- N,V ; NZVC
		wait for 100 ns;
		COND <= "0011"; -- Branch on less
		ICC <= "1001"; -- N,not V ; NZVC
		wait for 100 ns;
		COND <= "1100"; -- Branch on greater unsigned
		ICC <= "1010"; -- not Z,not C ; NZVC
		wait for 100 ns;
		COND <= "0100"; -- Branch on less or equal unsigned
		ICC <= "0101"; -- Z,C ; NZVC
		wait for 100 ns;
		COND <= "1101"; -- Branch on carry clear
		ICC <= "0000"; -- not C ; NZVC
		wait for 100 ns;
		COND <= "0101"; -- Branch on carry set
		ICC <= "0001"; -- C ; NZVC
		wait for 100 ns;
		COND <= "1110"; -- Branch on positive
		ICC <= "0101"; -- not N ; NZVC
		wait for 100 ns;
		COND <= "0110"; -- Branch on negative
		ICC <= "1000"; -- N ; NZVC
		wait for 100 ns;
		COND <= "1111"; -- Branch on overflow clear
		ICC <= "0001"; -- not V ; NZVC
		wait for 100 ns;
		COND <= "0111"; -- Branch on overflow set 
		ICC <= "0010"; -- V ; NZVC
		wait for 100 ns;
		OP2 <= "100"; -- No operation
		wait for 100 ns;
		OP <= "01"; -- CALL FORMAT 1
		wait for 100 ns;
		OP <= "10"; -- Arithmetic instructions FORMAT 3
		wait for 100 ns;
		OP3 <= "111000"; -- JMPL
		wait for 100 ns;
		OP3 <= "111111"; -- Error case
		wait for 100 ns;
		OP <= "11"; -- LOAD and STORE FORMAT 3
		OP3 <= "000100"; -- STORE
		wait for 100 ns;
		OP3 <= "000000"; -- LOAD
		wait for 100 ns;
		OP3 <= "111111"; -- Error case
      wait;
   end process;

END;
