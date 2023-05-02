library ieee;
  use ieee.std_logic_1164.all;


entity tb_morse2bin is

end tb_morse2bin;

architecture testbench of tb_morse2bin is

  signal sig_tim : std_logic_vector(21 downto 0); -- Input in the form of morse encoded string
  signal sig_bin : std_logic_vector(5 downto 0); -- Output - 6bit number which corresponds to specific alfanumerical character

begin

  uut_morse2bin : entity work.morse2bin
    port map(
      bin => sig_bin,
      tim => sig_tim
    );

  p_tim_gen : process is -- Generating input - test entity for 4 different characters
  begin
    
    sig_tim <= "1011100000000000000000"; -- A
    wait for 10 ns;
    sig_tim <= "1110111010100000000000"; -- Z
    wait for 10 ns;
    sig_tim <= "1110111011101110111000"; -- 0
    wait for 10 ns;
    sig_tim <= "1110111011101110100000"; -- 9
    wait for 10 ns;
    
    wait;

  end process p_tim_gen;

end architecture testbench;
