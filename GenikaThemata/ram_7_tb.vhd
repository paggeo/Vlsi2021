library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity ram_7_tb is 
    end entity;

architecture bench of ram_7_tb is 
    component ram_7  is
        generic (
            data_width : integer := 8;
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
    end component;
    constant data_width : integer:= 8;
    constant ram_depth : integer := 4096;
    constant ram_addr : integer := 12;

    signal clock ,reset , ce ,rw : std_logic;
    signal addr  :  std_logic_vector(ram_addr-1 downto 0 );
    signal data_in : std_logic_vector(data_width-1 downto 0 );
    signal data_out : std_logic_vector(data_width-1 downto 0);

    constant CLOCK_PERIOD : time := 10 ns;

    begin 
        ram: ram_7 
            generic map (data_width => data_width , ram_depth => ram_depth , ram_addr => ram_addr)
            port map (clock , reset,ce , rw, addr,data_in,data_out);
            
        simulation : process
            begin 
                reset <= '1'; 
                wait for 10 ns;

                reset <= '0';

                ce <= '1';
                rw <= '1';
                addr    <= std_logic_vector(to_unsigned(0,ram_addr)) ;
                
                wait for 5 ns;
                data_in <=  std_logic_vector(to_unsigned(5,data_width)) ;
                wait for 10 ns;

                addr    <= std_logic_vector(to_unsigned(1,ram_addr)) ;
                wait for 5 ns;
                data_in <=  std_logic_vector(to_unsigned(8,data_width)) ;
                wait for 10 ns;

                addr    <= std_logic_vector(to_unsigned(2,ram_addr)) ;
                wait for 5 ns;
                data_in <=  std_logic_vector(to_unsigned(7,data_width)) ;
                wait for 10 ns;

                addr    <= std_logic_vector(to_unsigned(3,ram_addr)) ;
                wait for 5 ns;
                data_in <=  std_logic_vector(to_unsigned(10,data_width)) ;
                wait for 10 ns;
                ce<= '0';
                data_in <=  std_logic_vector(to_unsigned(0,data_width)) ;
                wait for 45 ns;
                ce <= '1';
                rw <= '0';
                

                addr    <= std_logic_vector(to_unsigned(0,ram_addr)) ;
                wait for 10 ns;

                addr    <= std_logic_vector(to_unsigned(1,ram_addr)) ;
                wait for 10 ns;

                addr    <= std_logic_vector(to_unsigned(2,ram_addr)) ;
                wait for 10 ns;

                addr    <= std_logic_vector(to_unsigned(3,ram_addr)) ;
                wait for 20 ns;
                
                ce <= '0';
                wait ;
                
        end process;

        generate_clock : process
            begin
                clock <= '0';
                wait for CLOCK_PERIOD/2;
                clock <= '1';
                wait for CLOCK_PERIOD/2;
        end process;
end architecture;