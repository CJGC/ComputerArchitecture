library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use std.textio.all;

entity instructionMemory is
    Port ( 
			  address : in  STD_LOGIC_VECTOR (31 downto 0);
           reset : in  STD_LOGIC;
           outInstruction : out  STD_LOGIC_VECTOR (31 downto 0));
end instructionMemory;

architecture arqInstructionMemory of instructionMemory is

	type rom_type is array (0 to 63) of std_logic_vector (31 downto 0);
	
	impure function InitRomFromFile (RomFileName : in string) return rom_type is
		FILE RomFile : text open read_mode is RomFileName;
		variable RomFileLine : line; --Type line, will contain the read line from the file
		variable temp_bv : bit_vector(31 downto 0); --Will store read line in variable temp_bv of type bit vector with cast
		variable temp_mem : rom_type; --Defined matrix from my own defined type rom_type, that will store data read from the file
		begin
			for i in rom_type'range loop
				readline (RomFile, RomFileLine); --Store a read line on RomFileLine
				read(RomFileLine, temp_bv); --pass the read line the type line to temp_bv of type bit vector
				temp_mem(i) := to_stdlogicvector(temp_bv); --cast bit vector to logic vector and then store data on matrix
			end loop;
			return temp_mem;
		end function;
	
	signal instructions : rom_type := InitRomFromFile("DataRom.txt");
	
begin
	process(reset,address, instructions)
	begin
			if(reset = '1')then
				outInstruction <= (others=>'0');
				instructions <= InitRomFromFile("DataRom.txt");
			else
				outInstruction <= instructions(conv_integer(address));
			end if;
	end process;
end arqInstructionMemory;