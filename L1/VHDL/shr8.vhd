library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shr8 is
  port(load_input, memory : in std_logic_vector(7 downto 0);
    s : in std_logic_vector(1 downto 0);
    clk : in std_logic;
    output : out std_logic_vector(7 downto 0));
end shr8;

architecture rtl of shr8 is

  signal temp_output, mux_output : std_logic_vector(7 downto 0);

  component enardFF_2
    port(i_resetBar : IN STD_LOGIC; 
      i_d : IN STD_LOGIC; 
      i_enable : IN	STD_LOGIC; 
      i_clock : IN STD_LOGIC; 
      o_q	: OUT	STD_LOGIC);
  end component enardFF_2;

  component mux4
    port(i0, i1, i2, i3, s0, s1 : IN STD_LOGIC; 
          y : OUT STD_LOGIC);
  end component mux4;

begin
  m0: mux4 port map(memory(0), load_input(0), memory(1), memory(7), s(0), s(1), mux_output(0));
  m1: mux4 port map(memory(1), load_input(1), memory(2), memory(0), s(0), s(1), mux_output(1));
  m2: mux4 port map(memory(2), load_input(2), memory(3), memory(1), s(0), s(1), mux_output(2));
  m3: mux4 port map(memory(3), load_input(3), memory(4), memory(2), s(0), s(1), mux_output(3));
  m4: mux4 port map(memory(4), load_input(4), memory(5), memory(3), s(0), s(1), mux_output(4));
  m5: mux4 port map(memory(5), load_input(5), memory(6), memory(4), s(0), s(1), mux_output(5));
  m6: mux4 port map(memory(6), load_input(6), memory(7), memory(5), s(0), s(1), mux_output(6));
  m7: mux4 port map(memory(7), load_input(7), memory(0), memory(6), s(0), s(1), mux_output(7));
  bit0: enARdFF_2 port map('1', mux_output(0), '1', clk, temp_output(0));
  bit1: enARdFF_2 port map('1', mux_output(1), '1', clk, temp_output(1));
  bit2: enARdFF_2 port map('1', mux_output(2), '1', clk, temp_output(2));
  bit3: enARdFF_2 port map('1', mux_output(3), '1', clk, temp_output(3));
  bit4: enARdFF_2 port map('1', mux_output(4), '1', clk, temp_output(4));
  bit5: enARdFF_2 port map('1', mux_output(5), '1', clk, temp_output(5));
  bit6: enARdFF_2 port map('1', mux_output(6), '1', clk, temp_output(6));
  bit7: enARdFF_2 port map('1', mux_output(7), '1', clk, temp_output(7));
  output <= temp_output;
  
end rtl;
