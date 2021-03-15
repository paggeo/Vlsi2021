library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;


entity counter_up_down_3bit_tb is 
end entity;

architecture bench of counter_up_down_3bit_tb is


    component counter_up_down_3bit is
        port(
            clk, resetn , count_en : in std_logic;
            add_or_sub : in std_logic;
            sum : out std_logic_vector(2 downto 0);
            cout : out std_logic
        );
    end component;

    signal input_clk : std_logic ;
    signal input_resetn : std_logic := '0'  ;
    signal input_count_en : std_logic := '0'  ;
    signal input_add_or_sub : std_logic := '0'  ;
    signal output_sum : std_logic_vector(2 downto 0) ;
    signal output_cout  : std_logic;

    constant TIME_DELAY : time := 10 ns;
    constant CLOCK_PERIOD : time := 10 ns;
    constant CLOCK_PERIOD_2 : time := 100 ns;

  begin 

        module : counter_up_down_3bit

        port map (
                clk =>input_clk,
                resetn =>input_resetn,
                count_en=>input_count_en,
                add_or_sub=>input_add_or_sub,
                sum=>output_sum,
                cout=>output_cout
        );

        stimulus : process
         begin
        --input_resetn <= '0';
        --input_count_en <= '0';
        input_resetn <= '1';
        input_count_en <= '1';
        wait for CLOCK_PERIOD;

        input_add_or_sub <= '0';
        wait for CLOCK_PERIOD_2;
         input_add_or_sub <= '1';
        wait for CLOCK_PERIOD_2;


        input_resetn <= '0';
        input_count_en <= '0';
        input_add_or_sub <= '0';
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
