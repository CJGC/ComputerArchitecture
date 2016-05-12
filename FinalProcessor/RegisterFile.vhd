library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use std.textio.all;

entity registerFile is
    Port (
			  reset : in  STD_LOGIC;
           registerSource1 : in  STD_LOGIC_VECTOR (5 downto 0);
           registerSource2 : in  STD_LOGIC_VECTOR (5 downto 0);
           registerDestination : in  STD_LOGIC_VECTOR (5 downto 0);
			  we : in STD_LOGIC;
			  dataToWrite : in STD_LOGIC_VECTOR (31 downto 0);
           contentRegisterSource1 : out  STD_LOGIC_VECTOR (31 downto 0);
           contentRegisterSource2 : out  STD_LOGIC_VECTOR (31 downto 0);
			  contentRegisterDestination : out STD_LOGIC_VECTOR (31 downto 0));
end registerFile;

architecture arqRegisterFile of registerFile is

	type ram_type is array (0 to 31) of std_logic_vector (31 downto 0);
	
	impure function initRamFromFile(RamFileName : in string) return ram_type is
		FILE RamFile : text open read_mode is RamFileName;
		variable temp_mem : ram_type;
		variable RamFileLine : line;
		variable temp_bv : bit_vector(31 downto 0);
		begin
			for i in ram_type'range loop
				readline(RamFile, RamFileLine);
				read(RamFileLine, temp_bv);
				temp_mem(i) := to_stdlogicvector(temp_bv);
			end loop;
			return temp_mem;
		end function;
		
	signal registers : ram_type := initRamFromFile("DataRam.txt");
	
begin
	process(reset,registerDestination,registerSource1,registerSource2,dataToWrite,registers,we)
	begin
		if(reset = '1')then
			contentRegisterSource1 <= (others=>'0');
			contentRegisterSource2 <= (others=>'0');
			contentRegisterDestination <= (others=>'0');
			registers <= initRamFromFile("DataRam.txt");
		else		
			contentRegisterSource1 <= registers(conv_integer(registerSource1));
			contentRegisterSource2 <= registers(conv_integer(registerSource2));
			contentRegisterDestination <= registers(conv_integer(registerDestination));
			if(registerDestination /= "0000" and we = '1') then registers(conv_integer(registerDestination)) <= dataToWrite;
			end if;
		end if;
	end process;
end arqRegisterFile;