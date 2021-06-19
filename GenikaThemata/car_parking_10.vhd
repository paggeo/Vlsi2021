-- Car parking system --
-- Homework number 10 general issues--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity car_parking_10 is
  generic(
    parking_capacity : integer := 8
  );
  port (
    clock       : in std_logic;
    reset       : in std_logic;
    A           : in std_logic;
    B           : in std_logic;
    cars_parked  : out std_logic_vector(parking_capacity-1 downto 0)
  ) ;
end entity;

architecture behavioral of car_parking_10 is 
    
    type state_type is (idle,blockA,between,freeA,parking_out,error_state);

    signal next_state,current_state : state_type := idle ;
    signal counter : std_logic_vector(parking_capacity-1 downto 0):=(others=>'0');

    begin 

        

       state_reg : process (clock,reset)
        begin 
            if reset = '1' then 
                current_state <= idle;
                --counter<= (others=>'0');
            else 
                if rising_edge(clock) then 
                    current_state <= next_state;
                    cars_parked <= counter;                    
                end if;
            end if;
       end process;

       comp_logic : process(current_state,A,B,reset) 
        begin 
            if reset = '1' then 
                counter<= (others=> '0');
            else 
                case current_state is 
                    when idle =>    if A = '1' and B = '1' then 
                                        next_state <= idle;                                    
                                    elsif A='0' and B = '1' then 
                                        next_state<=blockA;
                                    else 
                                        next_state <= idle;
                                    end if;

                    when blockA =>  if A = '0' and B= '1' then 
                                        next_state <= blockA ;
                                    elsif A = '0' and B = '0' then
                                        next_state <= between ;
                                    else 
                                        next_state <= blockA;
                                    end if;

                    when between =>     if A = '0' and B = '0' then 
                                            next_state <= between ;
                                        elsif A = '1' and B = '0' then 
                                            next_state <= freeA ;
                                        else 
                                            next_state <= between;
                                        end if;

                    when freeA =>   if A='1' and B = '0' then
                                        next_state <= freeA ;
                                    elsif A= '1' and B = '1' then 
                                        next_state <= idle ;
                                        counter <= counter +1;
                                    else 
                                        next_state <= freeA;
                                    end if;

                    when others =>  next_state <= idle;
                    end case;
                end if;
       end process;
end architecture;