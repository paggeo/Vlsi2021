library IEEE;
use IEEE.std_logic_1164.all;

entity half_adder is
port(
    a,b : IN std_logic;
    sum,carry : OUT std_logic
);
end entity;

architecture dataflow of half_adder is
begin

sum <= a xor b;
carry <= a and b;

end architecture;