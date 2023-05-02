----------------------------------------------------------
-- when start pressed play inputed timing 
----------------------------------------------------------

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

----------------------------------------------------------
-- Entity declaration for morse trasmiter
--
-- Inputs:
--  tim(22:0):    -- Morse timing with added zeros at the end
--  clke:         -- Main clock from clock enable (one dit)
--  rst:          -- Asynchronous reset
--  start:        -- signal to start decoding
--
-- Outputs:
--   outp:        -- morse timing without zeros at the end
--   proc:        -- signal showing whether entity is processing or not (RGB LED)
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
-- Architecture declaration 
----------------------------------------------------------

architecture behavioral of morseout is

  -- Internal clock enable
  signal sig_state : natural;

  signal sig_cnt : natural;        -- current possition in timing vector
  signal sig_zeros_cnt : natural;  -- number of noninterrupted zeros (silence)

begin
  p_morse_out : process (clke) is
  begin
    if rst = '0' then
        if (rising_edge(clke)) then
            case sig_state is
              when 0 =>
                -- wait for start - do nothing and wait

                outp <= '0';
                proc <= "000"; -- black
                sig_cnt <= 21; -- pos set to MSB
                sig_zeros_cnt <= 0;
                if start = '1' then
                    sig_state <= 1;
                end if;
                
              when 1 =>
                -- start pressed 
                -- play 'tim' when 3 zeros (character break) move to when 0

                outp <= tim(sig_cnt);     -- play sequence in stored in 'tim'
                proc <= "110";            -- yellow
                sig_cnt <= sig_cnt - 1;   -- move by one bit in sequence
              
                -- noninterrupted zeros
                if tim(sig_cnt) = '0' then
                    sig_zeros_cnt <= sig_zeros_cnt + 1;
                else
                    sig_zeros_cnt <= 0;
                end if;
                
                -- break to state 1 if 3 noninterrupted zeros (character break) or end of 'timm'
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
        -- reset state - blue color
        outp <= '0';
        sig_state <= 0;
        proc <= "001";
    end if;
  end process p_morse_out;

end architecture behavioral;