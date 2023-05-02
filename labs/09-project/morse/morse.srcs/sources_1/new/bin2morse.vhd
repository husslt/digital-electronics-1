----------------------------------------------------------
-- convert character to its morse code timing (timing for 'N' when unknown character)
----------------------------------------------------------

library ieee;
  use ieee.std_logic_1164.all;

-- Entity declaration for morse output generator
-- Inputs: valid morse character (A-Z, 0-9) in 6bit binary number representation, where A is 0, Z is 25, 0 is 32 and 9 is 41
-- Outputs: sequence of morse bits/timing
-- 

entity bin2morse is
  port (
    bin   : in    std_logic_vector(5 downto 0); --! Binary representation of one binary symbol
    tim   : out   std_logic_vector(21 downto 0)  --! timing of morse character
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
        when "000001" =>
          tim <= "1011100000000000000000"; -- A
        when "000010" =>
          tim <= "1110101010000000000000"; -- B
        when "000011" =>
          tim <= "1110101110100000000000"; -- C
        when "000100" =>
          tim <= "1110101000000000000000"; -- D
        when "000101" =>
          tim <= "1000000000000000000000"; -- E
        when "000110" =>
          tim <= "1010111010000000000000"; -- F
        when "000111" =>
          tim <= "1110111010000000000000"; -- G
        when "001000" =>
          tim <= "1010101000000000000000"; -- H
        when "001001" =>
          tim <= "1010000000000000000000"; -- I
        when "001010" =>
          tim <= "1011101110111000000000"; -- J
        when "001011" =>
          tim <= "1110101110000000000000"; -- K
        when "001100" =>
          tim <= "1011101010000000000000"; -- L
        when "001101" =>
          tim <= "1110111000000000000000"; -- M
        when "001110" =>
          tim <= "1110100000000000000000"; -- N
        when "001111" =>
          tim <= "1110111011100000000000"; -- O
        when "010000" =>
          tim <= "1011101110100000000000"; -- P
        when "010001" =>
          tim <= "1110111010111000000000"; -- Q
        when "010010" =>
          tim <= "1011101000000000000000"; -- R
        when "010011" =>
          tim <= "1010100000000000000000"; -- S
        when "010100" =>
          tim <= "1110000000000000000000"; -- T
        when "010101" =>
          tim <= "1010111000000000000000"; -- U
        when "010110" =>
          tim <= "1010101110000000000000"; -- V
        when "010111" =>
          tim <= "1011101110000000000000"; -- W
        when "011000" =>
          tim <= "1110101011100000000000"; -- X
        when "011001" =>
          tim <= "1110101110111000000000"; -- Y
        when "011010" =>
          tim <= "1110111010100000000000"; -- Z
        when "100000" =>
          tim <= "1110111011101110111000"; -- 0
        when "100001" =>
          tim <= "1011101110111011100000"; -- 1
        when "100010" =>
          tim <= "1010111011101110000000"; -- 2
        when "100011" =>
          tim <= "1010101110111000000000"; -- 3
        when "100100" =>
          tim <= "1010101011100000000000"; -- 4
        when "100101" =>
          tim <= "1010101010000000000000"; -- 5
        when "100110" =>
          tim <= "1110101010100000000000"; -- 6
        when "100111" =>
          tim <= "1110111010101000000000"; -- 7
        when "101000" =>
          tim <= "1110111011101010000000"; -- 8
        when "101001" =>
          tim <= "1110111011101110100000"; -- 9
        when others =>
          tim <= "1110100000000000000000"; -- N
      end case;
  end process p_morse_decoder;

end architecture behavioral;