library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dec3to8_behavioral_tb is
end entity;

architecture bench of dec3to8_behavioral_tb is

  component dec3to8_behavioral is
    port(	
	dec_in :	in std_logic_vector(2 downto 0);
	dec_out :	out std_logic_vector(7 downto 0);
	e :in std_logic 
);
  end component;

  signal input_A  : std_logic_vector(2 downto 0) := (others => '0');
  signal output_B  : std_logic_vector(7 downto 0);
  signal input_C : std_logic := '0'  ;

  constant TIME_DELAY : time := 10 ns;

begin

  uut : dec3to8_behavioral
    port map (
              dec_in  => input_A,
              dec_out  => output_B,
              e => input_C
              );

  stimulus : process
  begin
    input_A <= (others => '0');
    input_C <= '0';
    wait for TIME_DELAY;
    ----- Stimulus example 1 -----
    input_A <= "000";
    wait for TIME_DELAY;
    input_A <= "001";
    
    wait for TIME_DELAY;
    input_A <= "010";
    
    wait for TIME_DELAY;
    input_A <= "011";

    wait for TIME_DELAY;
    input_A <= "100";
    
    wait for TIME_DELAY;
    input_A <= "101";
    
    wait for TIME_DELAY;
    input_A <= "110";

    wait for TIME_DELAY;
    input_A <= "111";

    wait for TIME_DELAY;
    input_A <= "000";
    input_C <=  '1';
    
    wait for TIME_DELAY;
    input_A <= "001";
    
    wait for TIME_DELAY;
    input_A <= "010";
    
    wait for TIME_DELAY;
    input_A <= "011";

    wait for TIME_DELAY;
    input_A <= "100";
    
    wait for TIME_DELAY;
    input_A <= "101";
    
    wait for TIME_DELAY;
    input_A <= "110";

    wait for TIME_DELAY;
    input_A <= "111";
    
    wait for TIME_DELAY;
    input_A <= (others => '0');
    input_C <= '0';
    wait;
   
  end process;

end architecture;

