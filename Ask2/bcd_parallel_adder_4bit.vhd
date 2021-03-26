library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bcd_paraller_adder_4bit is 
    port (
        A,B :in std_logic_vector(15 downto 0);
        Cin : in std_logic ;
        S :out std_logic_vector (15 downto 0);
        Cout : out std_logic
    );
end entity;

architecture structural of bcd_paraller_adder_4bit is 
    component bcd_full_adder is 
        port (
            A ,B : in std_logic_vector (3 downto 0);
            Cin : in std_logic ;
            S : out std_logic_vector (3 downto 0) ;
            Cout : out std_logic 
        );
    end component ;

    signal cout1,cout2,cout3 : std_logic;

begin 
    BCD1 : bcd_full_adder port map(A(3 downto 0),B(3 downto 0),Cin,S(3 downto 0),cout1);
    BCD2 : bcd_full_adder port map(A(7 downto 4),B(7 downto 4),cout1,S(7 downto 4),cout2);
    BCD3 : bcd_full_adder port map(A(11 downto 8),B(11 downto 8),cout2,S(11 downto 8),cout3);
    BCD4 : bcd_full_adder port map(A(15 downto 12),B(15 downto 12),cout3,S(15 downto 12),Cout);
end architecture;