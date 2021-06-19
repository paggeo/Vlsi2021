library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity counter_8_tb is 
    end entity;

architecture bench of counter_8_tb is
    component counter_8 is  
        generic (
            counter_size : integer := 4
        );
        port (
            clock       : in std_logic;
            reset       : in std_logic;
            up_down     : in std_logic; -- up/down <= '0' => up || up/down <= '1' => down
            set         : in std_logic; -- set ='0' normal counter || set = '1' then counter<= data_in
            enable      : in std_logic;
            data_in     : in std_logic_vector(counter_size-1 downto 0 );
            data_out    : out std_logic_vector(counter_size -1 downto 0 )
        );
    end component;

    constant size : integer := 32;

    signal clock, reset ,up_down , set,enable : std_logic;
    signal data_in ,data_out : std_logic_vector(size -1  downto 0);

    constant CLOCK_PERIOD : time := 10 ns;

    begin 
        counter : counter_8 
            generic map ( counter_size => size)
            port map(clock,reset, up_down,set,enable,data_in,data_out);

        simulation: process 
            begin
                reset <= '1' ;
                wait for 20 ns ;

                reset<= '0';
                enable <= '1';
                up_down <= '0';
                set<= '0';
                
                data_in<= std_logic_vector(to_unsigned(0,size));
                wait for 100 ns;

                up_down <= '1' ; 
                wait for 90 ns;
                
                set <= '1' ;
                up_down<= '0';
                data_in<= std_logic_vector(to_unsigned(6,size)); 
                wait for CLOCK_PERIOD;
                set <= '0';

                wait for 100 ns;

                up_down <='1';
                wait for 90 ns;

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