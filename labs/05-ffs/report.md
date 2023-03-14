# Lab 5: Tomáš Husslik

### D & T Flip-flops

1. Screenshot with simulated time waveforms. Try to simulate both D- and T-type flip-flops in a single testbench with a maximum duration of 200 ns, including reset. Always display all inputs and outputs (display the inputs at the top of the image, the outputs below them) at the appropriate time scale!

   ![Simulated waveforms](images/d_t_flip_flops.png)

### JK Flip-flop

1. Listing of VHDL architecture for JK-type flip-flop. Always use syntax highlighting, meaningful comments, and follow VHDL guidelines:

```vhdl
architecture behavioral of jk_ff_rst is
    -- It must use this local signal instead of output ports
    -- because "out" ports cannot be read within the architecture
    signal sig_q : std_logic;
begin
    --------------------------------------------------------
    -- p_jk_ff_rst:
    -- JK type flip-flop with a high-active synchro reset and
    -- rising-edge clk.
    -- sig_q = j./sig_q + /k.sig_q
    -- sig_q =  sig_q 	if j = 0 AND k = 0 (no change)
    -- sig_q =  0	 	if j = 0 AND k = 1 (reset)
    -- sig_q =  1 		if j = 1 AND k = 0 (set)
    -- sig_q = /sig_q 	if j = 1 AND k = 1 (toggle)
    --------------------------------------------------------
    p_jk_ff_rst : process (clk)
    begin
        if rising_edge(clk) then

       	    if (rst = '1') then
            	sig_q <= '0';
            else
            	if (j = '0' and k = '0') then
                	sig_q <= sig_q;
            	elsif (j = '0' and k = '1') then 
                	sig_q <= '0';
                elsif (j = '1' and k = '0') then
                	sig_q <= '1';
                else 
                	sig_q <= not sig_q;
            	end if;
            end if;
    	end if;
    end process p_jk_ff_rst;

    -- Output ports are permanently connected to local signal
    q     <= sig_q;
    q_bar <= not sig_q;
end architecture behavioral;
```

### Shift register

1. Image of `top` level schematic of the 4-bit shift register. Use four D-type flip-flops and connect them properly. The image can be drawn on a computer or by hand. Always name all inputs, outputs, components and internal signals!

   ![your figure]()
