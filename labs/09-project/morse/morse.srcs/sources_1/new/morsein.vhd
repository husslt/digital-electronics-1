----------------------------------------------------------
-- when morse code appear on input pin, record it and save to 'tim'
----------------------------------------------------------

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

----------------------------------------------------------
--
-- Inputs:
--  clke:          -- Main clock from clock enable
--  inp:           -- pin with morse code 
--  rst            -- Async reset
--
-- Outputs:
--   tim(22:0):     -- Morse timing with added zeros at the end
--   proc:          -- signal showing whether entity is processing or not (RGB LED)
--   
--
----------------------------------------------------------

entity morsein is
  port (
    tim     : out   std_logic_vector(21 downto 0);
    clke    : in    std_logic;
    rst     : in    std_logic;
    inp     : in    std_logic;
    proc    : out   std_logic_vector(2 downto 0)
  );
end entity morsein;

----------------------------------------------------------
-- Architecture declaration 
----------------------------------------------------------

architecture behavioral of morsein is

  -- Internal clock enable
  signal sig_state : natural;

  signal sig_cnt : natural;
  signal sig_zeros_cnt : natural;

begin

  p_morse_in : process (clke) is
  begin
    if rst = '0' then
        if (rising_edge(clke)) then
            case sig_state is
              when 0 =>
                -- start reset all, wait for input

                tim <= "0000000000000000000000";
                proc <= "111";
                sig_cnt <= 20;
                sig_zeros_cnt <= 0;

                if inp = '1' then -- recording start -> save current value and start recording 
                    tim(21) <= '1';
                    sig_state <= 1;
                end if;
                
              when 1 =>
                -- record timing, move to waiting state when 3 noninterupted zeros (character break) or max tim length exceeded 

                sig_cnt <= sig_cnt - 1;
                
                if inp = '0' then
                    sig_zeros_cnt <= sig_zeros_cnt + 1;
                else
                    sig_zeros_cnt <= 0;
                end if;
                
                if sig_zeros_cnt >= 3 or sig_cnt <= 0 then
                    sig_state <= 2;
                end if;
                
                
                tim(sig_cnt) <= inp;
                proc <= "110";
                
              when 2 =>
                -- turn LED off and wait for new recording start
                -- let decoded character in 'tim' until new recording
                -- TODO: join when 0 and when 2
                proc <= "000";
                if inp = '1' then
                    tim <= "1000000000000000000000";
                    sig_cnt <= 20;
                    sig_zeros_cnt <= 0;
                    sig_state <= 1;
                end if;
                
              when others =>
                -- It is a good programming practice to use the
                -- OTHERS clause, even if all CASE choices have
                -- been made.
                sig_state <= 0;
            end case;
    
        end if; -- Rising edge
    else
        -- reset state
        tim <= "0000000000000000000000";
        sig_state <= 0;
        proc <= "001";
    end if;
  end process p_morse_in;

end architecture behavioral;