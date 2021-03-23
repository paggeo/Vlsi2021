library IEEE;
use IEEE.std_logic_1164.all;

entity full_adder_sq_tb is
    end entity;
    
    architecture bench of full_adder_sq_tb is
    component full_adder_sq is
    port( 
        a,b,cin : IN std_logic;
        sum,carry : OUT std_logic;
        clock,reset :in std_logic
        );
    end component;

    
    
    signal a,b,cin,sum,carry: std_logic;
    signal clock,reset : std_logic;
    
    
    constant TIME_DELAY : time := 40 ns;
    constant CLOCK_PERIOD : time := 10 ns;
    
    begin
    
        module: full_adder_sq port map(
                a => a,
                b => b, 
                cin => cin,
                sum => sum,
                carry => carry,
                clock => clock,
                reset => reset
                );
    
    simulation: process
    begin

        reset <= '0';
        

    for i  in std_logic range '0' to '1' loop
       for j in std_logic range '0' to '1' loop
            for k in std_logic range '0' to '1' loop
                a <= i;
                b <= j;
                cin <= k ;
               wait for TIME_DELAY;
            end loop;
        end loop;
       
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