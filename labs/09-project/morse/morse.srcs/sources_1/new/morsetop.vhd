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

entity morsetop is
  port (
    clk   : in    std_logic;                    --! Main clock
    rst   : in    std_logic;                    --! High-active synchronous reset
    south : out   std_logic_vector(2 downto 0); --! Traffic light for "south" direction
    west  : out   std_logic_vector(2 downto 0)  --! Traffic light for "west" direction
  );
end morsetop;

architecture Behavioral of morsetop is

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
      clk => clk,
      rst => rst,
      ce  => sig_en
    );

end Behavioral;
