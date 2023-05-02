library ieee;
  use ieee.std_logic_1164.all;


entity tb_morsein is

end tb_morsein;

architecture testbench of tb_morsein is
constant c_CLK_100MHZ_PERIOD : time := 10 ns; -- constant of clock signal period which corresponds to the one used by the nexys board
  -- Local signals 
  signal sig_clk_100mhz : std_logic;
  signal sig_rst        : std_logic;
  signal sig_tim        : std_logic_vector(21 downto 0);
  signal sig_inp        : std_logic;
  
begin

  uut_morsein : entity work.morsein
    port map (
      clke   => sig_clk_100mhz,
      rst   => sig_rst,
      inp => sig_inp,
      tim => sig_tim
    );
    
  p_clk_gen : process is
  begin

    while now < 1000 ns loop -- 1 usec of simulation

      sig_clk_100mhz <= '0';
      wait for c_CLK_100MHZ_PERIOD / 2;
      sig_clk_100mhz <= '1';
      wait for c_CLK_100MHZ_PERIOD / 2;

    end loop;

    wait;

  end process p_clk_gen;
  
  p_reset_gen : process is
  begin

    sig_rst <= '0'; wait for 120 ns;
    sig_rst <= '1'; wait for 18 ns; 
    -- Reset activated

    sig_rst <= '0';
    -- Reset deactivated
	
    wait;

  end process p_reset_gen;
  
  p_inp_gen : process is -- Generate sequence which corresponds to certain characters
  begin

    sig_inp <= '0'; wait for 10 ns;
    sig_inp <= '1'; wait for 30 ns;
    sig_inp <= '0'; wait for 10 ns;
	-- -
    sig_inp <= '1'; wait for 10 ns;
    sig_inp <= '0'; wait for 10 ns;
	-- .
    sig_inp <= '1'; wait for 30 ns;
    sig_inp <= '0'; wait for 40 ns;
	-- -
    --    -.- <=> K 
    sig_inp <= '0'; wait for 10 ns;
    sig_inp <= '1'; wait for 30 ns;
    sig_inp <= '0'; wait for 10 ns;
	-- -
    sig_inp <= '1'; wait for 10 ns;
    sig_inp <= '0'; wait for 10 ns;
	-- .
    sig_inp <= '1'; wait for 10 ns;
    sig_inp <= '0'; wait for 30 ns;
	-- .
	--    -.. <=> D
            
    sig_inp <= '0';
	
    wait;

  end process p_inp_gen;

end architecture testbench;
