----------------------------------------------------------
--
--! @title Driver for 4-digit 7-segment display
--! @author Tomas Fryza
--! Dept. of Radio Electronics, Brno Univ. of Technology, Czechia
--!
--! @copyright (c) 2020 Tomas Fryza
--! This work is licensed under the terms of the MIT license
--
-- Hardware: Nexys A7-50T, xc7a50ticsg324-1L
-- Software: TerosHDL, Vivado 2020.2, EDA Playground
--
----------------------------------------------------------

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

----------------------------------------------------------
-- Entity declaration for display driver
--
--             +-------------------+
--        -----|> clk              |
--        -----| rst            dp |-----
--             |          seg(6:0) |--/--
--        --/--| data0(3:0)        |  7
--        --/--| data1(3:0)        |
--        --/--| data2(3:0)        |
--        --/--| data3(3:0)        |
--          4  |           dig(3:0)|--/--
--        --/--| dp_vect(3:0)      |  4
--          4  +-------------------+
--
-- Inputs:
--   clk          -- Main clock
--   rst          -- Synchronous reset
--   dataX(3:0)   -- Data values for individual digits
--   dp_vect(3:0) -- Decimal points for individual digits
--   start
--   spk   
--
-- Outputs:
--   dp:          -- Decimal point for specific digit
--   seg(6:0)     -- Cathode values for individual segments
--   dig(3:0)     -- Common anode signals to individual digits
--
----------------------------------------------------------

entity morseout is
  port (
    clk     : in    std_logic;
    rst     : in    std_logic;
    start   : in    std_logic;
    data0   : in    std_logic_vector(4 downto 0);
    spk     : out   std_logic_vector(6 downto 0)
  );
end entity morseout;

----------------------------------------------------------
-- Architecture declaration for display driver
----------------------------------------------------------

architecture behavioral of morseout is

  -- Internal clock enable
  signal sig_en : std_logic;


  signal sig_cnt_22bit : std_logic_vector(21 downto 0);
  
  
  signal sig_timing : std_logic_vector(21 downto 0);

  -- Internal 5-bit value for morse char
  signal sig_bin : std_logic_vector(4 downto 0);

begin

  --------------------------------------------------------
  -- Instance (copy) of clock_enable entity generates
  -- an enable pulse every 4 ms
  --------------------------------------------------------
  clk_en0 : entity work.clock_enable
    generic map (
      -- FOR SIMULATION, KEEP THIS VALUE TO 4
      -- FOR IMPLEMENTATION, CHANGE THIS VALUE TO 400,000
      -- 4      @ 4 ns
      -- 400000 @ 4 ms
      g_MAX => 40000000
    )
    port map (
      clk => clk,
      rst => rst,
      ce  => sig_en
    );

  --------------------------------------------------------
  -- Instance (copy) of cnt_up_down entity performs
  -- a 2-bit down counter
  --------------------------------------------------------
  bin_cnt0 : entity work.cnt_up_down
    generic map (
      g_CNT_WIDTH => 22
    )
    port map (
      clk    => clk,
      rst    => rst,
      en     => sig_en,
      cnt_up => '0',
      cnt => sig_cnt_22bit
    );

  --------------------------------------------------------
  -- Instance (copy) of hex_7seg entity performs
  -- a 7-segment display decoder
  --------------------------------------------------------
  binmorse : entity work.bin2morse
    port map (
      bin   => sig_bin,
      seg   => sig_timing
    );

  --------------------------------------------------------
  -- p_mux:
  -- A sequential process that implements a multiplexer for
  -- selecting data for a single digit, a decimal point,
  -- and switches the common anodes of each display.
  --------------------------------------------------------
  p_mux : process (clk) is
  begin

    if start = '1' then
        
    end if;

  end process p_mux;

end architecture behavioral;