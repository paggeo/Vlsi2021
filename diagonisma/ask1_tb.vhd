library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity ask1_tb is 

end entity;


architecture bench of ask1_tb is 

    component ask1


    end component;

    constant clock_period : time := 10 ns;

    signal 

    begin 

    module : ask1 
    generic map ()
    port map ();
    simulation : process
            begin 
                
        end process;

        generate_clock : process 
            begin 
                clock <= '0';
                wait for clock_period/2;
                clock <= '1'; 
                wait for clock_period/2;
        end process;
end architecture;