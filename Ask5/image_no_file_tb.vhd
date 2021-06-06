library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use STD.textio.all;
use ieee.std_logic_textio.all;

entity image_no_file_tb is 

end entity;

architecture bench of image_no_file_tb is 

    component image is
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
    end component;



    constant TIME_DELAY : time := 10 ns;

    signal clock , reset,pixel_valid_in, pixel_valid_out,image_finished,new_image: std_logic;
    signal pixel_din , r,g,b : std_logic_vector(7 downto 0);
    
    file file_VECTORS : text;
    file file_RESULTS : text;

    begin

     module : image 
            generic map (Pixel_width=>8,N=>8)
            port map (clock,reset,pixel_din,pixel_valid_in,new_image,image_finished,pixel_valid_out,r,g,b);

        simulation: process 
            begin 
                reset<='1';

                wait for 10 ns;

                reset<='0';
                wait for 5 ns;
                new_image <= '1';
                pixel_valid_in <= '1';

                pixel_din <= std_logic_vector(to_unsigned(1,8));
                wait for TIME_DELAY;

                new_image <= '0';
                
                for i in 2 to 32 loop
                    pixel_din <= std_logic_vector(to_unsigned(i,8));
                    wait for TIME_DELAY;
                 end loop;
                    
                  pixel_valid_in<='0';
                  pixel_din <= std_logic_vector(to_unsigned(0,8));
                  wait for 10 ns ;
                                   
                  pixel_valid_in<='1';
                  
                  for i in 33 to 64 loop
                    pixel_din<=std_logic_vector(to_unsigned(i,8));
                    wait for TIME_DELAY;
                    
                   end loop;
                                
                    
                   
                --for j in 0 to (1024*4) loop
                    --for i in 0 to 255 loop 
                        --pixel_din <= std_logic_vector(to_unsigned(i,8));
                        --wait for TIME_DELAY;
                    --end loop;
                --end loop;

                pixel_valid_in <= '0';
                pixel_din <= std_logic_vector(to_unsigned(0,8));
               
                wait ;
            end process;

        generate_clock : process
            begin
                clock <= '0';
                wait for TIME_DELAY/2;
                clock <= '1';
                wait for TIME_DELAY/2;
            end process;

end architecture;