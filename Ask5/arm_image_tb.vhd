library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use STD.textio.all;
use ieee.std_logic_textio.all;

entity arm_image_tb is 

end entity;

architecture bench of arm_image_tb is 

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



    constant TIME_DELAY : time := 10 ns;

    signal clock , reset,pixel_valid_in, pixel_valid_out,image_finished,T_ready_in: std_logic;
    signal pixel_din , r,g,b : std_logic_vector(7 downto 0);
    
    file file_VECTORS : text;
    file file_RESULTS : text;

    begin

     module : arm_image 
            generic map (Pixel_width=>8,N=>4)
            port map (clock,reset,pixel_din,pixel_valid_in,image_finished,pixel_valid_out,T_ready_in,r,g,b);

        simulation: process 
            begin 
                

                reset<='0';
                pixel_valid_in <= '1';
                T_ready_in <= '1';
                wait for 5 ns;
                for i in 1 to 16 loop
                    pixel_din <= std_logic_vector(to_unsigned(i,8));
                    wait for TIME_DELAY;
                end loop;

        
            

                pixel_din <= std_logic_vector(to_unsigned(0,8));
                pixel_valid_in <= '0';
                wait for 100 ns ;
                T_ready_in <= '0';

                wait for 10 ns;
                T_ready_in <= '1';
                
                wait;
            end process;

        generate_clock : process
            begin
                clock <= '0';
                wait for TIME_DELAY/2;
                clock <= '1';
                wait for TIME_DELAY/2;
            end process;

end architecture;