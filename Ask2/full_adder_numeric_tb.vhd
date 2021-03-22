library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity full_adder_numeric_tb is
    end entity;
    
    architecture bench of full_adder_numeric_tb is
    component full_adder_numeric is
    port( 
        a,b,cin : in std_logic_vector(0 downto 0);
        sum,carry : OUT std_logic
        );
    end component;
    
    signal sum,carry: std_logic;
    signal a,b,cin: std_logic_vector(0 downto 0);
    
    
    constant TIME_DELAY : time := 10 ns;
    
    begin
    
        module: full_adder_numeric port map(
                a => a, 
                b => b, 
                cin => cin,
                sum => sum,
                carry => carry
                );
    
    simulation: process
    begin


    for i  in 0 to 1 loop
        for j in 0 to 1 loop
            for k in 0 to 1 loop
                a <= std_logic_vector(to_unsigned(i,1));
                b <= std_logic_vector(to_unsigned(j,1));
                cin <= std_logic_vector(to_unsigned(k,1));
                wait for TIME_DELAY ;
            end loop;
        end loop;
    end loop;
    
    a <= (others => '0');
    b <= (others => '0');
    cin <= (others => '0');
    
    wait;
    
    end process;
    
    end tb;