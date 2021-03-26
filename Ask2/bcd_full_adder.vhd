library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bcd_full_adder is 
    port (
        A ,B : in std_logic_vector (3 downto 0);
        Cin : in std_logic ;
        S : out std_logic_vector (3 downto 0) ;
        Cout : out std_logic 
    );
end entity ;

architecture structural of bcd_full_adder is
    component rca_4bit_combinational 
        port (
        a,b :in std_logic_vector(3 downto 0);
        cin : in std_logic;
        s : out std_logic_vector(3 downto 0);
        cout : out std_logic
        );
    end component;

    signal fa1_s  : std_logic_vector (3 downto 0) ;
    signal fa1_cout : std_logic ;
    signal and1 , and2 :std_logic ;
    signal or1 :std_logic ;
    signal second_input : std_logic_vector (3 downto 0) ;
    signal irelevant : std_logic ;
 begin

        FA1 :rca_4bit_combinational port map (
            a => A,
            b => B,
            cin => Cin,
            s => fa1_s,
            cout=> fa1_cout
        ); 
        and1 <= fa1_s(3) and fa1_s(2);
        and2 <= fa1_s(3) and fa1_s(1);
        or1 <=  and1 or and2 or fa1_cout ;
        second_input <= '0' & or1 & or1 & '0';

        FA2 : rca_4bit_combinational port map (
            a => second_input,
            b => fa1_s ,
            cin => '0',
            s => S,
            cout => irelevant
        );
        Cout <= or1;

end architecture;