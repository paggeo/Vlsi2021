library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity image is
    generic (
        Pixel_width : natural := 8 ;
        N : integer  
    );
    port(
        clock: in std_logic;
        reset: in std_logic;

        pixel_din : in std_logic_vector(Pixel_width-1 downto 0);
        pixel_valid_in : in std_logic;
        new_image : in std_logic;

        image_finished : out std_logic;
        pixel_valid_out : out std_logic;

        r : out std_logic_vector (7 downto 0);
        g : out std_logic_vector (7 downto 0); 
        b : out std_logic_vector (7 downto 0) 
    );
end entity;

architecture behavioral of image  is 

    COMPONENT fifo_generator_1024
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
        data_count : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
    );
    END COMPONENT;

    signal data_count0,data_count1,data_count2 : std_logic_vector(9 downto 0);

    signal    pixel_dout_00 :  std_logic_vector (7 downto 0);
    signal    pixel_dout_01 :  std_logic_vector (7 downto 0);
    signal    pixel_dout_02 :  std_logic_vector (7 downto 0);
    signal    pixel_dout_10 :  std_logic_vector (7 downto 0);
    signal    pixel_dout_11 :  std_logic_vector (7 downto 0);
    signal    pixel_dout_12 :  std_logic_vector (7 downto 0);
    signal    pixel_dout_20 :  std_logic_vector (7 downto 0);
    signal    pixel_dout_21 :  std_logic_vector (7 downto 0);
    signal    pixel_dout_22 :  std_logic_vector (7 downto 0);


    signal wr_en0,wr_en1,wr_en2,rd_en0,rd_en1,rd_en2 : std_logic;

    signal cycle_counter : std_logic_vector(15 downto 0);
    signal i_counter, j_counter : std_logic_vector (15 downto 0);

    signal temp0,temp1,temp2,temp3,temp5,temp6 :   std_logic_vector (7 downto 0);

    signal itemp,jtemp,itemp2,jtemp2 : std_logic_vector (15 downto 0);

    signal B_00,B_01,B_02,B_10,B_11,B_12,B_20,B_21,B_22 :  std_logic_vector (7 downto 0);
    
    signal gtemp0        : std_logic_vector(7 downto 0);
    signal btemp0,rtemp0 : std_logic_vector(8 downto 0);

    signal gtemp1,rtemp1 : std_logic_vector(9 downto 0);
    signal btemp1        : std_logic_vector(7 downto 0);
    

    signal gtemp2,btemp2 : std_logic_vector(9 downto 0);
    signal rtemp2        : std_logic_vector(7 downto 0);

    signal gtemp3        : std_logic_vector(7 downto 0);
    signal btemp3,rtemp3 : std_logic_vector(8 downto 0);
    
    

    begin  
    
    fifo_0 : fifo_generator_1024
        PORT MAP (clock,reset,pixel_din,wr_en0,rd_en0,temp0,open,open,open,data_count0);
            

    fifo_1 : fifo_generator_1024
        PORT MAP (clock,reset,temp0,wr_en1,rd_en1,temp5,open,open,open,data_count1);
        

    fifo_2 : fifo_generator_1024
        PORT MAP (clock,reset,temp5,wr_en2,rd_en2,pixel_dout_20,open,open,open,data_count2);

    process(clock,reset)
        begin 
            if rising_edge(clock) then 

                if reset = '1' then 
                    cycle_counter <= (others =>'0');
                    i_counter <= (others=> '0');
                    j_counter <= (others=> '0');
                    image_finished <= '0';
                    pixel_valid_out <= '0';
                    wr_en0 <= '0';
                    wr_en1 <= '0';
                    wr_en2 <= '0';
                    rd_en0 <= '0';
                    rd_en1 <= '0';
                    rd_en2 <= '0';

                elsif new_image = '1' and pixel_valid_in = '1' then 
                    cycle_counter <= (others =>'0');
                    i_counter <= (others=> '0');
                    j_counter <= (others=> '0');
                    image_finished <= '0';
                    pixel_valid_out <= '0';
                    wr_en0 <= '1';
                    wr_en1 <= '0';
                    wr_en2 <= '0';
                    rd_en0 <= '0';
                    rd_en1 <= '0';
                    rd_en2 <= '0';

                elsif (new_image='0' and pixel_valid_in = '1') or (cycle_counter /= 0) then

                    cycle_counter <= cycle_counter + 1;
                    if cycle_counter >=N+N+7 then 
                        if j_counter = N-1 then 
                            j_counter<= (others => '0');
                            i_counter <=i_counter+1;
                        else j_counter <= j_counter+1;
                        end if;

                        if cycle_counter = N*N+N+N+6 then 
                            i_counter <= (others=>'0');
                            j_counter <= (others=>'0');
                        end if;
                    end if;

                    if cycle_counter = N*N+N+N+6 then 
                        i_counter <= (others=>'0');
                        j_counter <= (others=>'0');
                    end if;
                
                    if cycle_counter = N*N+N+N+8 then 
                        image_finished <= '1';
                        pixel_valid_out <= '1';
                        cycle_counter <= (others=>'0');
                    end if;

                    if cycle_counter >= N+N+9 then 
                        pixel_valid_out <= '1';
                    else pixel_valid_out <= '0';
                    end if;
                    

                    if cycle_counter = N-1 then 
                        rd_en0 <= '1';
                    end if; 

                    if cycle_counter = N+1 then 
                        wr_en1 <= '1';
                    end if;
                    if cycle_counter = N+N+1 then 
                        rd_en1 <= '1';
                    end if; 

                    if cycle_counter = N+N+3 then 
                        wr_en2 <= '1';
                    end if;
                    if cycle_counter = N+N+N+3 then 
                        rd_en2 <= '1';
                    end if; 
        
                else 
                    cycle_counter <= (others=>'0');
                    image_finished <= '0';
                    pixel_valid_out <= '0';

                end if;
                

               
        end if;
    end process;

    process(clock,reset)
        begin 
        if rising_edge(clock) then 

            pixel_dout_02<=pixel_dout_01;
            pixel_dout_01<=pixel_dout_00;

            pixel_dout_00<= temp3;
            temp3 <= temp2;
            temp2<=temp1;
            temp1<=temp0;

            pixel_dout_12<=pixel_dout_11;
            pixel_dout_11<=pixel_dout_10;

            pixel_dout_10<=temp6;
            temp6<=temp5;

            pixel_dout_22<=pixel_dout_21;
            pixel_dout_21<=pixel_dout_20;

            itemp2<=itemp;
            jtemp2<=jtemp;

            itemp <= i_counter;
            jtemp <= j_counter;
        end if;
                  
    end process;

    process(clock,reset)
        begin 
            if rising_edge(clock) then

                    B_00 <= pixel_dout_00;
                    B_01 <= pixel_dout_01;
                    B_02 <= pixel_dout_02;
                    B_10 <= pixel_dout_10;
                    B_11 <= pixel_dout_11;
                    B_12 <= pixel_dout_12;
                    B_20 <= pixel_dout_20;
                    B_21 <= pixel_dout_21;
                    B_22 <= pixel_dout_22;

                if j_counter = 0 then 

                    B_02 <= (others=>'0');
                    B_12 <= (others=>'0');
                    B_22 <= (others=>'0');
                elsif j_counter = N-1 then
                    B_00 <= (others=>'0');
                    B_10 <= (others=>'0');
                    B_20 <= (others=>'0');

                end if;
                
                if i_counter = 0 then 

                    B_20 <= (others=>'0');
                    B_21 <= (others=>'0');
                    B_22 <= (others=>'0');
                elsif i_counter = N-1 then
                    B_00 <= (others=>'0');
                    B_01 <= (others=>'0');
                    B_02 <= (others=>'0');
                    
                end if;
            end if;
    end process;

    process (clock,reset)
        begin 
            if rising_edge(clock) then 

                    if itemp(0) = '0' and jtemp(0)='0' then --gb
                        gtemp0 <= B_11;
                        btemp0 <= ('0'&B_10)+('0'&B_12);
                        rtemp0 <= ('0'&B_01)+('0'&B_21);

                    elsif itemp(0)='0' and jtemp(0)='1' then --blue
                        btemp1<=B_11;
                        gtemp1<=("00"&B_10)+("00"&B_12)+("00"&B_01)+("00"&B_21);
                        rtemp1<=("00"&B_00)+("00"&B_02)+("00"&B_20)+("00"&B_22);

                    elsif itemp(0)='1' and jtemp(0)='0' then --red
                        rtemp2<=B_11;
                        gtemp2<=("00"&B_10)+("00"&B_12)+("00"&B_01)+("00"&B_21);
                        btemp2<=("00"&B_00)+("00"&B_02)+("00"&B_20)+("00"&B_22);

                    else --rg
                        gtemp3 <= B_11;
                        rtemp3 <= ('0'&B_10)+('0'&B_12);
                        btemp3 <= ('0'&B_01)+('0'&B_21);
                        
                    end if;

            end if;        
        end process;
    process (clock,reset)
        begin 
            if rising_edge(clock) then 

                if cycle_counter >= N+N+9 then 

                    if itemp2(0) = '0' and jtemp2(0)='0' then --gb
                        g<=gtemp0;
                        b<=btemp0(8 downto 1);
                        r<=rtemp0(8 downto 1);

                    elsif itemp2(0)='0' and jtemp2(0)='1' then --blue
                        b<=btemp1;
                        g<=gtemp1(9 downto 2);
                        r<=rtemp1(9 downto 2);

                    elsif itemp2(0)='1' and jtemp2(0)='0' then --red
                        r<=rtemp2;
                        g<=gtemp2(9 downto 2);
                        b<=btemp2(9 downto 2);

                    else --rg
                        g<=gtemp3;
                        b<=btemp3(8 downto 1);
                        r<=rtemp3(8 downto 1);
                    end if;
                    
                else 
                    r<=(others =>'0');
                    g<=(others =>'0');
                    b<=(others =>'0');
                end if;
            end if;        
        end process;

    end architecture;