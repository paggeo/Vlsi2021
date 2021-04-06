library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ram is
	 generic (
		data_width : integer :=8  				            --- width of data (bits)
	 );
    port (
        clk  : in std_logic;
        rst  : in std_logic;
        we   : in std_logic;				                --- memory write enable
		en   : in std_logic;				                --- operation enable
        addr : in std_logic_vector(2 downto 0);			    --- memory address
        di   : in std_logic_vector(data_width-1 downto 0);	-- input data
        do   : out std_logic_vector(data_width-1 downto 0));-- output data
end ram;

architecture behavioral of ram is

    type ram_type is array (7 downto 0) of std_logic_vector (data_width-1 downto 0);
    signal RAM : ram_type := (others => (others => '0'));
	 
begin

            
    process (clk,rst)
    begin
        if (rst = '1') then 
            RAM <= (others => (others => '0'));
        else 

            if rising_edge(clk) then
                if en = '1' then
                    if we = '1' then	
                                    -- write operation with rotation
                        RAM(7) <= RAM(6);
                        RAM(6) <= RAM(5);
                        RAM(5) <= RAM(4);
                        RAM(4) <= RAM(3);
                        RAM(3) <= RAM(2);
                        RAM(2) <= RAM(1);
                        RAM(1) <= RAM(0);
                        RAM(0) <= di;
                        do <= di;
                    else						-- read operation
                        do <= RAM( conv_integer(addr));
                    end if;
                end if;
            end if;
        end if;
    end process;


end architecture;

