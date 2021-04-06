library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;


entity rom is
	 generic (
		coeff_width : integer :=8  				--- width of coefficients (bits)
	 );
    port ( 
        clk : in std_logic;
		en : in std_logic;				--- operation enable
        addr : in std_logic_vector (2 downto 0);			-- memory address
        rom_out : out std_logic_vector (coeff_width-1 downto 0));	-- output data
end rom;

architecture behavioral of rom is

    type rom_type is array (7 downto 0) of std_logic_vector (coeff_width-1 downto 0);                 
    signal rom : rom_type:= (
            "00001000", 
            "00000111", 
            "00000110", 
            "00000101", 
            "00000100", 
            "00000011", 
            "00000010",
            "00000001");               

    signal rdata : std_logic_vector(coeff_width-1 downto 0) := (others => '0');
begin

    rdata <= rom(conv_integer(addr));

    process (clk)
    begin
        if rising_edge(clk) then
            if (en = '1') then
                rom_out <= rdata;
            end if;
        end if;
    end process;			


end behavioral;

