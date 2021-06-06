library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity test is
    port(
        clock: in std_logic;
        reset: in std_logic;

        pixel_din : in std_logic_vector(7 downto 0);
        pixel_valid_in : in std_logic;
        

        image_finished : out std_logic;
        pixel_valid_out : out std_logic;
        t_ready_in: in std_logic;
        t_ready_out : out std_logic;

        pixel_dout : out std_logic_vector(31 downto 0)
    );
end entity;

architecture behavioral of test is 
    signal counter : std_logic_vector(7 downto 0):=(others =>'0');
    
    begin 
        
        process(clock,reset)
            begin 
                if rising_edge(clock) then 
                    if pixel_valid_in = '1' and t_ready_in = '1' then 
                        
                        pixel_dout <= "00000000"&"00000000"&"00000000"&pixel_din;
                        if counter(0) = '1' then 
                            pixel_valid_out <= '1';
                        else pixel_valid_out <= '0';
                        end if;
                    else 
                        pixel_dout<=(others=> '0');
                        pixel_valid_out <= '0';
                    end if;
                end if;
        end process; 

        process (clock,reset)
            begin 
                if rising_edge(clock) then 
                    if pixel_valid_in = '1' and t_ready_in = '1' then 
                        counter<=counter +1 ;
                    else 
                        counter<= counter;
                    end if;

                    if counter = 15  then 
                        image_finished <='1';
                        counter <=(others=>'0');
                    else 
                        image_finished <='0';
                    end if;
                end if;
        end process ;
        
        process(clock,reset)
        
            begin 
                if rising_edge(clock) then 
                    t_ready_out <= '1';
               end if;
        end process;
end architecture;


