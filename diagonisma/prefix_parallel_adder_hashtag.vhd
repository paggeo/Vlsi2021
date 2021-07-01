library ieee;
use ieee.std_logic_1164.all;

entity prefix_parallel_adder_hashtag is
  port (
    P1  : in  std_logic;
    G1  : in  std_logic;
    P_prev  : in  std_logic;  --P  from  previous stage
    G_prev  : in  std_logic;  --G  from previous stage
    P : out std_logic;
    G : out std_logic
    );
end entity;

architecture dataflow of prefix_parallel_adder_hashtag is
  
begin
  P <= P1 and P_prev;
  G <= (P1 and G_prev) or G1;
end architecture;