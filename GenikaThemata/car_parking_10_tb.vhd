library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity car_parking_10_tb is 
    end entity;

architecture bench of car_parking_10_tb is
    component car_parking_10 is
        generic(
          parking_capacity : integer := 8
        );
        port (
          clock       : in std_logic;
          reset       : in std_logic;
          A           : in std_logic;
          B           : in std_logic;
          cars_parked  : out std_logic_vector(parking_capacity-1 downto 0)
        ) ;
      end component;

    constant size : integer := 8;

    signal clock,reset,A,B : std_logic;
    signal cars_parked : std_logic_vector(size-1 downto 0);

    constant CLOCK_PERIOD : time := 10 ns;

    begin 
        car_parking : car_parking_10 
            generic map ( parking_capacity => size)
            port map(clock,reset,A,B,cars_parked);

        simulation: process 
            begin
                reset <= '1' ;
                A <= '1';
                B<= '1';
                wait for 20 ns;  
                
                for i in 1 to 10 loop
                    reset<= '0';
                    wait for 50 ns;
                    
                    A<= '0';
                    B<= '1';
                    wait for 50 ns;

                    A<= '0';
                    B<= '0';
                    wait for 50 ns;

                    A<= '1';
                    B<= '0';
                    wait for 50 ns;

                    A<= '1';
                    B<= '1';
                    wait for 50 ns;
                end loop;


                for i in 1 to 10 loop
                    reset<= '0';
                    wait for 50 ns;
                    
                    A<= '1';
                    B<= '0';
                    wait for 50 ns;

                    A<= '0';
                    B<= '0';
                    wait for 50 ns;

                    A<= '0';
                    B<= '1';
                    wait for 50 ns;

                    A<= '1';
                    B<= '1';
                    wait for 50 ns;
                end loop;

                wait;
                

        end process;
        generate_clock : process
            begin
                clock <= '0';
                wait for CLOCK_PERIOD/2;
                clock <= '1';
                wait for CLOCK_PERIOD/2;
        end process;
end architecture;