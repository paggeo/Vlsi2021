library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity full_adder_numeric_sq_tb is
    end entity;
    
    architecture bench of full_adder_numeric_sq_tb is
    component full_adder_numeric_sq is
    port( 
        a,b,cin :in std_logic_vector(0 downto 0);
        sum,carry : out STD_LOGIC;
        clock,reset : in std_logic
        );
    end component;
    
    signal sum,carry,clock,reset: std_logic;
    signal a,b,cin: std_logic_vector(0 downto 0);
    
    
    constant TIME_DELAY : time := 40 ns;
    constant CLOCK_PERIOD : time := 10 ns;
    
    begin
    
        module: full_adder_numeric_sq port map(
                a => a, 
                b => b, 
                cin => cin,
                sum => sum,
                carry => carry,
                clock => clock,
                reset => reset
                );
    
    simulation: process
    begin

    reset <='0';
    for i  in 0 to 1 loop
        for j in 0 to 1 loop
            for k in 0 to 1 loop
                a <= std_logic_vector(to_unsigned(i,1));
                b <= std_logic_vector(to_unsigned(j,1));
                cin <= std_logic_vector(to_unsigned(k,1));
                wait for TIME_DELAY ;
            end loop;
        end loop;
    end loop;
    
    a <= (others => '0');
    b <= (others => '0');
    cin <= (others => '0');
    
    wait;
    
    end process;

    generate_clock : process
    begin
      clock <= '0';
      wait for CLOCK_PERIOD/2;
      clock <= '1';
      wait for CLOCK_PERIOD/2;
    end process;
    
    end bench;