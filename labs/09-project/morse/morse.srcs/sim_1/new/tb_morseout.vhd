library ieee;
  use ieee.std_logic_1164.all;


entity tb_morseout is

end tb_morseout;

architecture testbench of tb_morseout is
constant c_CLK_100MHZ_PERIOD : time := 10 ns; -- constant of clock signal period which corresponds to the one used by the nexys board
  -- Local signals
  signal sig_clk_100mhz : std_logic;
  signal sig_rst        : std_logic;
  signal sig_start      : std_logic;
  signal sig_outp       : std_logic;
  signal sig_proc       : std_logic_vector(2 downto 0);
  
begin

  uut_morseout : entity work.morseout
    port map (
      clke   => sig_clk_100mhz,
      rst   => sig_rst,
      tim => "1110101110111000000000", -- hardcode one character to input port, -.-- <=> Y
      start => sig_start,
      outp => sig_outp,
      proc => sig_proc
    );
    
  p_clk_gen : process is
  begin

    while now < 10000 ns loop -- 10 usec of simulation

      sig_clk_100mhz <= '0';
      wait for c_CLK_100MHZ_PERIOD / 2;
      sig_clk_100mhz <= '1';
      wait for c_CLK_100MHZ_PERIOD / 2;

    end loop;

    wait;

  end process p_clk_gen;
  
  p_reset_gen : process is
  begin

    sig_rst <= '0';
    wait for 293 ns;

    -- Reset activated
    sig_rst <= '1';
    wait for 10 ns;

    -- Reset deactivated
    sig_rst <= '0';
	
    wait;

  end process p_reset_gen;
  
  p_start_gen : process is
  begin

    sig_start <= '0'; wait for 18 ns;
    sig_start <= '1'; wait for 18 ns;
    sig_start <= '0'; wait for 200 ns;
    sig_start <= '1'; wait for 18 ns;
    
    -- Reset deactivated
    sig_start <= '0';
	
    wait;

  end process p_start_gen;

end architecture testbench;
