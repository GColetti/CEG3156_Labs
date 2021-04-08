library ieee;
use ieee.std_logic_1164.all;

Entity IF_ID is
    Port (instruction : in std_logic_vector(31 downto 0);
          pcplus4     : in std_logic_vector(31 downto 0);
          clk         : in std_logic;
          instr_out   : out std_logic_vector(31 downto 0);
          pc_out      : out std_logic_vector(31 downto 0));
    End;

Architecture rtl of IF_ID is
begin
  process(clk)
  begin
      if( clk'event and clk = '1') then
          instr_out <= instruction;
          pc_out <= pcplus4;
      end if;
  end process;
end;
