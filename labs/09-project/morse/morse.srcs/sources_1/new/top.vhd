----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.04.2023 10:18:23
-- Design Name: 
-- Module Name: morsetop - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
  port (
    CLK100MHZ   : in    std_logic;                    --! Main clock
    BTNR        : in    std_logic;                    --! High-active synchronous reset
    BTNU        : in    std_logic; --! Traffic light for "south" direction
    SWA         : in    std_logic_vector (5 downto 0);
    RGB         : out   std_logic_vector (2 downto 0);
    SPEAKER     : out   std_logic;
    LED_M       : out   std_logic_vector(5 downto 0);
    MORSE_PIN   : in    std_logic;
    RGB2        : out   std_logic_vector (2 downto 0)
  );
    
end top;

architecture Behavioral of top is

  -- Define the signal that uses different states
  signal sig_ce : std_logic;

  -- Internal clock enable
  signal sig_en : std_logic;

  -- Local delay counter
  signal sig_tim : std_logic_vector(21 downto 0);
  
  
  signal sig_tim_in : std_logic_vector(21 downto 0);


begin


  clk_en0 : entity work.clock_enable
    generic map (
      -- FOR SIMULATION, KEEP THIS VALUE TO 1
      -- FOR IMPLEMENTATION, CALCULATE VALUE: 200 ms / (1/100 MHz)
      -- 1   @ 10 ns
      -- 20000000 @ 200 ms
      g_MAX => 20000000
    )
    port map (
      clk => CLK100MHZ,
      rst => BTNU,
      ce  => sig_en
    );
    
   bin2morse_0 : entity work.bin2morse
    port map (
      bin => SWA,
      tim => sig_tim
    );

  morseout_0 : entity work.morseout
    port map (
      clke => sig_en,
      rst => BTNU,
      start => BTNR,
      tim => sig_tim,
      proc => RGB,
      outp => SPEAKER
    );
    
    ---------
    
    morse2bin_0 : entity work.morse2bin
    port map (
      bin => LED_M,
      tim => sig_tim_in
    );
    
    morsein_0 : entity work.morsein
    port map (
      clke => sig_en,
      rst => BTNU,
      tim => sig_tim_in,
      proc => RGB2,
      inp => MORSE_PIN
    );

end Behavioral;
