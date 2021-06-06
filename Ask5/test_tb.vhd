library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity test_tb is 

end entity ;

architecture bench of test_tb is 
    component test is 
        port(
            clock: in std_logic;
            reset: in std_logic;

            pixel_din : in std_logic_vector(7 downto 0);
            pixel_valid_in : in std_logic;
            

            image_finished : out std_logic;
            pixel_valid_out : out std_logic;
            t_ready_in: in std_logic;
            t_ready_out : out std_logic;

            pixel_dout : out std_logic_vector(31 downto 0)
        );
    end component ;

    constant TIME_DELAY : time := 10 ns;
    signal clock ,reset,pixel_valid_in,image_finished,pixel_valid_out,t_ready_in,t_ready_out : std_logic;
    signal pixel_din : std_logic_vector(7 downto 0);
    signal pixel_dout : std_logic_vector(31 downto 0);

    begin 

    module : test 
        port map(clock,reset,pixel_din,pixel_valid_in,image_finished,pixel_valid_out,t_ready_in,t_ready_out,pixel_dout);

        simulation : process
            begin 

                pixel_valid_in <= '1';
                t_ready_in <= '1';

                for i in  1 to 16 loop
                    pixel_din <= std_logic_vector(to_unsigned(i,8));
                    wait for TIME_DELAY;
                end loop;
                pixel_valid_in <= '0';
                t_ready_in <= '0';

                wait;
        end process;


        generate_clock : process
        begin
            clock <= '0';
            wait for TIME_DELAY/2;
            clock <= '1';
            wait for TIME_DELAY/2;
        end process;

end architecture;