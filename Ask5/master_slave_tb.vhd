library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity master_slave_tb is 

end entity ;


architecture bench of master_slave_tb is 
    component master_slave is 
        port(
            clock: in std_logic;
            reset: in std_logic;

            T_data_in : in std_logic_vector(7 downto 0);
            T_valid_in : in std_logic;
            T_last_in : in std_logic;
           
            T_ready_out : out std_logic;

            T_data_out : out std_logic_vector(31 downto 0);
            T_valid_out : out std_logic;
            T_last_out : out std_logic;
            T_ready_in : in std_logic
        );
    end component ;

    constant TIME_DELAY : time := 10 ns;
    
    signal clock,reset : std_logic;
    signal T_data_in : std_logic_vector(7 downto 0);
    signal T_ready_in,T_valid_in,T_last_in : std_logic;
    signal T_data_out : std_logic_vector(31 downto 0);
    signal T_valid_out,T_last_out : std_logic;
    signal T_ready_out :std_logic;

   

    begin
        
    module : master_slave 
        port map (clock,reset,T_data_in,T_valid_in,T_last_in,T_ready_out,T_data_out,T_valid_out,T_last_out,T_ready_in);

        simulation : process
         begin
           
            reset<='0';
            T_valid_in <= '1';
            T_ready_in <= '1';
            

            for i in 1 to 16 loop
                T_data_in <= std_logic_vector(to_unsigned(i,8));
                wait for TIME_DELAY;
            end loop;

    
           

            T_data_in <= std_logic_vector(to_unsigned(0,8));
            T_valid_in <= '0';
            T_ready_in <= '1';
            
            wait for 100 ns ; 
            
            T_ready_in <= '0';
            
            wait for 20 ns ;
            
            T_ready_in <= '1';

            wait;
        end process;

        generate_clock : process
        begin
            clock <= '0';
            wait for TIME_DELAY/2;
            clock <= '1';
            wait for TIME_DELAY/2;
        end process;

end architecture;