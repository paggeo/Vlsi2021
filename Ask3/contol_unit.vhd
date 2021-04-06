library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity control_unit is 
    port (
        clk : in std_logic;
        rst : in std_logic;
        rom_address : out std_logic_vector(2 downto 0);
        ram_address : out std_logic_vector (2 downto 0);
        mac_init : out std_logic
        );
end control_unit;

architecture behavioral of control_unit is 

    signal counter : std_logic_vector(2 downto 0):=(others=>'0');

    begin 
        process(clk,rst)
            begin 
                if rst = '1' then 
                    counter <= (others => '0');
                else 
                    if rising_edge(clk) then 
                        if counter = 0 then 
                            mac_init <= '1';
                        else 
                            mac_init <= '0';
                        end if;
                        counter <= counter + 1;
                        rom_address <= counter;
                        ram_address <= counter;
                        
                    end if;
                end if ;

                
        end process;
end behavioral;
        

