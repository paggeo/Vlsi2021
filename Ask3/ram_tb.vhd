library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity ram_tb is 
    end entity;

architecture bench  of ram_tb is
    component ram is
        generic (
           data_width : integer :=8  				            --- width of data (bits)
        );
       port (
           clk  : in std_logic;
           we   : in std_logic;				                --- memory write enable
           en   : in std_logic;				                --- operation enable
           addr : in std_logic_vector(2 downto 0);			    --- memory address
           di   : in std_logic_vector(data_width-1 downto 0);	-- input data
           do   : out std_logic_vector(data_width-1 downto 0));-- output data
   end component;

   signal clk,we,en : std_logic;
   signal addr : std_logic_vector(2 downto 0);
   signal di : std_logic_vector(7 downto 0);
   signal do : std_logic_vector(7 downto 0);

   constant TIME_DELAY : time := 50 ns;
   constant CLOCK_PERIOD : time := 10 ns;

   begin 
        ram1 : ram 
            generic map (data_width=>8)
            port map (clk,we,en,addr,di,do);

        simulation: process 
            begin
                en <= '1';
                we <= '1';
                addr <=(others => '0' );
                
                for  i in 0 to 7 loop

                    di <= std_logic_vector(to_unsigned(i,8));
                    wait for CLOCK_PERIOD;
                    end loop;

                we <= '0' ;
                wait for TIME_DELAY ;

                for  i in 0 to 7 loop

                    di <= std_logic_vector(to_unsigned(i,8));
                    wait for CLOCK_PERIOD;
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