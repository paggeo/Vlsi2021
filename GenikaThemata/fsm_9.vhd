-- 8 State Fsm --
-- Homework number 9 general issues--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity fsm_9 is
  port (
    clock       : in std_logic;
    reset       : in std_logic;
    fsm_input   : in std_logic;
    fsm_output  : out std_logic_vector(1 downto 0)
  ) ;
end entity;

architecture behavioral of fsm_9 is 
    
    type state_type is (S1,S2,S3,S4);

    signal next_state,current_state : state_type := S1 ;

    begin 

       state_reg : process (clock,reset)
        begin 
            if reset = '1' then 
                current_state <= S1;
            else 
                if rising_edge(clock) then 
                    current_state <= next_state;
                end if;
            end if;
       end process;

       comp_logic : process(current_state,fsm_input) 
        begin 
            case current_state is 
                when S1 =>  fsm_output <="00";
                            if fsm_input = '0' then 
                                next_state <= S1 ;
                            elsif fsm_input = '1' then 
                                next_state <= S2 ;
                            end if;

                when S2 =>  fsm_output <="01";
                            if fsm_input = '0' then 
                                next_state <= S3 ;
                            elsif fsm_input = '1' then
                                next_state <= S4 ; 
                            end if;

                when S3 =>  fsm_output <="10";
                            if fsm_input = '0' then 
                                next_state <= S3 ;
                            elsif fsm_input = '1' then 
                                next_state <= S4 ;
                            end if;

                when S4 =>  fsm_output <="11";
                            if fsm_input = '0' then
                                next_state <= S2 ; 
                            elsif fsm_input = '1' then 
                                next_state <= S1 ;
                            end if;

                when others =>  fsm_output <= "00";
                                next_state <= S1;
                end case;
       end process;
end architecture;