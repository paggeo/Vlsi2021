library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity right_left_shift_reg_tb is
end entity;
--2,250ns

architecture bench of right_left_shift_reg_tb is

  component right_left_shift_reg is
    port(	
        clk,rst,en,pl: in std_logic;
        new_bit :in std_logic;
        right_or_left : in std_logic;
        din: in std_logic_vector(3 downto 0);
        output_bit: out std_logic
        );
  end component;
    signal input_clk : std_logic ;
    signal input_rst : std_logic := '0'  ;
    signal input_en : std_logic := '0'  ;
    signal input_pl : std_logic := '0'  ;
    signal input_new_bit : std_logic := '0'  ;
    signal input_right_or_left : std_logic := '0'  ;
    signal input_din : std_logic_vector(3 downto 0) := (others => '0');
    signal output_output_bit  : std_logic;
    


  constant TIME_DELAY : time := 80 ns;
  constant CLOCK_PERIOD : time := 10 ns;
  
begin

    module:right_left_shift_reg

    port map (
        clk =>input_clk,
        rst=>input_rst,
        en=>input_en,
        pl=>input_pl,
        new_bit =>input_new_bit,
        right_or_left =>input_right_or_left,
        din =>input_din,
        output_bit =>output_output_bit
    );

    

    stimulus : process
    begin
      input_rst <= '1';
      input_new_bit <= '0';
      input_en <= '0';
      input_pl <= '0';
      input_right_or_left <= '0';
      input_din <= (others => '0');
      wait for CLOCK_PERIOD;

      for i  in std_logic range '0' to '1' loop -- for shift_left=0 shift_right=1
        input_right_or_left <= i;
        input_en <= '1';
        
        input_new_bit <= '0';
        for n in 0 to 15 loop 
          input_pl <= '1';
          input_din <= std_logic_vector(to_unsigned(n, 4));
          wait for CLOCK_PERIOD; 
          input_pl <= '0';
          wait for TIME_DELAY;
        end loop;

        input_new_bit <= '1';
      
        for n in 0 to 15 loop 
          input_pl <= '1';
          input_din <= std_logic_vector(to_unsigned(n, 4));
          wait for CLOCK_PERIOD; 
          input_pl <= '0';
          wait for TIME_DELAY; 
        end loop;
      end loop;


     -- for i  in std_logic range '0' to '1' loop -- input_rst loop
       -- for j in std_logic range '0' to '1' loop -- input_new_bit loop
         --     for k in std_logic range '0' to '1' loop -- input_en loop
           --       for l in std_logic range '0' to '1' loop -- input_pl loop
             --         for m in std_logic range '0' to '1' loop -- input_right_or_left loop
               ---          for n in 0 to 15 loop -- input_din loop
                  --            input_rst <= i;
                    --          input_new_bit <= j;
                      --        input_en <= k;
                        --      input_pl <= l;
                          --    input_right_or_left <= m;
                            --  input_din <= std_logic_vector(to_unsigned(n, 4));
                              --wait for TIME_DELAY;  
      --                   end loop;
        --              end loop;
          --        end loop;   
           --   end loop;
        --  end loop;
      --end loop; 
        input_rst <= '0';
        input_new_bit <= '0';
        input_en <= '0';
        input_pl <= '0';
        input_right_or_left <= '0';
        input_din <= (others => '0');
        wait;
      end process;

    generate_clock : process
    begin
      input_clk <= '0';
      wait for CLOCK_PERIOD/2;
      input_clk <= '1';
      wait for CLOCK_PERIOD/2;
    end process;



    end architecture;