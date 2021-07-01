library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity add_4_numbers is 
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

end entity;


architecture behavioral of add_4_numbers is 
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

    component prefix_parallel_adder is
        generic(
            prefix_parallel_adder_width:integer := 4
          );
        port(
          A	        : in	std_logic_vector(prefix_parallel_adder_width-1 downto 0);
          B	        : in	std_logic_vector(prefix_parallel_adder_width-1 downto 0);
          Cout	    : out	std_logic;                             
          Result	  : out	std_logic_vector(prefix_parallel_adder_width-1 downto 0)
        );
    end component;

    signal temp1 ,temp2 : std_logic_vector(N downto 0):=(others =>'0');
    signal temp12 ,temp22,temp32 : std_logic_vector(N downto 0):=(others =>'0');
    signal temp_S,temp_C : std_logic_vector(N+1 downto 0):=(others =>'0');
    signal temp_S1,temp_C1 : std_logic_vector(N+1 downto 0):=(others =>'0');

    begin 

        csa_module1 : csa_adder 
        generic map (N => N)
        port map  (A,B,C,temp1,temp2);

        csa_module2 : csa_adder 
        generic map ( N => N+1)
        port map (temp12,temp22,temp32,temp_S,temp_C);

        prefix_parallel_adder_module : prefix_parallel_adder
         generic map (prefix_parallel_adder_width => N+2)
         port map (temp_C1,temp_S1,Cout,Result );

        process(clock)
            begin 
                if rising_edge(clock) then 
                    temp_S1 <= temp_S;
                    temp_C1 <= temp_C;
                    temp12<= temp1;
                    temp22 <= temp2 ;
                    temp32 <= '0' & D;
                end if;
        end process;

end architecture;