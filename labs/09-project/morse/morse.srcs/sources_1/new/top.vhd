----------------------------------------------------------------------------------
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
  port (
    CLK100MHZ   : in    std_logic;                    --! Main clock
    BTNR        : in    std_logic;                    --! High-active synchronous reset
    BTNU        : in    std_logic; 
    SWA         : in    std_logic_vector (5 downto 0);
    RGB         : out   std_logic_vector (2 downto 0);
    SPEAKER     : out   std_logic;
	LED_OUT     : out   std_logic;
    LED_M       : out   std_logic_vector(5 downto 0);
    MORSE_PIN   : in    std_logic;
    RGB2        : out   std_logic_vector (2 downto 0)
  );
    
end top;

architecture Behavioral of top is

  -- clock enable - sync signal with specific beat (one dit time unit)
  signal sig_ce : std_logic;

  -- Internal clock enable
  signal sig_en : std_logic;

  signal sig_out : std_logic;

  signal sig_tim : std_logic_vector(21 downto 0);     -- timing to be transmited
  signal sig_tim_in : std_logic_vector(21 downto 0);  -- recored timing

begin

  clk_en0 : entity work.clock_enable
    generic map (
      -- FOR SIMULATION - 1
      -- FOR IMPLEMENTATION, CALCULATE VALUE: 200 ms / (1/100 MHz)
      -- 1   @ 10 ns
      -- 20000000 @ 200 ms
      g_MAX => 20000000
    )
    port map (
      clk => CLK100MHZ,   -- internal clock
      rst => BTNU,        -- reset button
      ce  => sig_en
    );
  
  -- Trasmiter part

  -- converts input from switch array to timing 
  bin2morse_0 : entity work.bin2morse
    port map (
      bin => SWA,         -- binary input using switch array
      tim => sig_tim      -- output timing (22bit vector)
    );

  morseout_0 : entity work.morseout
    port map (
      clke => sig_en,  -- dit interval clock
      rst => BTNU,     -- central reset button
      start => BTNR,   -- start buuton
      tim => sig_tim,
      proc => RGB,     -- state RGB led
      outp => sig_out  -- output signal
    );
    
    -------------------------------------
    -- Reciver part

    morse2bin_0 : entity work.morse2bin
    port map (
      bin => LED_M,         -- output led array (binary representation of decoded character)
      tim => sig_tim_in     -- recorded timing
    );
    
    morsein_0 : entity work.morsein
    port map (
      clke => sig_en,
      rst => BTNU,        -- central reset button
      tim => sig_tim_in,  -- recorded timing
      proc => RGB2,       -- state RGB led
      inp => MORSE_PIN    -- pin connected to morse signal (Arduino)
    );

    -- connect output pin to both speaker (on expansion pin array) and internal LED
    SPEAKER <= sig_out;
    LED_OUT <= sig_out;

end Behavioral;
