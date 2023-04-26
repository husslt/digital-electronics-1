----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.04.2023 09:09:16
-- Design Name: 
-- Module Name: tb_morseout - Behavioral
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

entity tb_morseout is
--  Port ( );
end tb_morseout;

architecture Behavioral of tb_morseout is
constant c_CLK_100MHZ_PERIOD : time := 10 ns;
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
      tim => "1110101110111000000000",
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



end Behavioral;
