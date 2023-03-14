----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/08/2023 10:10:51 AM
-- Design Name: 
-- Module Name: jk_ff_rst - Behavioral
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

entity jk_ff_rst is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           j : in STD_LOGIC;
           k : in STD_LOGIC;
           q : out STD_LOGIC;
           q_bar : out STD_LOGIC);
end jk_ff_rst;

architecture behavioral of jk_ff_rst is
    -- It must use this local signal instead of output ports
    -- because "out" ports cannot be read within the architecture
    signal sig_q : std_logic;
begin
    --------------------------------------------------------
    -- p_jk_ff_rst:
    -- JK type flip-flop with a high-active synchro reset and
    -- rising-edge clk.
    -- sig_q = j./sig_q + /k.sig_q
    -- sig_q =  sig_q 	if j = 0 AND k = 0 (no change)
    -- sig_q =  0	 	if j = 0 AND k = 1 (reset)
    -- sig_q =  1 		if j = 1 AND k = 0 (set)
    -- sig_q = /sig_q 	if j = 1 AND k = 1 (toggle)
    --------------------------------------------------------
    p_jk_ff_rst : process (clk)
    begin
        if rising_edge(clk) then
            if (j = '0' and k = '0') then
               	sig_q <= sig_q;
            elsif (j = '0' and k = '1') then 
               	sig_q <= '0';
            elsif (j = '1' and k = '0') then
               	sig_q <= '1';
            else 
               	sig_q <= not sig_q;
            end if;
    	end if;
    end process p_jk_ff_rst;

    -- Output ports are permanently connected to local signal
    q     <= sig_q;
    q_bar <= not sig_q;
end architecture behavioral;