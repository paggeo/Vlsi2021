library IEEE;
use IEEE.std_logic_1164.all;

entity full_adder_tb is
    end entity;
    
    architecture bench of full_adder_tb is
    component full_adder is
    port( 
        a,b,cin : IN std_logic;
        sum,carry : OUT std_logic
        );
    end component;
    
    signal a,b,cin,sum,carry: std_logic;
    
    
    constant TIME_DELAY : time := 10 ns;
    
    begin
    
        module: full_adder port map(
                a => a,
                b => b, 
                cin => cin,
                sum => sum,
                carry => carry
                );
    
    simulation: process
    begin


    for i  in std_logic range '0' to '1' loop
        for j in std_logic range '0' to '1' loop
            for k in std_logic range '0' to '1' loop
                a <= i;
                b <= j;
                cin <= k ;
                wait for TIME_DELAY ;
            end loop;
        end loop;
    end loop;
    
    
    wait;
    
    end process;
    
    end architecture;