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
    selct_i         : in    std_logic_vector(2 - 1 downto 0); 
    a_i		        : out   std_logic_vector(3 - 1 downto 0);                	
	b_i		        : out   std_logic_vector(3 - 1 downto 0);  
	c_i		        : out   std_logic_vector(3 - 1 downto 0);  
	d_i		        : out   std_logic_vector(3 - 1 downto 0);  
	s_o		        : out   std_logic_vector(3 - 1 downto 0);  
  );
end mux_3bit_4to1;

architecture Behavioral of mux_3bit_4to1 is

begin
    s_o <= a_i when (selct_i = "00") else
           b_i when (selct_i = "01") else
           c_i when (selct_i = "10") else
           d_i when (selct_i = "11");    

end Behavioral;
