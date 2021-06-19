-- Ram 4096x8 bit --
-- Homework number 7 general issues--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ram_7 is
  generic (
    data_width : integer := 4;
    ram_depth : integer := 4;
    ram_addr  : integer := 2
  );
  port (
    clock       : in std_logic;
    reset       : in std_logic;
    ce          : in std_logic;
    rw          : in std_logic;
    addr        : in std_logic_vector(ram_addr - 1 downto 0);
    data_in     : in std_logic_vector(data_width - 1 downto 0);
    data_out    : out std_logic_vector(data_width - 1 downto 0)
  ) ;
end entity;

architecture behavioral of ram_7 is 
    
    type ram_type is array (0 to ram_depth - 1) of 
            std_logic_vector(data_width-1 downto 0);
    
    signal RAM: ram_type := (others => (others => '0'));
    signal tmp_addr : std_logic_vector(ram_addr - 1 downto 0);

    begin 

        process(clock,reset)
            begin 
                if reset = '1' then 
                    RAM <= (others => (others => '0'));
                else 
                    if ce = '1' then 
                        if rising_edge(clock) then 
                            tmp_addr <= addr;
                        end if;
                        if falling_edge(clock) then 
                            if rw = '1' then 
                                RAM(conv_integer(tmp_addr)) <= data_in;
                            else 
                                data_out <= RAM(conv_integer(tmp_addr));
                            end if;
                        end if;
                    else 
                        data_out <= (others=>'0');
                    end if;
                end if;
        end process;
end architecture;