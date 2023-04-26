library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all; -- Definition of "to_unsigned"

------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------

entity tb_bin2morse is
-- Entity of testbench is always empty
end entity tb_bin2morse;

------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------

architecture testbench of tb_bin2morse is

  -- Testbench local signals
  signal sig_bin : std_logic_vector(5 downto 0);
  signal sig_tim : std_logic_vector(21 downto 0);

begin

  -- Connecting testbench signals with decoder entity
  -- (Unit Under Test)
  uut_bin2morse : entity work.bin2morse
    port map (
      bin   => sig_bin,
      tim   => sig_tim
    );

  --------------------------------------------------------
  -- Data generation process
  --------------------------------------------------------
  p_stimulus : process is
  begin

    report "Stimulus process started";

    
    -- Loop for all bin values
    for ii in 0 to 63 loop

      -- Convert ii decimal value to 6-bit wide binary
      sig_bin <= std_logic_vector(to_unsigned(ii, 6));
      wait for 10 ns;

    end loop;

    report "Stimulus process finished";
    wait;

  end process p_stimulus;

end architecture testbench;