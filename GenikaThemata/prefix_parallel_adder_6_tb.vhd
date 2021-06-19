library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity prefix_parallel_adder_6_tb is 
    end entity;
 
    architecture bench of prefix_parallel_adder_6_tb is 
        component prefix_parallel_adder_6 is 
            generic(
                prefix_parallel_adder_width:integer := 16
            );
            port(
                A	        : in	std_logic_vector(prefix_parallel_adder_width-1 downto 0);
                B	        : in	std_logic_vector(prefix_parallel_adder_width-1 downto 0);
                Cin	        : in	std_logic;
                Cout	    : out	std_logic;                             
                Result	    : out	std_logic_vector(prefix_parallel_adder_width-1 downto 0)
            );

        end component ;

        constant prefix_parallel_adder_width : integer := 16;
        signal A ,B : std_logic_vector(prefix_parallel_adder_width-1 downto 0);
        signal Cin : std_logic ;
        signal Result : std_logic_vector(prefix_parallel_adder_width-1 downto 0);
        signal Cout : std_logic ;

        begin 

            module : prefix_parallel_adder_6 
                generic map( prefix_parallel_adder_width=> prefix_parallel_adder_width)
                port map (
                    A => A,
                    B => B,
                    Cin => Cin,
                    Result => Result,
                    Cout => Cout
                );
            simulation : process 

                begin 
                    A <= std_logic_vector(to_unsigned(7,16));
                    B <= std_logic_vector(to_unsigned(3023,16));
                    Cin <= '0';
                    wait for 20 ns;
                    A <= std_logic_vector(to_unsigned(1,16));
                    B <= std_logic_vector(to_unsigned(2,16));
                    Cin <= '1';
                    wait for 20 ns;
                    A <= std_logic_vector(to_unsigned(5,16));
                    B <= std_logic_vector(to_unsigned(50,16));
                    Cin <= '1';
                    wait for 20 ns;
                    A <= std_logic_vector(to_unsigned(0,16));
                    B <= std_logic_vector(to_unsigned(0,16));
                    Cin <= '0';
                    wait;
            end process;
    end architecture;