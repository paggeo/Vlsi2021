library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity mac is 
    generic (
        data_width : integer := 8
    );
    port (
        rom_out : in std_logic_vector(data_width-1 downto 0);
        ram_out : in std_logic_vector(data_width-1 downto 0);
        mac_init : in std_logic;
        y : out std_logic_vector(data_width*2-1 downto 0)

    );
end mac;

architecture behavioral of mac is

    signal y_temp : std_logic_vector(data_width*2-1 downto 0);
    
    begin 
        process (mac_init,rom_out,ram_out)
            begin 
                if mac_init = '1' then 
                    y_temp <= (others => '0');
                    y<= (others => '0');
                else 
                    
                    y_temp <= y_temp + rom_out * ram_out;
                    y<= y_temp + rom_out * ram_out;
                end if ;
                
                
            end process;
end behavioral;


