library ieee;
  use ieee.std_logic_1164.all;

-- Entity declaration for morse output generator
-- Inputs: valid morse character (A-Z, 0-9) in 6bit binary number representation, where A is 0, Z is 25, 0 is 32 and 9 is 41
-- Outputs: sequence of morse bits/timing
-- 
-- 
-- 
-- 
-- 
-- 

entity bin2morse is
  port (
    bin   : in    std_logic_vector(5 downto 0); --! Binary representation of one binary symbol
    seg   : out   std_logic_vector(21 downto 0)  --! timing of morse character
  );
end entity bin2morse;

------------------------------------------------------------
-- Architecture body for binary to morse decoder
------------------------------------------------------------

architecture behavioral of bin2morse is

begin
  p_morse_decoder : process (bin) is

  begin
      case bin is
        when "000000" =>
          seg <= "1011100000000000000000"; -- A
        when "000001" =>
          seg <= "1110101010000000000000"; -- B
        when "000010" =>
          seg <= "1110101110100000000000"; -- C
        when "000011" =>
          seg <= "1110101000000000000000"; -- D
        when "000100" =>
          seg <= "1000000000000000000000"; -- E
        when "000101" =>
          seg <= "1010111010000000000000"; -- F
        when "000110" =>
          seg <= "1110111010000000000000"; -- G
        when "000111" =>
          seg <= "1010101000000000000000"; -- H
        when "001000" =>
          seg <= "1010000000000000000000"; -- I
        when "001001" =>
          seg <= "1011101110111000000000"; -- J
        when "001010" =>
          seg <= "1110101110000000000000"; -- K
        when "001100" =>
          seg <= "1110111000000000000000"; -- M
        when "001101" =>
          seg <= "1110100000000000000000"; -- N
        when "001111" =>
          seg <= "1011101110100000000000"; -- P
        when "010000" =>
          seg <= "1110111010111000000000"; -- Q
        when "010001" =>
          seg <= "1011101000000000000000"; -- R
        when "010010" =>
          seg <= "1010100000000000000000"; -- S
        when "010011" =>
          seg <= "1110000000000000000000"; -- T
        when "010100" =>
          seg <= "1010111000000000000000"; -- U
        when "010101" =>
          seg <= "1010101110000000000000"; -- V
        when "010110" =>
          seg <= "1011101110000000000000"; -- W
        when "010111" =>
          seg <= "1110101011100000000000"; -- X
        when "011000" =>
          seg <= "1110101110111000000000"; -- Y
        when "011001" =>
          seg <= "1110111010100000000000"; -- Z
        when "100000" =>
          seg <= "1110111011101110111000"; -- 0
        when "100001" =>
          seg <= "1011101110111011100000"; -- 1
        when "100010" =>
          seg <= "1010111011101110000000"; -- 2
        when "100011" =>
          seg <= "1010101110111000000000"; -- 3
        when "100100" =>
          seg <= "1010101011100000000000"; -- 4
        when "100101" =>
          seg <= "1010101010000000000000"; -- 5
        when "100110" =>
          seg <= "1110101010100000000000"; -- 6
        when "100111" =>
          seg <= "1110111010101000000000"; -- 7
        when "101000" =>
          seg <= "1110111011101010000000"; -- 8
        when "101001" =>
          seg <= "1110111011101110100000"; -- 9
        when others =>
          seg <= "1110100000000000000000"; -- N
      end case;
  end process p_morse_decoder;

end architecture behavioral;