library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity csa_adder_tb is 
end entity;

architecture bench of csa_adder_tb is 


    component csa_adder is 
        generic (
                N : integer := 4
        );
        port(
            Z : in std_logic_vector(N-1 downto 0);
            X : in std_logic_vector(N-1 downto 0);
            Y : in std_logic_vector(N-1 downto 0);
            C : out std_logic_vector(N downto 0);
            S : out std_logic_vector(N downto 0 )
        );

    end component;

    signal N : integer := 4;
    signal Z,X,Y : std_logic_vector(N-1 downto 0);
    signal C,S : std_logic_vector(N downto 0 );

    begin 
        csa_adder_module : csa_adder 
            generic map (N => N)
            port map (Z,X,Y,C,S);

        simulation : process
            begin 
                Z <= std_logic_vector(to_unsigned(2,N));
                X <= std_logic_vector(to_unsigned(2,N));
                Y <= std_logic_vector(to_unsigned(2,N));
                wait for 20 ns;
                Z <= std_logic_vector(to_unsigned(2,N));
                X <= std_logic_vector(to_unsigned(3,N));
                Y <= std_logic_vector(to_unsigned(4,N));
                wait for 20 ns;
                Z <= std_logic_vector(to_unsigned(4,N));
                X <= std_logic_vector(to_unsigned(3,N));
                Y <= std_logic_vector(to_unsigned(2,N));
                wait ;

        end process;



end architecture;