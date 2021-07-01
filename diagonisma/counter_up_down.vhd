library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity counter_up_down is 
    generic (
        N : integer :=4 
    );
    port (
        clock       : in std_logic;
        reset       : in std_logic;
        set         : in std_logic;
        enable      : in std_logic;
        up_down     : in std_logic;
        data_in     : in std_logic_vector(N-1 downto 0 );
        data_out    : out std_logic_vector(N-1 downto 0 )
    );
end entity ;

architecture behavioral of counter_up_down  is 
 

        signal counter : std_logic_vector(N-1 downto 0 );
    begin 
        process (clock,reset)
            begin 
                if rising_edge(clock) then 
                    if reset = '1' then 
                        counter <= (others => '0');
                    else 
                        if enable = '1' then 
                            if set = '1' then 
                                counter <=data_in;
                            else 
                                if up_down = '0' then 
                                    if counter = N*N -1 then 
                                        counter <= counter;
                                    else 
                                        counter <= counter +1 ;
                                    end if;
                                elsif up_down = '1' then 
                                    if counter = 0 then 
                                        counter <= counter;
                                    else 
                                        counter <= counter -1 ;
                                    end if;
                                end if;
                            end if;
                        end if ;
                    end if;
                end if;
        end process;
        data_out <= counter ;
end architecture;
