library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity mac_tb is 
    end entity;

architecture bench  of mac_tb is

    component mac is 
        generic (
            data_width : integer := 8
        );
        port (
            rom_out : in std_logic_vector(data_width-1 downto 0);
            ram_out : in std_logic_vector(data_width-1 downto 0);
            mac_init : in std_logic;
            y : out std_logic_vector(data_width*2-1 downto 0)

        );
    end component;

    signal mac_init : std_logic;
    signal rom_out,ram_out : std_logic_vector(7 downto 0);
    signal y : std_logic_vector(15 downto 0);

    constant TIME_DELAY : time := 10 ns;

    begin 
        mac1 : mac 
            generic map ( data_width=> 8)
            port map (rom_out,ram_out,mac_init,y);

        simulation: process 
            begin 
                mac_init<= '1';
                wait for TIME_DELAY;
                mac_init <= '0';

                for i in 1 to 7 loop 
                    rom_out<= std_logic_vector(to_unsigned(i,8));
                    ram_out<= std_logic_vector(to_unsigned(i,8));
                    wait for TIME_DELAY;
                end loop;
        end process;
        
end architecture;