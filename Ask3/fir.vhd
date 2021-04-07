library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity fir is 
    port(
        clk , rst : in std_logic;
        valid_in : in std_logic;
        x : in std_logic_vector(7 downto 0);
        y : out std_logic_vector(18 downto 0);
        valid_out : out std_logic
    );
end entity;

architecture structural of fir is 
    component control_unit is 
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
    end component;

    component rom is
        generic (
           coeff_width : integer :=8
        );
       port ( 
           clk : in std_logic;
           en : in std_logic;
           addr : in std_logic_vector (2 downto 0);
           rom_out : out std_logic_vector (coeff_width-1 downto 0));	
   end component;

   component ram is
        generic (
        data_width : integer :=8 
        );
    port (
        clk  : in std_logic;
        rst  : in std_logic;
        we   : in std_logic;
        en   : in std_logic;
        addr : in std_logic_vector(2 downto 0);	
        di   : in std_logic_vector(data_width-1 downto 0);
        do   : out std_logic_vector(data_width-1 downto 0));
    end component;

    component mac is 
        generic (
            data_width : integer := 8
        );
        port (
            clk:std_logic;
            rst:std_logic;
            rom_out : in std_logic_vector(data_width-1 downto 0);
            ram_out : in std_logic_vector(data_width-1 downto 0);
            mac_init : in std_logic;
            y : out std_logic_vector(data_width*2+2 downto 0);
            valid_out : out std_logic

        );
    end component;



    signal rom_address_control_unit: std_logic_vector(2 downto 0);
    signal ram_address_control_unit: std_logic_vector(2 downto 0);
    signal mac_init_control_unit: std_logic;
    signal ram_out_ram : std_logic_vector(7 downto 0);
    signal rom_out_rom : std_logic_vector(7 downto 0);
    signal en_control_unit,we_control_unit :std_logic;
    signal mac_init_temp : std_logic;


begin 
    process (clk)
    begin
        if rising_edge(clk) then
            mac_init_temp <= mac_init_control_unit;
        end if;
    end process;
    
    control_unit_module : control_unit
        port map(clk,rst,valid_in,rom_address_control_unit,ram_address_control_unit,mac_init_control_unit,we_control_unit,en_control_unit);
    rom_module : rom
        generic map(coeff_width => 8)
        port map (clk,en_control_unit,rom_address_control_unit,rom_out_rom);
    ram_module : ram 
        generic map (data_width => 8)
        port map (clk,rst,we_control_unit,en_control_unit,ram_address_control_unit,x,ram_out_ram);
        
    mac_module : mac
        generic map (data_width => 8)
        port map (clk,rst,rom_out_rom,ram_out_ram,mac_init_temp,y,valid_out);
   end architecture;
