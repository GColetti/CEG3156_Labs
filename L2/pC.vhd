library IEEE;
use IEEE.Std_Logic_1164.all;

entity pC is 
	port(
	currentAddress: in std_logic_vector(7 downto 0);
	en: in std_logic;
	nextAddress: out std_logic_vector(7 downto 0));
	end pC;
architecture pC_Arch of pC is 
signal current_address, next_address, incBy, enable: std_logic_vector(7 downto 0);
signal ignoreCarry: std_logic;
component rippleAdder8bit port(
	x,y : in std_logic_vector(7 downto 0);
	Cin : in std_logic;
	Sum: out std_logic_vector(7 downto 0);
	Carry: out std_logic
	);
	end component;
component mux2x1 port( v1, v2 : in std_logic;
	sel : in std_logic;
	output: out std_logic_vector);
	end component;
begin 
current_address <= currentAddress;
enable(0) <= en and '1';
enable(1) <= en and '1';
enable(2) <= en and '1';
enable(3) <= en and '1';
enable(4) <= en and '1';
enable(5) <= en and '1';
enable(6) <= en and '1';
enable(7) <= en and '1';
incBy <= enable and "00000100";
L1: rippleAdder8bit port map (current_address, incBy, '0', next_address, ignoreCarry);
nextAddress<=next_address;
end pC_Arch;



