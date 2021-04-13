library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity filter_pipeline_tb is 
    end entity;

architecture bench of filter_pipeline_tb is 

    component filter_pipeline is 
        port(
            clk : in std_logic;
        rst : in std_logic;
        valid_in : in std_logic;
        x_in : in std_logic_vector(7 downto 0);
        valid_out : out std_logic;
        y_out : out std_logic_vector(18 downto 0)
        );
    end component;
    signal clk,rst,valid_in,valid_out: std_logic;
    
    signal x_in : std_logic_vector(7 downto 0);
    signal y_out : std_logic_vector(18 downto 0); 

    constant TIME_DELAY : time := 70 ns;
    constant CLOCK_PERIOD : time := 10 ns;

    begin 
        filter_moduler: filter_pipeline
            port map (clk,rst,valid_in,x_in,valid_out, y_out);

        simulation : process
            begin
               wait for 5 ns;
                     rst <= '1';
                     valid_in<='1';
                     x_in <= std_logic_vector(to_unsigned(7,8));
                     wait for CLOCK_PERIOD;

                     rst <= '0';
                     valid_in<='1';
                     x_in <= std_logic_vector(to_unsigned(1,8));
                     wait for CLOCK_PERIOD;

                     x_in <= std_logic_vector(to_unsigned(2,8));
                     wait for CLOCK_PERIOD;

                     x_in <= std_logic_vector(to_unsigned(3,8));
                     wait for CLOCK_PERIOD;

                     x_in <= std_logic_vector(to_unsigned(4,8));
                     wait for CLOCK_PERIOD;
                     
                     rst <= '1';
                     valid_in<='1';
                     x_in <= std_logic_vector(to_unsigned(7,8));
                     wait for CLOCK_PERIOD;
                     rst <= '0';

                     x_in <= std_logic_vector(to_unsigned(5,8));
                     wait for CLOCK_PERIOD;

                     x_in <= std_logic_vector(to_unsigned(6,8));
                     wait for CLOCK_PERIOD;

                     x_in <= std_logic_vector(to_unsigned(7,8));
                     wait for CLOCK_PERIOD;

                     x_in <= std_logic_vector(to_unsigned(8,8));
                     wait for CLOCK_PERIOD;

                     x_in <= std_logic_vector(to_unsigned(9,8));
                     wait for CLOCK_PERIOD;
                    wait;                                        
            end process;

        generate_clock : process
            begin
                clk <= '0';
                wait for CLOCK_PERIOD/2;
                clk <= '1';
                wait for CLOCK_PERIOD/2;
            end process;
end architecture;