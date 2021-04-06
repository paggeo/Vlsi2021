library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity rom_tb is 
    end entity;

architecture bench of rom_tb is
    component rom is
        generic (
           coeff_width : integer :=8 
        );
       port ( 
           clk : in  STD_LOGIC;
           en : in  STD_LOGIC;			
           addr : in  STD_LOGIC_VECTOR (2 downto 0);			
           rom_out : out  STD_LOGIC_VECTOR (coeff_width-1 downto 0));	
   end component;

   constant TIME_DELAY : time := 50 ns;
   constant CLOCK_PERIOD : time := 10 ns;

   signal clk ,en : std_logic ;
   signal addr : std_logic_vector(2 downto 0);
   signal rom_out : std_logic_vector(7 downto 0);

   begin 

        rom1: rom 
            generic map (coeff_width => 8)
            port map (clk,en,addr,rom_out);

        simulation :process 
            begin 
                en <= '1';
                for i in 0 to 7 loop
                    addr <= std_logic_vector(to_unsigned(i, 3));
                    wait for TIME_DELAY;
                    end loop;

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