library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity full_adder_numeric_sq IS
port (
      a,b,cin :in std_logic_vector(0 downto 0);
      sum,carry : out STD_LOGIC;
      clock,reset : in std_logic
      );
end entity;

architecture dataflow of full_adder_numeric_sq is


signal s1 : std_logic_vector(1 downto 0);

begin

      process (clock,reset)
      begin 
            s1 <= ('0'& a) + ('0'& b) +('0'& cin);

            if rising_edge(clock) then 
                  if reset = '1' then 
                        carry <= '0';
                        sum <= '0';
                  else 
                        carry <= s1(1);
                        sum <= s1(0);
                  end if; 
            end if;
      end process;

      

end architecture;

