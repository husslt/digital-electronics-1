library ieee;
  use ieee.std_logic_1164.all;

------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------

entity top is
  port (
    SW : in    std_logic;              
    CLK100MHZ   : in    std_logic; 
    BTNC   : IN   std_logic;
    CA : OUT std_logic;
    CB : OUT std_logic;
    CC : OUT std_logic;
    CD : OUT std_logic;
    CE : OUT std_logic;
    CF : OUT std_logic;
    CG : OUT std_logic;
    AN : OUT std_logic_vector(7 downto 0)
    
  );
end entity top;

----------------------------------------------------------
-- Architecture body for top level
----------------------------------------------------------

architecture behavioral of top is

  
  
  -- 4-bit counter @ 250 ms
  signal sig_en_250ms : std_logic;                    --! Clock enable signal for Counter0
  signal sig_cnt_4bit : std_logic_vector(3 downto 0); --! Counter0

  

begin

  --------------------------------------------------------
  -- Instance (copy) of clock_enable entity
  --------------------------------------------------------
  clk_en0 : entity work.clock_enable
      generic map(
          g_MAX => 25000000
      )
      port map(
          clk => CLK100MHZ,
          rst => BTNC,
          ce  => sig_en_250ms
      );

  --------------------------------------------------------
  -- Instance (copy) of cnt_up_down entity
  --------------------------------------------------------
  bin_cnt0 : entity work.cnt_up_down
     generic map(
          g_CNT_WIDTH => 4
      )
      port map(
        clk    => CLK100MHZ,
        rst    => BTNC,
        en     => sig_en_250ms,
        cnt_up => SW,
        cnt    => sig_cnt_4bit
      );

  --------------------------------------------------------
  -- Instance (copy) of hex_7seg entity
  --------------------------------------------------------
  hex2seg : entity work.hex_7seg
      port map(
          blank  => BTNC,
          hex    => sig_cnt_4bit,
          seg(6) => CA,
          seg(5) => CB,
          seg(4) => CC,
          seg(3) => CD,
          seg(2) => CE,
          seg(1) => CF,
          seg(0) => CG
      );

  --------------------------------------------------------
  -- Other settings
  --------------------------------------------------------
  -- Connect one common anode to 3.3V
  AN <= b"1111_1110";

end architecture behavioral;