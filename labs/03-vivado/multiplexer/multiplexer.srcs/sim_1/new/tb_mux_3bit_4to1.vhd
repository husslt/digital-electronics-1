----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/22/2023 10:24:52 AM
-- Design Name: 
-- Module Name: tb_mux_3bit_4to1 - Behavioral
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

entity tb_mux_3bit_4to1 is
    
end tb_mux_3bit_4to1;

architecture Behavioral of tb_mux_3bit_4to1 is
    signal s_selct  :   std_logic_vector(2 - 1 downto 0);
    signal s_a    :   std_logic_vector(3 - 1 downto 0);
    signal s_b    :   std_logic_vector(3 - 1 downto 0);
    signal s_c    :   std_logic_vector(3 - 1 downto 0);
    signal s_d    :   std_logic_vector(3 - 1 downto 0);
    signal s_s    :   std_logic_vector(3 - 1 downto 0);
    
begin
    -- Connecting testbench signals with comparator_4bit
    -- entity (Unit Under Test)
    uut_mux_3bit_4to1 : entity work.mux_3bit_4to1
    	port map(
            selct_i		  => s_selct,
            a_i           => s_a,
            b_i           => s_b,
            c_i           => s_c,
            d_i           => s_d,
            s_o           => s_s
        );

    --------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------
    p_stimulus : process
    begin
		s_d <= "111"; -- dec 7
        s_c <= "101"; -- dec 5
        s_b <= "011"; -- dec 3
        s_a <= "001"; -- dec 1
		s_selct <= "00"; -- select signal a_i/s_a
        wait for 100 ns;
        s_selct <= "01"; -- select signal b_i/s_b
        wait for 100 ns;
        s_selct <= "10"; -- select signal c_i/s_c
        wait for 100 ns;
        s_selct <= "11"; -- select signal d_i/s_d
        wait for 100 ns;
        -- expected output at s_o port: 1, 3, 5, 7
        -- Report a note at the end of stimulus process
        report "Stimulus process finished";
        wait; -- Data generation process is suspended forever
    end process p_stimulus;


end Behavioral;