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
    BTNC        : in    std_logic;                    --! High-active synchronous reset
    BTNU        : in    std_logic; --! Traffic light for "south" direction
    SWA         : in    std_logic_vector (5 downto 0);
    RGB         : out   std_logic_vector (2 downto 0);
    LED_OUT     : out   std_logic
  );
    
end top;

architecture Behavioral of top is

  -- Define the signal that uses different states
  signal sig_ce : std_logic;

  -- Internal clock enable
  signal sig_en : std_logic;

  -- Local delay counter
  signal sig_tim : std_logic_vector(21 downto 0);


begin


  clk_en0 : entity work.clock_enable
    generic map (
      -- FOR SIMULATION, KEEP THIS VALUE TO 1
      -- FOR IMPLEMENTATION, CALCULATE VALUE: 250 ms / (1/100 MHz)
      -- 1   @ 10 ns
      -- 25000000 @ 250 ms
      g_MAX => 25000000
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
      start => BTNC,
      tim => sig_tim,
      proc => RGB,
      outp => LED_OUT
    );

end Behavioral;
