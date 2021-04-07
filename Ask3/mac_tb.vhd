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
            clk :in std_logic;
            rst : in std_logic;
            rom_out : in std_logic_vector(data_width-1 downto 0);
            ram_out : in std_logic_vector(data_width-1 downto 0);
            mac_init : in std_logic;
            y : out std_logic_vector(data_width*2+2 downto 0);
            valid_out : out std_logic 

        );
    end component;

    signal clk,rst:std_logic;
    signal mac_init : std_logic;
    signal rom_out,ram_out : std_logic_vector(7 downto 0);
    signal y : std_logic_vector(18 downto 0);
    signal valid_out : std_logic;

    constant TIME_DELAY : time :=10 ns;
    constant CLOCK_PERIOD : time := 10 ns;

    begin 
        mac1 : mac 
            generic map ( data_width=> 8)
            port map (clk,rst,rom_out,ram_out,mac_init,y,valid_out);

        simulation: process 
            begin 
                rst<='0';
                mac_init<= '1';
                rom_out<= std_logic_vector(to_unsigned(15,8));
                ram_out<= std_logic_vector(to_unsigned(15,8));
                wait for TIME_DELAY;
                mac_init <= '0';

                for i in 0 to 7 loop 
                    rom_out<= std_logic_vector(to_unsigned(i,8));
                    ram_out<= std_logic_vector(to_unsigned(1,8));
                    wait for TIME_DELAY;
                end loop;
        end process;

        generate_clock : process
            begin
                clk <= '0';
                wait for CLOCK_PERIOD/2;
                clk <= '1';
                wait for CLOCK_PERIOD/2;
            end process;
        
end architecture;