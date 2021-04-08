library ieee;
use ieee.std_logic_1164.all;

Entity MEM_WB is
    Port (clk           : in std_logic;
          S_RegWriteW   : in std_logic;
          S_MemtoRegW   : in std_logic;
          ReadDataW     : in std_logic_vector(31 downto 0);
          AluOutW       : in std_logic_vector(31 downto 0);
          WriteRegW     : in std_logic_vector(4 downto 0);
          outS_RegWriteW : out std_logic;
          outS_MemtoRegW : out std_logic;
          outReadDataW   : out std_logic_vector(31 downto 0);
          outAluOutW     : out std_logic_vector(31 downto 0);
          outWriteRegW   : out std_logic_vector(4 downto 0));
    End;

Architecture rtl of MEM_WB is
    begin
        process(clk)
        begin
            if( clk'event and clk = '1') then
            outS_RegWriteW <= S_RegWriteW;
            outS_MemtoRegW <= S_MemtoRegW;
            outAluOutW <= AluOutW;
            outReadDataW <= ReadDataW;
            outWriteRegW <= WriteRegW;
        end if;
        end process;
    end rtl;