library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity counter_up_down_tb is 
end entity ;

architecture bench of counter_up_down_tb is 

    component counter_up_down is 
        generic (
            N : integer :=4 
        );
        port (
            clock       : in std_logic;
            reset       : in std_logic;
            set         : in std_logic;
            enable      : in std_logic;
            up_down     : in std_logic;
            data_in     : in std_logic_vector(N-1 downto 0 );
            data_out    : out std_logic_vector(N-1 downto 0 )
        );
    end component;

    signal N                                : integer := 5 ;
    signal clock ,reset,set,enable,up_down  : std_logic ;
    signal data_in, data_out                : std_logic_vector (N-1 downto 0) ;

    constant CLOCK_PERIOD   : time := 10 ns;
    constant TIME_DELAY     : time := 10 ns;

    begin 
        counter_module  : counter_up_down 
        generic map ( N => N)
        port map (clock,reset,set,enable,up_down,data_in,data_out);

    simulation : process 
        begin 
            reset <= '1' ;
            enable <= '1';
            wait for TIME_DELAY ;

            reset <= '0';

            set <= '0';
            up_down <= '0';
            data_in <= std_logic_vector(to_unsigned(4,N));
            wait for 200 ns;
            set <= '1' ;
            wait for 10 ns ;
            set <= '0';
            wait for 50 ns;
            up_down <= '1' ;
            wait for 200 ns ;
            enable <= '0';
            data_in <= std_logic_vector(to_unsigned(0,N));
            up_down <= '0';
            wait ;
    end process;

    generate_clock : process
        begin
            clock <= '0';
            wait for CLOCK_PERIOD/2;
            clock <= '1';
            wait for CLOCK_PERIOD/2;
    end process;
end architecture;