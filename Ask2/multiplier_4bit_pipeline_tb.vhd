library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multiplier_4bit_pipeline_tb is 
    end entity;

    architecture bench of multiplier_4bit_pipeline_tb is 
        component multiplier_4bit_pipeline is 
        port (
            A,B :in std_logic_vector(3 downto 0);
            S :out std_logic_vector (7 downto 0);
            clock : in std_logic
        );
        end component ;
    
        signal A ,B : std_logic_vector (3 downto 0);
        signal S : std_logic_vector (7 downto 0);
       signal clock : std_logic;

        constant TIME_DELAY : time := 140 ns;
        constant CLOCK_PERIOD : time := 10 ns;

        begin 

            module : multiplier_4bit_pipeline port map (
                A => A,
                B => B,
                S => S,
                clock => clock
            );
            simulation : process 

                begin 
                
               
                
                for i in 0 to 15 loop
                    for j in 0 to 15 loop
                        A <= std_logic_vector(to_unsigned(i,4));
                        B <= std_logic_vector(to_unsigned(j,4));
                        wait for TIME_DELAY ;
                    end loop;
               end loop;
                        
                A <= (others => '0');
                B <= (others => '0');

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