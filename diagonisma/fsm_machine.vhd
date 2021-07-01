library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity fsm_machine is 
    port (
        clock       : in std_logic;
        reset       : in std_logic;
        A           : in std_logic;
        C           : out std_logic_vector(1 downto 0 )
    );
end entity ;

architecture behavioral of fsm_machine  is 
    
    type state_type is (S1,S2,S3,S4);

    signal current_state , next_state : state_type := S1 ;

    begin 
        state_reg : process (clock,reset)
            begin
                if reset = '1' then 
                    current_state <= S1 ;
                else 
                    if rising_edge(clock) then 
                        current_state <= next_state;
                    end if;
                end if;
        
        end process;

        comp_logic : process(current_state,A)
            begin 
                case current_state is 
                    when S1 => C <= "00";
                                    if A = '0' then 
                                        next_state <= S1 ;
                                    elsif A = '1' then 
                                        next_state <= S2 ;
                                    end if;
                    when S2 => C <= "01";
                                    if A = '0' then 
                                        next_state <= S1 ;
                                    elsif A = '1' then 
                                        next_state <= S3 ;
                                    end if;

                    when S3 => C <= "10";
                                    if A = '0' then 
                                        next_state <= S2 ;
                                    elsif A = '1' then 
                                        next_state <= S4 ;
                                    end if;    
                    when S4 => C <= "11";
                                    if A = '0' then 
                                        next_state <= S3 ;
                                    elsif A = '1' then 
                                        next_state <= S4 ;
                                    end if;
                    when others => C <= "00";
                                    next_state <= S1;
                end case;
        end process;
        
end architecture;