library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bcd_full_adder_tb is 
    end entity;

    architecture bench of bcd_full_adder_tb is 
        component bcd_full_adder is 
        port (
            A ,B : in std_logic_vector (3 downto 0);
            Cin : in std_logic ;
            S : out std_logic_vector (3 downto 0) ;
            Cout : out std_logic 
        );
        end component ;
    
        signal A ,B : std_logic_vector (3 downto 0);
        signal Cin : std_logic ;
        signal S : std_logic_vector (3 downto 0);
        signal Cout : std_logic ;

        constant TIME_DELAY : time := 10 ns;

        begin 

            module : bcd_full_adder port map (
                A => A,
                B => B,
                Cin => Cin,
                S => S,
                Cout => Cout
            );
            simulation : process 

                begin 

                Cin <= '0';
                for i in 0 to 9 loop
                    for j in 0 to 9 loop
                        A <= std_logic_vector(to_unsigned(i,4));
                        B <= std_logic_vector(to_unsigned(j,4));
                        wait for TIME_DELAY ;
                    end loop;
                end loop;
                        
                A <= (others => '0');
                B <= (others => '0');

                wait;
            end process;
                
    
    end architecture;