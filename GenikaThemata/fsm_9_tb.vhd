library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity fsm_9_tb is 
    end entity;

architecture bench of fsm_9_tb is 
    component fsm_9 is
        port (
        clock       : in std_logic;
        reset       : in std_logic;
        fsm_input   : in std_logic;
        fsm_output  : out std_logic_vector(1 downto 0)
        ) ;
    end component;
    
    signal clock ,reset ,fsm_input  : std_logic;
    signal fsm_output               :  std_logic_vector(1 downto 0 );

    constant CLOCK_PERIOD : time := 10 ns;

    begin 
        fsm: fsm_9 
            port map (clock,reset,fsm_input,fsm_output);
            
        simulation : process
            begin 
                reset<='1' ;
                wait for 20 ns;
                reset <= '0';

                fsm_input <= '0';--s1
                wait for 20 ns;

                fsm_input <= '1' ; -- s2
                wait for 10 ns ;

                fsm_input <= '0'; --s3
                wait for 10 ns;

                fsm_input <= '1' ; --s4
                wait for 10 ns;

                fsm_input<= '1' ; --s1

                wait for 10 ns;

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