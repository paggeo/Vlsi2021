library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity fsm_machine_tb is 
end entity ;


architecture bench of fsm_machine_tb is 

    component fsm_machine is 
        port (
            clock : in std_logic;
            reset : in std_logic;
            A : in std_logic;
            C : out std_logic_vector(1 downto 0 )
        );
    end component;

    signal clock , reset , A : std_logic;

    signal C : std_logic_vector(1 downto 0);

    constant CLOCK_PERIOD :time := 10 ns;
    constant TIME_DELAY  : time := 10 ns;
    begin 
    fms_machine_module : fsm_machine 
        port map (clock,reset,A,C);

    simulation : process 
        begin 
            reset <= '1'; 
            wait for 20 ns;
            reset <= '0';
            A <= '1';
            wait for 10 ns;
             
            wait for 10 ns ;
            A <= '0';
            wait for 20 ns ;
            A <= '1' ;
            wait for 50 ns ;
            A <= '0';
            wait;
    end process;
    generate_clock : process
        begin 
            clock <='0' ;
            wait for CLOCK_PERIOD;
            clock <= '1' ;
            wait for CLOCK_PERIOD; 
    end process;
end architecture ;
