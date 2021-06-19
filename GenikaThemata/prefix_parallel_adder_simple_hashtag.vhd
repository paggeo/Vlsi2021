library ieee;
use ieee.std_logic_1164.all;

entity prefix_parallel_adder_simple_hashtag is
  port (
        P1  : in  std_logic;
        G1  : in  std_logic;
        G_prev  : in  std_logic;    --G from previous stage
        G   : out std_logic
  );
end entity;

architecture dataflow of prefix_parallel_adder_simple_hashtag is
  
begin
  G <= (P1 and G_prev) or G1;

end architecture;