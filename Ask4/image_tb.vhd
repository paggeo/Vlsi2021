library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use STD.textio.all;
use ieee.std_logic_textio.all;
 
entity image_tb is
end image_tb;
 
architecture bench of image_tb is

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
 
  file file_source : text;
  file file_target : text;

  constant TIME_DELAY : time := 10 ns;

  signal clock , reset,pixel_valid_in, pixel_valid_out,image_finished,new_image: std_logic;
  signal pixel_din , r,g,b : std_logic_vector(7 downto 0);
   
    begin
        module : image 
                generic map (Pixel_width=>8,N=>64) -- You have to change this to the desire N size
                port map (clock,reset,pixel_din,pixel_valid_in,new_image,image_finished,pixel_valid_out,r,g,b);

    process
        variable input_line      : line;
        variable output_line     : line;
        
        variable space_char     : character;
        
        variable input_integer : integer;
        variable N:integer;
        
    begin
        -- Change this files to the selected path
        file_open(file_source, "/home/georgepag4028/Desktop/Sxoli/Vlsi2021/Ask4/source.txt", read_mode);
        file_open(file_target, "/home/georgepag4028/Desktop/Sxoli/Vlsi2021/Ask4/target.txt", write_mode);

        readline(file_source, input_line);
        read(input_line, N);


        readline(file_source,input_line);
        read(input_line,input_integer);
        read(input_line, space_char);

            reset<='1';

            wait for 15 ns;

            reset<='0';
            new_image <= '1';
            pixel_valid_in <= '1';

            pixel_din <= std_logic_vector(to_unsigned(input_integer,8));
            wait for TIME_DELAY;

            new_image <= '0';

        for i in 1 to (N-1) loop
            read(input_line,input_integer);
            read(input_line, space_char);
            pixel_din <= std_logic_vector(to_unsigned(input_integer,8));
            wait for TIME_DELAY;
        end loop;
    
        while not endfile(file_source) loop
        readline(file_source, input_line);

        for i in 0 to (N-1) loop 
            read(input_line,input_integer);
            read(input_line, space_char);
            pixel_din <= std_logic_vector(to_unsigned(input_integer,8));

            if pixel_valid_out = '1' then 
                write(output_line, to_integer(unsigned(r)));
                write(output_line, space_char);
                write(output_line, to_integer(unsigned(g)));
                write(output_line, space_char);
                write(output_line, to_integer(unsigned(b)));
                write(output_line, space_char);
                writeline(file_target, output_line);
            end if;

            wait for 10 ns;  
        
        end loop;
        end loop;

        pixel_valid_in <= '0';
        pixel_din <= std_logic_vector(to_unsigned(0,8));

        while pixel_valid_out = '0' loop 
            wait for 1 ns;
        end loop;

        while (pixel_valid_out = '1') loop
            write(output_line, to_integer(unsigned(r)));
            write(output_line, space_char);
            write(output_line, to_integer(unsigned(g)));
            write(output_line, space_char);
            write(output_line, to_integer(unsigned(b)));
            write(output_line, space_char);
            writeline(file_target, output_line);
            wait for 10 ns;

        end loop;
    
        file_close(file_source);
        file_close(file_target);
        
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