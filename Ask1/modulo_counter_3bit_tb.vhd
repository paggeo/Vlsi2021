library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity modulo_counter_3bit_tb is
end entity;

architecture bench of modulo_counter_3bit_tb is

  component modulo_counter_3bit is
    port(	
        clk,resetn,count_en : in std_logic;
	    sum :	out std_logic_vector(2 downto 0);
      modulo :	in std_logic_vector(2 downto 0);
	    cout :	out std_logic
);
  end component;
  signal input_clk : std_logic ;
  signal input_resetn : std_logic := '0'  ;
  signal input_count_en : std_logic := '0'  ;
  signal output_sum : std_logic_vector(2 downto 0) ;
  signal input_modulo : std_logic_vector(2 downto 0) := (others => '0');
  signal output_cout  : std_logic;


  constant TIME_DELAY : time := 10 ns;
  constant CLOCK_PERIOD : time := 10 ns;
  constant CLOCK_PERIOD_2 : time := 70 ns;
begin

  uut : modulo_counter_3bit
    port map (
              clk  => input_clk,
              resetn  => input_resetn, -- 0 to 1 i  
              count_en  => input_count_en,   -- 0 to 1 j
              sum  => output_sum,   
              modulo  => input_modulo,   -- 0 to 7 k 
              cout  => output_cout
              );

  stimulus : process
  begin
    input_resetn <= '0';
    input_count_en <= '0';
    input_modulo <= (others => '0');
    wait for CLOCK_PERIOD;

    for i  in std_logic range '0' to '1' loop -- input_resetn loop
        for j in std_logic range '0' to '1' loop -- input_count_en loop
            for k in 0 to 7 loop -- input_modulo loop

                            input_resetn <= i;
                            input_count_en <= j;
                            input_modulo <= std_logic_vector(to_unsigned(k, 3));
                            wait for CLOCK_PERIOD_2;
            end loop;
        end loop;
    end loop; 
      input_resetn <= '0';
      input_count_en <= '0';
      input_modulo <= (others => '0');
      wait;
    end process;

    generate_clock : process
    begin
      input_clk <= '0';
      wait for CLOCK_PERIOD/2;
      input_clk <= '1';
      wait for CLOCK_PERIOD/2;
    end process;
   
end architecture;


