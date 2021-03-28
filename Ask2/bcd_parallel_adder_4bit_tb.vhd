library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bcd_paraller_adder_4bit_tb is 
    end entity;

    architecture bench of bcd_paraller_adder_4bit_tb is
        component bcd_paraller_adder_4bit is 
            port (
                A,B :in std_logic_vector(15 downto 0);
                Cin : in std_logic ;
                S :out std_logic_vector (15 downto 0);
                Cout : out std_logic
            );
        end component;

        signal A ,B : std_logic_vector (15 downto 0);
        signal Cin : std_logic ;
        signal S : std_logic_vector (15 downto 0);
        signal Cout : std_logic ;

        constant TIME_DELAY : time := 10 ns;

        begin 
            module : bcd_paraller_adder_4bit port map (
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
                                        for k in 0 to 9 loop
                                            for l in 0 to 9 loop
                                             A <= std_logic_vector(to_unsigned(0,4)) & std_logic_vector(to_unsigned(0,4)) & std_logic_vector(to_unsigned(i,4)) &std_logic_vector(to_unsigned(j,4)) ;
                                             B <= std_logic_vector(to_unsigned(0,4)) & std_logic_vector(to_unsigned(0,4)) & std_logic_vector(to_unsigned(k,4)) &std_logic_vector(to_unsigned(l,4)) ;
                                             wait for TIME_DELAY ;
                                            end loop;
                                        end loop;
                                    end loop;
                                end loop;
                        
                A <= (others => '0');
                B <= (others => '0');

                wait;
            end process;

        end architecture;