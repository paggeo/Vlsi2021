library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity control_unit is 
    port (
        clk : in std_logic;
        rst : in std_logic;
        valid_in : in std_logic;
        rom_address : out std_logic_vector(2 downto 0);
        ram_address : out std_logic_vector (2 downto 0);
        mac_init : out std_logic;
        we : out std_logic;
        en : out std_logic
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

                        if counter = 0 and valid_in = '1' then 
                        -- correct input in 8 cyrcles
                            en <= '1';
                            we <='1';
                            mac_init <= '1';
                            rom_address <= counter;
                            ram_address <= counter;
                            counter <= counter + 1;

                        elsif counter = 0 and valid_in= '0' then -- correct input not in 8 cyrcles
                            we <='0';
                            mac_init <= '1';
                            en <='0';

                        elsif counter /= 0 then 
                            en<='1';
                            mac_init <= '0';
                            we <='0';
                            rom_address <= counter;
                            ram_address <= counter;
                            counter <= counter + 1;
                        end if;
                        
                    end if;
                end if ;

                
        end process;
end behavioral;
        

