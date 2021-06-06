library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity master_slave is 
    port(
        clock: in std_logic;
        reset: in std_logic;

        T_data_in : in std_logic_vector(7 downto 0);
        T_valid_in : in std_logic;
        T_last_in : in std_logic;
        T_ready_out : out std_logic;

        T_data_out : out std_logic_vector(31 downto 0);
        T_valid_out : out std_logic;
        T_last_out : out std_logic;
        T_ready_in : in std_logic
        
    );
end entity ;

architecture behavioral of master_slave  is 
    component arm_image is
        generic (
            Pixel_width : natural := 8 ;
            N : integer  
        );
        port(
            clock: in std_logic;
            reset: in std_logic;

            pixel_din : in std_logic_vector(Pixel_width-1 downto 0);
            pixel_valid_in : in std_logic;

            image_finished : out std_logic;
            pixel_valid_out : out std_logic;
            T_ready_in : in std_logic;

            r : out std_logic_vector (7 downto 0);
            g : out std_logic_vector (7 downto 0); 
            b : out std_logic_vector (7 downto 0)
        );
    end component;

    COMPONENT fifo_generator_2048_32_no_lat
        PORT (
        clk : IN STD_LOGIC;
        srst : IN STD_LOGIC;
        din : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        wr_en : IN STD_LOGIC;
        rd_en : IN STD_LOGIC;
        dout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        full : OUT STD_LOGIC;
        empty : OUT STD_LOGIC;
        valid : OUT STD_LOGIC;
        data_count : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
        );
    END COMPONENT;

    signal si_T_last_out,si_T_valid_out : std_logic_vector(0 downto 0);

    signal tmp_reset : std_logic;

    signal tmp_din : std_logic_vector(7 downto 0);
    
    signal si_r,si_g,si_b : std_logic_vector(7 downto 0);
    signal si_T_ready_in : std_logic;
 
    

    signal counter : std_logic_vector(5 downto 0):=(others=>'0');

    signal fifo_data_in,fifo_data_out : std_logic_vector(31 downto 0);
    signal fifo_wr,fifo_rd : std_logic:='0';

    signal test_r,test_g,test_b : std_logic_vector(7 downto 0);
    signal empty : std_logic;
  
    
    begin
        module : arm_image
            generic map (Pixel_width=>8,N=>4)
            port map (
                clock=>clock,
                reset=>reset,
                
                pixel_din=>tmp_din,
                pixel_valid_in=>T_valid_in,

                image_finished =>si_T_last_out(0),
                pixel_valid_out=>si_T_valid_out(0),
                T_ready_in => T_ready_in,

                r =>    si_r,
                g =>    si_g,
                b =>    si_b
            );

        fifo_0 : fifo_generator_2048_32_no_lat
            PORT MAP (clock,reset,fifo_data_in,fifo_wr,fifo_rd,fifo_data_out,open,empty,open,open);

        process (clock,reset)
            begin 
                if rising_edge(clock) then 
                    fifo_data_in <= si_T_valid_out(0) & si_T_last_out(0) & "000000" & si_r & si_g & si_b;
                end if;
        end process;
        
       process(clock,reset)
            begin 
                if rising_edge(clock) then 
                    T_ready_out<=T_ready_in;
                    tmp_din <=T_data_in ;
                end if;
        end process;

        process(clock,reset)
            begin 
                 
                if T_ready_in = '1' then 
                    fifo_rd <= '1' ;
                else fifo_rd <= '0';
                end if;

                    
                if fifo_data_in(31) = '1' then 
                    fifo_wr <= '1';
                else fifo_wr <= '0';
                end if;
                
        end process;

        process (clock,reset)
            begin 
                if rising_edge(clock) then
                    if empty = '1' then 
                        T_data_out <= std_logic_vector(to_unsigned(0,32));
                        T_valid_out <= '0';
                        T_last_out <= '0';
                        test_r  <= std_logic_vector(to_unsigned(0,8));
                        test_g  <= std_logic_vector(to_unsigned(0,8));
                        test_b  <= std_logic_vector(to_unsigned(0,8));
                    else
                        T_data_out <= "00"&fifo_data_out(29 downto 0);
                        if T_ready_in = '0' then 
                            T_valid_out <= '0';
                            T_last_out <= '0';
                        else 
                            T_valid_out <= fifo_data_out(31);
    
                             
                                T_last_out <= fifo_data_out(30);
                            
                        end if;
                        test_r  <= fifo_data_out(23 downto 16);
                        test_g  <= fifo_data_out(15 downto 8);
                        test_b  <= fifo_data_out(7 downto 0);
                    end if;
                end if;
        end process;    

end architecture;