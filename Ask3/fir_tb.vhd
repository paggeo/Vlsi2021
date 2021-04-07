library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity fir_tb is 
    end entity;

architecture bench of fir_tb is 

    component fir is 
        port(
            clk , rst : in std_logic;
            valid_in : in std_logic;
            x : in std_logic_vector(7 downto 0);
            y : out std_logic_vector(18 downto 0);
            valid_out : out std_logic
        );
    end component;
    signal clk,rst,valid_in,valid_out: std_logic;
    
    signal x : std_logic_vector(7 downto 0);
    signal y : std_logic_vector(18 downto 0); 

    constant TIME_DELAY : time := 70 ns;
    constant CLOCK_PERIOD : time := 10 ns;

    begin 
        fir_module: fir 
            port map (clk,rst,valid_in,x,y,valid_out);

        simulation : process
            begin
                rst <= '0';


                for  i in 0 to 7 loop
                    valid_in<='1';
                    x <= std_logic_vector(to_unsigned(1,8));
                    wait for CLOCK_PERIOD;
                    valid_in<= '0';
                    wait for TIME_DELAY;
                    end loop; 
            end process;


        generate_clock : process
            begin
                clk <= '0';
                wait for CLOCK_PERIOD/2;
                clk <= '1';
                wait for CLOCK_PERIOD/2;
            end process;
end architecture;
