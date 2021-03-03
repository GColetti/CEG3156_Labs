library IEEE;
use IEEE.Std_Logic_1164.all;

entity registers is 
	port( readRegister1, readRegister2: in std_logic_vector(4 downto 0);
			writeRegister, writeData: in std_logic;
			en: in std_logic;
			readData1, readData2 : out std_logic_vector (7 downto 0)
			);
			end registers;