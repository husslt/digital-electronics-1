----------------------------------------------------------
--
--! @title Driver for 4-digit 7-segment display
--! @author Tomas Fryza
--! Dept. of Radio Electronics, Brno Univ. of Technology, Czechia
--!
--! @copyright (c) 2020 Tomas Fryza
--! This work is licensed under the terms of the MIT license
--
-- Hardware: Nexys A7-50T, xc7a50ticsg324-1L
-- Software: TerosHDL, Vivado 2020.2, EDA Playground
--
----------------------------------------------------------

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

----------------------------------------------------------
-- Entity declaration for display driver
--
--             +-------------------+
--        -----|> clk              |
--        -----| rst            dp |-----
--             |          seg(6:0) |--/--
--        --/--| data0(3:0)        |  7
--        --/--| data1(3:0)        |
--        --/--| data2(3:0)        |
--        --/--| data3(3:0)        |
--          4  |           dig(3:0)|--/--
--        --/--| dp_vect(3:0)      |  4
--          4  +-------------------+
--
-- Inputs:
--  tim(22:0):          -- Morse timing with added zeros at the end
--  clke:          -- Main clock from clock enable
--  rst:          -- Asynchronous reset
--  start:        -- signal to start decoding
--
-- Outputs:
--   outp:          -- morse timing without zeros at the end
--   proc:     -- signal showing whether entity is processing or not
--   
--
----------------------------------------------------------

entity morseout is
  port (
    tim     : in    std_logic_vector(21 downto 0);
    clke    : in    std_logic;
    rst     : in    std_logic;
    start   : in    std_logic;
    outp    : out   std_logic;
    proc    : out   std_logic_vector(2 downto 0)
  );
end entity morseout;

----------------------------------------------------------
-- Architecture declaration for display driver
----------------------------------------------------------

architecture behavioral of morseout is

  -- Internal clock enable
  signal sig_state : natural;

  signal sig_cnt : natural;
  signal sig_zeros_cnt : natural;

begin

  --------------------------------------------------------
  -- p_traffic_fsm:
  -- A sequential process with synchronous reset and
  -- clock_enable entirely controls the s_state signal by
  -- CASE statement.
  --------------------------------------------------------
  p_morse_out : process (clke) is
  begin
    if rst = '0' then
        if (rising_edge(clke)) then
            case sig_state is
              when 0 =>
                outp <= '0';
                proc <= "010";
                sig_cnt <= 21;
                sig_zeros_cnt <= 0;
                if start = '1' then
                    sig_state <= 1;
                end if;
                
              when 1 =>
                outp <= tim(sig_cnt);
                proc <= "110";
                sig_cnt <= sig_cnt - 1;
              
                if tim(sig_cnt) = '0' then
                    sig_zeros_cnt <= sig_zeros_cnt + 1;
                else
                    sig_zeros_cnt <= 0;
                end if;
                
                if sig_zeros_cnt >= 3 or sig_cnt < 0 then
                    sig_state <= 0;
                end if;
    
              when others =>
                -- It is a good programming practice to use the
                -- OTHERS clause, even if all CASE choices have
                -- been made.
                sig_state <= 0;
            end case;
    
        end if; -- Rising edge
    else
        outp <= '0';
        sig_state <= 0;
        proc <= "001";
    end if;
  end process p_morse_out;

end architecture behavioral;