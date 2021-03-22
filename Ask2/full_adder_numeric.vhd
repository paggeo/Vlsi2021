library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity full_adder_numeric IS
port (
      a,b,cin :in std_logic_vector(0 downto 0);
      sum,carry : out STD_LOGIC
      );
end entity;

architecture dataflow of full_adder_numeric is


signal s1 : std_logic_vector(1 downto 0);

begin
      s1 <= ('0'& a) + ('0'& b) +('0'& cin);
      carry <= s1(1);
      sum <= s1(0);

end architecture;

