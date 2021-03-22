library IEEE;
use IEEE.std_logic_1164.all;

entity half_adder_tb is
end entity;

architecture bench of half_adder_tb is
component half_adder is
port( 
    a,b : IN std_logic;
    sum,carry : OUT std_logic
    );
end component;

signal a,b,sum,carry: std_logic;


constant TIME_DELAY : time := 10 ns;

begin

    module: half_adder port map(
        a => a,
        b => b,
        sum => sum,
        carry => carry
    );

    simulation: process
    begin

    a <= '0';
    b <= '0';
    wait for TIME_DELAY ;

    a <= '0';
    b <= '1';
    wait for TIME_DELAY ;

    a <= '1';
    b <= '0';
    wait for TIME_DELAY ;

    a <= '1';
    b <= '1';
    wait for TIME_DELAY ;

    wait;

    end process;

end architecture;