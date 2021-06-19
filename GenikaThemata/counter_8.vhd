-- Counter 4096x8 bit --
-- Homework number 7 general issues--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity counter_8 is  
    generic (
        counter_size : integer := 4
    );
    port (
        clock       : in std_logic;
        reset       : in std_logic;
        up_down     : in std_logic; -- up/down <= '0' => up || up/down <= '1' => down
        set         : in std_logic; -- set ='0' normal counter || set = '1' then counter<= data_in
        enable      : in std_logic;
        data_in     : in std_logic_vector(counter_size-1 downto 0 );
        data_out    : out std_logic_vector(counter_size -1 downto 0 )
    );
end entity;

architecture behavioral of counter_8 is 

    signal counter : std_logic_vector(counter_size -1 downto 0):= (others=>'0');

    begin 
        process(clock,reset)
            begin 
                if reset = '1' then 
                    counter <= (others=>'0');
                else 
                    if rising_edge(clock) then
                        if enable ='0' then 
                            counter <= counter;
                        else 
                            if set = '0' then 
                                if up_down = '0' then -- this is counting up
                                    if counter = counter_size**2 -1 then 
                                        counter <= counter;
                                    else 
                                        counter <= counter + 1 ;
                                    end if;
                                else  -- this is counting down
                                    if counter = 0 then 
                                        counter <= counter;
                                    else 
                                        counter <= counter - 1;
                                    end if;
                                end if;
                            else 
                                counter <= data_in;
                            end if;
                        end if;
                    end if;
                end if;
        end process;

        data_out <= counter;
end architecture;