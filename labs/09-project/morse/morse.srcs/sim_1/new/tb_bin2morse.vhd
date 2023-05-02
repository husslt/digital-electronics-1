library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all; -- Definition of "to_unsigned"


entity tb_bin2morse is
  
end entity tb_bin2morse;

architecture testbench of tb_bin2morse is

  signal sig_bin : std_logic_vector(5 downto 0); -- Input character in the form of 6bit binary number
  signal sig_tim : std_logic_vector(21 downto 0); -- Output signal in the form of 22bit wide vector

begin

  uut_bin2morse : entity work.bin2morse
    port map (
      bin   => sig_bin,
      tim   => sig_tim
    );

  p_bin_gen : process is
  begin
   
    -- Loop for all bin values
    for ii in 0 to 63 loop

      -- Convert ii decimal value to 6-bit wide binary
      sig_bin <= std_logic_vector(to_unsigned(ii, 6));
      wait for 10 ns;

    end loop;

    wait;

  end process p_bin_gen;

end architecture testbench;