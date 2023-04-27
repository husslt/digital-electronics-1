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

entity tb_morsein is
--  Port ( );
end tb_morsein;

architecture Behavioral of tb_morsein is
constant c_CLK_100MHZ_PERIOD : time := 10 ns;
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

    sig_rst <= '0'; wait for 1065 ns;
    sig_rst <= '1'; wait for 20 ns; 
    -- Reset activated

    sig_rst <= '0';
    -- Reset deactivated
    wait;

  end process p_reset_gen;
  
  p_inp_gen : process is
  begin

    sig_inp <= '0'; wait for 10 ns;
    sig_inp <= '1'; wait for 30 ns;
    sig_inp <= '0'; wait for 10 ns;
    sig_inp <= '1'; wait for 10 ns;
    sig_inp <= '0'; wait for 10 ns;
    sig_inp <= '1'; wait for 30 ns;
    sig_inp <= '0'; wait for 40 ns;

    sig_inp <= '0'; wait for 10 ns;
    sig_inp <= '1'; wait for 30 ns;
    sig_inp <= '0'; wait for 10 ns;
    sig_inp <= '1'; wait for 10 ns;
    sig_inp <= '0'; wait for 10 ns;
    sig_inp <= '1'; wait for 30 ns;
    sig_inp <= '0'; wait for 30 ns;
    
    
    
    sig_inp <= '0';
    wait;

  end process p_inp_gen;



end Behavioral;
