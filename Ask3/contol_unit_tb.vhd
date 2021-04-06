library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity control_unit_tb is 
    end entity;

architecture bench  of control_unit_tb is

    component control_unit is
        port (
            clk : in std_logic;
            rst : in std_logic;
            rom_address : out std_logic_vector(2 downto 0);
            ram_address : out std_logic_vector (2 downto 0);
            mac_init : out std_logic
            );
    end component;

    signal clk , rst : std_logic;
    signal rom_address, ram_address : std_logic_vector(2 downto 0);
    signal mac_init : std_logic;

    constant TIME_DELAY : time := 50 ns;
    constant CLOCK_PERIOD : time := 10 ns;

    begin   
        control_unit1 : control_unit 
            port map (clk,rst,rom_address,ram_address,mac_init);

        simulation : process 
            begin 
                rst <= '0';
                wait;
        end process;

        generate_clock : process
            begin
                clk <= '0';
                wait for CLOCK_PERIOD/2;
                clk <= '1';
                wait for CLOCK_PERIOD/2;
        end process;
    end architecture;
