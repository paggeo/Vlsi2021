library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity csa_adder is 
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

end entity;

architecture behavioral of csa_adder is 

    component full_adder IS
    port (
        a,b,cin :in std_logic_vector(0 downto 0);
        sum,carry : out STD_LOGIC
        );
    end component;

    signal temp_c , temp_s : std_logic_vector(N-1 downto 0);
    signal temp_c1 , temp_s1 : std_logic_vector(N downto 0);
    signal last_adder : std_logic_vector(N downto 0);
    begin 

    fas : for i in 0 to N-1 generate 
        full_adder_module : full_adder 
            port map (
                a(0) => Z(i),
                b(0) => X(i),
                cin(0) => Y(i),
                sum => temp_s(i),
                carry =>temp_c(i)
            );
        end generate fas;
        
        temp_s1 <= '0' & temp_s;
        temp_c1 <= temp_c & '0';
        
        S <= temp_s1 ;
        C <= temp_c1;
        last_adder <= temp_s1 + temp_c1;

end architecture;
