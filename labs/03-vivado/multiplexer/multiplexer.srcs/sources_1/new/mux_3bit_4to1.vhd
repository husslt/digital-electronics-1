----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/22/2023 10:22:33 AM
-- Design Name: 
-- Module Name: mux_3bit_4to1 - Behavioral
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

entity mux_3bit_4to1 is
  port (
    sel         : in    std_logic_vector(3 downto 0); --! Input select
    b           : out   std_logic                    --! Output is `1` if B>A
  );
end mux_3bit_4to1;

architecture Behavioral of mux_3bit_4to1 is

begin


end Behavioral;
