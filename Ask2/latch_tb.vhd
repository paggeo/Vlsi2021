library IEEE;
use IEEE.std_logic_1164.all;



entity latch_tb is
    end entity;
   
architecture bench of latch_tb is
    component flipflop is
    port( 
       d, clock,reset : IN STD_LOGIC ;
            q : OUT STD_LOGIC
        );
    end component;
    
      component full_adder is
       port( 
           a,b,cin : IN std_logic;
           sum,carry : OUT std_logic
           );
       end component;
    
    
     constant TIME_DELAY : time := 40 ns;
     constant CLOCK_PERIOD : time := 10 ns;
       
       signal a,b,cin,out_sum,out_carry: std_logic;
       
       
       signal in_d,out_q: std_logic;
           signal clock,reset : std_logic;
       
   begin
   
  
   
   module2: full_adder port map(
                   a => a,
                   b => b, 
                   cin => cin,
                   sum => out_sum,
                   carry => out_carry
                   );
                   
                   
      module : flipflop port map (
                          d =>out_sum,
                          q =>out_q,
                          clock =>clock,
                          reset => reset
                     );
    stim :process
    begin 
    reset <='0';
    
    
   for i  in std_logic range '0' to '1' loop
           for j in std_logic range '0' to '1' loop
                for k in std_logic range '0' to '1' loop
                    a <= i;
                    b <= j;
                    cin <= k ;
                   wait for TIME_DELAY;
                end loop;
            end loop;
           
        end loop;
        
    
    wait for TIME_DELAY;
    
    
    
    

    
    end process;
   
   
    generate_clock : process
     begin
       clock <= '0';
       wait for CLOCK_PERIOD/2;
       clock <= '1';
       wait for CLOCK_PERIOD/2;
     end process;
     
     end architecture;
