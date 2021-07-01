library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.MATH_REAL.ALL;

entity prefix_parallel_adder is
    generic(
        prefix_parallel_adder_width:integer := 4
      );
    port(
      A	        : in	std_logic_vector(prefix_parallel_adder_width-1 downto 0);
      B	        : in	std_logic_vector(prefix_parallel_adder_width-1 downto 0);
      Cout	    : out	std_logic;                             
      Result	  : out	std_logic_vector(prefix_parallel_adder_width-1 downto 0)
    );
end;

architecture behavioral of prefix_parallel_adder is

    component prefix_parallel_adder_pg
      port(
        A	: in	std_logic;
        B	: in	std_logic;
        G	: out	std_logic;
        P	: out	std_logic
      );
    end component;

    component prefix_parallel_adder_simple_hashtag          --when we only need to produce the final Gs 
      port(
        P1	: in	std_logic;
        G1	: in	std_logic;
        G_prev	: in	std_logic;  --G of previous stage
        G	: out	std_logic
      );
    end component;

    component prefix_parallel_adder_hashtag          --when we need to produce the Gs and the Ps (intermediate levels)
      port(
        P1	: in	std_logic;
        G1	: in	std_logic;
        P_prev	: in	std_logic;  --P  from  previous stage
        G_prev	: in	std_logic;  --G  from  previous stage
        P	: out	std_logic;
        G	: out	std_logic
      );
    end component;
      
    constant size : integer := INTEGER(CEIL(LOG2(REAL(prefix_parallel_adder_width))));
      
    subtype number is std_logic_vector(prefix_parallel_adder_width-1 downto 0);
    type number_vector is array (size downto 0) of number;

    signal P: number_vector := (others=>(others=>'0'));
    signal G: number_vector:= (others=>(others=>'0'));

       
  begin  
    pg1 : prefix_parallel_adder_pg 
      port map (
        A => A(0),
        B => B(0),
        G => G(0)(0),
        P => P(0)(0)
      );
    init_2: for i in 1 to prefix_parallel_adder_width-1 generate
      pg2:prefix_parallel_adder_pg
        port map (
          A=>A(i),
          B=>B(i),
          G=>G(0)(i),
          P=>P(0)(i));
    end generate init_2;
    

    row: for i in 1 to size generate
      column: for j in 0 to prefix_parallel_adder_width-1 generate
        
        ext_loop: if ((INTEGER(FLOOR(REAL(j)/REAL(2**(i-1))))) mod 2) = 1 generate
          int_loop_1: if j < 2**(i) generate
            simple_hashtag: prefix_parallel_adder_simple_hashtag 
              port map (
                P1=>P(i-1)(j),
                G1=>G(i-1)(j),
                G_prev=>G(i)(j-1),
                G=>G(i)(j)
              );
            
          end generate int_loop_1;

          --use the normal hashtags because we need Gs and Ps
          -- we are in intermediate stages
          int_loop_2: if j >= 2**(i) generate
            hashtag: prefix_parallel_adder_hashtag 
              port map(
                P1=>P(i-1)(j),
                G1=>G(i-1)(j),
                P_prev=>P(i)(j-1),
                G_prev=>G(i)(j-1),
                P=>P(i)(j),
                G=>G(i)(j)
              );       
          end generate int_loop_2;
        end generate ext_loop;
  
        --forward the signals to the next stage
        forward: if ((INTEGER(FLOOR(REAL(j)/REAL(2**(i-1))))) mod 2) /= 1 generate
          P(i)(j) <= P(i-1)(j);
          G(i)(j) <= G(i-1)(j);
        end generate forward;
      end generate column;
    end generate row;

    --create the final result from all the finished Ps and Gs
    Result(0) <= P(0)(0);
    Final_row: for i in 1 to prefix_parallel_adder_width-1 generate
          Result(i) <= G(size)(i-1) xor P(0)(i);  
    end generate Final_row;


    Cout <= std_logic(G(size)(prefix_parallel_adder_width-1));  
                      
end architecture;