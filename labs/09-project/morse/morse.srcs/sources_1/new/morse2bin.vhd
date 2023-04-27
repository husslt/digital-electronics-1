library ieee;
  use ieee.std_logic_1164.all;

-- Entity declaration for morse output generator
-- Inputs: valid morse character (A-Z, 0-9) in 6bit binary number representation, where A is 0, Z is 25, 0 is 32 and 9 is 41
-- Outputs: sequence of morse bits/timing
-- 

entity morse2bin is
  port (
    bin   : out   std_logic_vector(5 downto 0); --! Binary representation of one binary symbol
    tim   : in    std_logic_vector(21 downto 0)  --! timing of morse character
  );
end entity morse2bin;

------------------------------------------------------------
-- Architecture body for binary to morse decoder
------------------------------------------------------------

architecture behavioral of morse2bin is

begin
  p_morse_encoder : process (tim) is

  begin
      case tim is
        when "1011100000000000000000" =>
            bin <= "000001"; -- A
        when "1110101010000000000000" =>
            bin <= "000010"; -- B
        when "1110101110100000000000" =>
            bin <= "000011"; -- C
        when "1110101000000000000000" =>
            bin <= "000100"; -- D
        when "1000000000000000000000" =>
            bin <= "000101"; -- E
        when "1010111010000000000000" =>
            bin <= "000110"; -- F
        when "1110111010000000000000" =>
            bin <= "000111"; -- G
        when "1010101000000000000000" =>
            bin <= "001000"; -- H
        when "1010000000000000000000" =>
            bin <= "001001"; -- I
        when "1011101110111000000000" =>
            bin <= "001010"; -- J
        when "1110101110000000000000" =>
            bin <= "001011"; -- K
        when "1011101010000000000000" =>
            bin <= "001100"; -- L
        when "1110111000000000000000" =>
            bin <= "001101"; -- M
        when "1110100000000000000000" =>
            bin <= "001110"; -- N
        when "1110111011100000000000" =>
            bin <= "001111"; -- O
        when "1011101110100000000000" =>
            bin <= "010000"; -- P
        when "1110111010111000000000" =>
            bin <= "010001"; -- Q
        when "1011101000000000000000" =>
            bin <= "010010"; -- R
        when "1010100000000000000000" =>
            bin <= "010011"; -- S
        when "1110000000000000000000" =>
            bin <= "010100"; -- T
        when "1010111000000000000000" =>
            bin <= "010101"; -- U
        when "1010101110000000000000" =>
            bin <= "010110"; -- V
        when "1011101110000000000000" =>
            bin <= "010111"; -- W
        when "1110101011100000000000" =>
            bin <= "011000"; -- X
        when "1110101110111000000000" =>
            bin <= "011001"; -- Y
        when "1110111010100000000000" =>
            bin <= "011010"; -- Z
        when "1110111011101110111000" =>
            bin <= "100000"; -- 0
        when "1011101110111011100000" =>
            bin <= "100001"; -- 1
        when "1010111011101110000000" =>
            bin <= "100010"; -- 2
        when "1010101110111000000000" =>
            bin <= "100011"; -- 3
        when "1010101011100000000000" =>
            bin <= "100100"; -- 4
        when "1010101010000000000000" =>
            bin <= "100101"; -- 5
        when "1110101010100000000000" =>
            bin <= "100110"; -- 6
        when "1110111010101000000000" =>
            bin <= "100111"; -- 7
        when "1110111011101010000000" =>
            bin <= "101000"; -- 8
        when "1110111011101110100000" =>
            bin <= "101001"; -- 9
        when others =>
            bin <= "111111"; --nic
      end case;
  end process p_morse_encoder;

end architecture behavioral;






