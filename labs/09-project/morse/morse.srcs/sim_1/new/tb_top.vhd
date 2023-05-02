library ieee;
  use ieee.std_logic_1164.all;


entity tb_top is

end tb_top;

architecture testbench of tb_top is
  constant c_CLK_100MHZ_PERIOD : time := 10 ns;
  -- Local signals
  signal sig_rst             : std_logic;
  signal sig_start           : std_logic;
  signal sig_clk_100mhz      : std_logic;
  signal sig_inp             : std_logic;
  signal sig_bin             : std_logic_vector(5 downto 0);

begin

  uut_top : entity work.top
    port map (
      CLK100MHZ => sig_clk_100mhz,
      BTNR => sig_start,
      BTNU => sig_rst,
      SWA => sig_bin,
      MORSE_PIN => sig_inp
    );
  
  p_clk_gen : process is -- Clock signal generation
  begin

    while now < 3000 ns loop -- 3 usec of simulation

      sig_clk_100mhz <= '0';
      wait for c_CLK_100MHZ_PERIOD / 2;
      sig_clk_100mhz <= '1';
      wait for c_CLK_100MHZ_PERIOD / 2;

    end loop;

    wait;

  end process p_clk_gen;
  
  p_reset_gen : process is   -- Reset signal generation
  begin

    sig_rst <= '0'; wait for 400 ns;
    sig_rst <= '1'; wait for 18 ns; 
    -- Reset activated

    sig_rst <= '0';
    -- Reset deactivated
	
    wait;

  end process p_reset_gen;
     
  p_inp_gen : process is  -- Input signal generation process
  begin
	
    sig_inp <= '0'; wait for 10 ns;
    sig_inp <= '1'; wait for 30 ns;
    sig_inp <= '0'; wait for 10 ns;
	-- -
    sig_inp <= '1'; wait for 10 ns;
    sig_inp <= '0'; wait for 10 ns;
	-- .
    sig_inp <= '1'; wait for 30 ns;
    sig_inp <= '0'; wait for 30 ns;
	-- -
	-- Generate sequence -.-
    wait for 100 ns;

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
	-- Generate sequence -.-
    sig_inp <= '0';
	
    wait;

  end process p_inp_gen;
  
  p_bin_gen: process is -- Input character generation process
  begin
    
    sig_bin <= "000001"; -- A
    wait for 500 ns;
    sig_bin <= "100101"; -- 5
    wait for 500 ns;
    sig_bin <= "011010"; -- Z
	
    wait;
    
  end process p_bin_gen;
  
  p_start_gen: process is -- Start signal generation process
  begin
  
    -- enable signal for 50 ns then wait roughly 500ns, repeat twice
	sig_start <= '0'; 
    wait for 10 ns;
    sig_start <= '1';
    wait for 50 ns;
    sig_start <= '0';
    wait for 440 ns;
    sig_start <= '0'; 
    
    wait for 10 ns;
    sig_start <= '1';
    wait for 50 ns;
    sig_start <= '0';
    wait for 440 ns;
    
    sig_start <= '0'; 
    wait for 10 ns;
    sig_start <= '1';
    wait for 50 ns;
    sig_start <= '0';
    wait for 440 ns;    
 
    wait;
    
  end process p_start_gen;

end architecture testbench;
