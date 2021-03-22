library IEEE;
Use IEEE. STD_LOGIC_1164.all;

entity full_adder IS
port (
      a,b,cin :in STD_LOGIC;
      sum,carry : out STD_LOGIC
      );
end entity;

architecture structural of full_adder is

component half_adder is
port (
      a,b :in STD_LOGIC;
      sum,carry: out STD_LOGIC
      );
end component;


signal s1,c1,c2 : STD_LOGIC;
begin
      w1: half_adder port map (
            a => a,
            b => b,
            sum => s1, 
            carry => c1
            );
      w2: half_adder port map (
            a => s1,
            b => cin, 
            sum => sum,
            carry => c2
            );
      carry <= c1 or c2;
end architecture;

