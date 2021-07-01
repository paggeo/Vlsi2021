library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity add_4_numbers_tb is 
end entity ;


architecture bench of add_4_numbers_tb is 
    component add_4_numbers is 
        generic (
            N :integer :=4
        );
        port (
            clock : in std_logic;
            A : in std_logic_vector(N-1 downto 0);
            B : in std_logic_vector(N-1 downto 0);
            C : in std_logic_vector(N-1 downto 0);
            D : in std_logic_vector(N-1 downto 0);
            Cout : out std_logic;
            Result : out std_logic_vector(N+1 downto 0)
        );

    end component;


    signal N : integer :=4 ;
    signal clock : std_logic;

    signal A,B,C,D : std_logic_vector(N-1 downto 0);
    signal Cout : std_logic;
    signal Result : std_logic_vector(N+1 downto 0 );

    constant clock_period : time := 10 ns;
    
    begin 
        add_4_numbers_module : add_4_numbers 
            generic map ( N => N )
            port map (clock,A,B,C,D,Cout,Result);

        simulation : process
            begin 
                A <= std_logic_vector(to_unsigned(1,N));
                B <= std_logic_vector(to_unsigned(2,N));
                C <= std_logic_vector(to_unsigned(3,N));
                D <= std_logic_vector(to_unsigned(4,N));
                wait for 10 ns;
                A <= std_logic_vector(to_unsigned(5,N));
                B <= std_logic_vector(to_unsigned(6,N));
                C <= std_logic_vector(to_unsigned(7,N));
                D <= std_logic_vector(to_unsigned(8,N));
                wait for 10 ns;
                A <= std_logic_vector(to_unsigned(15,N));
                B <= std_logic_vector(to_unsigned(15,N));
                C <= std_logic_vector(to_unsigned(15,N));
                D <= std_logic_vector(to_unsigned(15,N));
                wait ;
        end process;
        generate_clock : process 
            begin 
                clock <= '0';
                wait for clock_period/2;
                clock <= '1'; 
                wait for clock_period/2;
        end process;
end architecture;

