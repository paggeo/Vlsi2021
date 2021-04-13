library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity mac is 
    generic (
        data_width : integer := 8
    );
    port (
        clk : in std_logic;
        rst :in std_logic;
        rom_out : in std_logic_vector(data_width-1 downto 0);
        ram_out : in std_logic_vector(data_width-1 downto 0);
        mac_init : in std_logic;
        y : out std_logic_vector(data_width*2+2 downto 0);
        valid_out :out std_logic

    );
end mac;

architecture behavioral of mac is

    signal y_temp : std_logic_vector(data_width*2+2 downto 0):= (others => '0');
    signal counter : std_logic_vector(2 downto 0):= (others => '0');
    
    begin 
        process (mac_init,clk)
            begin 
                if rising_edge(clk) then 
                    if mac_init = '1' then 
                        y_temp <= "000" & rom_out * ram_out;
                    else 
                        y_temp <= y_temp + rom_out * ram_out;
                    end if;                
                end if ;
                y<=y_temp;
end process;

        process (clk,mac_init)
            begin 
                if rst = '1' then 
                    valid_out <= '0';
                else 
                    if rising_edge(clk) then
                        if mac_init = '1' and counter /= 6 then 
                            counter <= (others => '0');
                            valid_out <='0';
                        elsif mac_init = '0' and counter = 6 then 
                            counter <=(others => '0');
                            valid_out <= '1';
                        elsif mac_init = '1' and counter = 6 then 
                            counter <=(others => '0');
                            valid_out <= '1';
                        else   
                            counter <= counter+1;
                            valid_out <= '0';     
                        end if;
                    end if;
                end if;
           end process;
end behavioral;


