library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity rca_4bit_combinational IS
port (
    a,b :in std_logic_vector(3 downto 0);
    cin : in std_logic;
    s : out std_logic_vector(3 downto 0);
    cout : out std_logic
);
end entity;

architecture structural of rca_4bit_combinational is
    component full_adder_numeric
        port (
            a,b,cin :in std_logic_vector(0 downto 0);
            sum,carry : out STD_LOGIC
        );

    end component;
    
    signal c1,c2,c3: STD_LOGIC;
 
begin
   
    FA1:full_adder_numeric port map (
                a(0)=>a(0),
                b(0) => b(0),
                cin(0) => cin,
                sum => s(0),
                carry => c1
            );
          
    FA2:full_adder_numeric port map (
            a(0)=>a(1),
            b(0) => b(1),
            cin(0) => c1,
            sum => s(1),
            carry => c2
        );
    FA3:full_adder_numeric port map (
            a(0)=>a(2),
            b(0) => b(2),
            cin(0) => c2,
            sum => s(2),
            carry => c3
        );
    FA4:full_adder_numeric port map (
            a(0)=>a(3),
            b(0) => b(3),
            cin(0) => c3,
            sum => s(3),
            carry => cout
        );
end architecture;



