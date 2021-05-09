library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity test is
    generic (
        Pixel_width : natural := 8 
    );
    port(
        clock: in std_logic;
        reset: in std_logic;
        pixel_din : in std_logic_vector(Pixel_width-1 downto 0);
        pixel_valid_in : in std_logic;

        wr_en : in std_logic;
        rd_en : in std_logic;

        pixel_valid_out : out std_logic;

        pixel_dout_000 : out std_logic_vector (7 downto 0);
        pixel_dout_100 : out std_logic_vector (7 downto 0); 
        pixel_dout_200 : out std_logic_vector (7 downto 0) 

        

    );
end entity;

architecture behavioral of test  is 

    COMPONENT fifo_generator_0
    PORT (
        clk : IN STD_LOGIC;
        srst : IN STD_LOGIC;
        din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        wr_en : IN STD_LOGIC;
        rd_en : IN STD_LOGIC;
        dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        full : OUT STD_LOGIC;
        empty : OUT STD_LOGIC;
        valid : OUT STD_LOGIC;
        data_count : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
    END COMPONENT;
    signal full,empty : std_logic;
    signal data_count : std_logic_vector(3 downto 0);

    signal    pixel_dout_00 :  std_logic_vector (7 downto 0);
    signal    pixel_dout_01 :  std_logic_vector (7 downto 0);
    signal    pixel_dout_02 :  std_logic_vector (7 downto 0);
    signal    pixel_dout_10 :  std_logic_vector (7 downto 0);
    signal    pixel_dout_11 :  std_logic_vector (7 downto 0);
    signal    pixel_dout_12 :  std_logic_vector (7 downto 0);
    signal    pixel_dout_20 :  std_logic_vector (7 downto 0);
    signal    pixel_dout_21 :  std_logic_vector (7 downto 0);
    signal    pixel_dout_22 :  std_logic_vector (7 downto 0);

    begin  
    process(clock,reset)
        begin 
            if rising_edge(clock) then 
                pixel_dout_000<=pixel_dout_02;
                pixel_dout_02<=pixel_dout_01;
                pixel_dout_01<=pixel_dout_00;

                pixel_dout_100<=pixel_dout_12;
                pixel_dout_12<=pixel_dout_11;
                pixel_dout_11<=pixel_dout_10;

                pixel_dout_200<=pixel_dout_22;
                pixel_dout_22<=pixel_dout_21;
                pixel_dout_21<=pixel_dout_20;
            end if;

    end process;

    fifo_0 : fifo_generator_0
    PORT MAP (
        clk => clock,
        srst => reset,
        din => pixel_din,
        wr_en => wr_en,
        rd_en => rd_en,
        dout => pixel_dout_00,
        full => full,
        empty => empty,
        valid => pixel_valid_out,
        data_count => data_count
    );

    fifo_1 : fifo_generator_0
    PORT MAP (
        clk => clock,
        srst => reset,
        din => pixel_dout_00,
        wr_en => wr_en,
        rd_en => rd_en,
        dout => pixel_dout_10,
        full => full,
        empty => empty,
        valid => pixel_valid_out,
        data_count => data_count
    );

    fifo_2 : fifo_generator_0
    PORT MAP (
        clk => clock,
        srst => reset,
        din => pixel_dout_10,
        wr_en => wr_en,
        rd_en => rd_en,
        dout => pixel_dout_20,
        full => full,
        empty => empty,
        valid => pixel_valid_out,
        data_count => data_count
    );

    end architecture;