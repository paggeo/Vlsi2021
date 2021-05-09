-------------------------------------------------------------------------------
-- File Downloaded from http://www.nandland.com
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use STD.textio.all;
use ieee.std_logic_textio.all;
 
entity test_tb is
 
end test_tb;
 
 
architecture behave of test_tb is
 
  -----------------------------------------------------------------------------
  -- Declare the Component Under Test
  -----------------------------------------------------------------------------
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
 
  -----------------------------------------------------------------------------
  -- Testbench Internal Signals
  -----------------------------------------------------------------------------
  file file_VECTORS : text;
  file file_RESULTS : text;
  

  constant TIME_DELAY : time := 10 ns;

  signal clock , reset,pixel_valid_in, pixel_valid_out,image_finished,new_image: std_logic;
  signal pixel_din , r,g,b : std_logic_vector(7 downto 0);
 
 
   
begin
 
  -----------------------------------------------------------------------------
  -- Instantiate and Map UUT
  -----------------------------------------------------------------------------

 
 
  ---------------------------------------------------------------------------
  -- This procedure reads the file input_vectors.txt which is located in the
  -- simulation project area.
  -- It will read the data in and send it to the ripple-adder component
  -- to perform the operations.  The result is written to the
  -- output_results.txt file, located in the same directory.
  ---------------------------------------------------------------------------

  module : image 
            generic map (Pixel_width=>8,N=>32)
            port map (clock,reset,pixel_din,pixel_valid_in,new_image,image_finished,pixel_valid_out,r,g,b);

  process
    variable v_ILINE     : line;
    variable v_OLINE     : line;
    
    variable v_SPACE     : character;
    
    variable v_ADD_TERM1 : integer;
    variable v_ADD_TERM2 : integer;
    variable N1:integer;
 
     
  begin
 
    file_open(file_VECTORS, "/home/georgepag4028/Desktop/Sxoli/Vlsi2021/Ask4/source.txt",  read_mode);
    file_open(file_RESULTS, "/home/georgepag4028/Desktop/Sxoli/Vlsi2021/Ask4/target.txt", write_mode);

    readline(file_VECTORS, v_ILINE);
    read(v_ILINE, N1);


    readline(file_VECTORS,v_ILINE);
    read(v_ILINE,v_ADD_TERM1);
    read(v_ILINE, v_SPACE);

                reset<='1';

                wait for 15 ns;

                reset<='0';
                new_image <= '1';
                pixel_valid_in <= '1';

                pixel_din <= std_logic_vector(to_unsigned(v_ADD_TERM1,8));
                wait for TIME_DELAY;

                new_image <= '0';
    for i in 1 to (N1-1) loop
        read(v_ILINE,v_ADD_TERM1);
        read(v_ILINE, v_SPACE);
        pixel_din <= std_logic_vector(to_unsigned(v_ADD_TERM1,8));
        wait for TIME_DELAY;
    end loop;


 
    while not endfile(file_VECTORS) loop
      readline(file_VECTORS, v_ILINE);

      for i in 0 to (N1-1) loop 
        read(v_ILINE,v_ADD_TERM1);
        read(v_ILINE, v_SPACE);
        pixel_din <= std_logic_vector(to_unsigned(v_ADD_TERM1,8));
        

        if pixel_valid_out = '1' then 
        
            write(v_OLINE, to_integer(unsigned(r)));
            write(v_OLINE, v_SPACE);
            write(v_OLINE, to_integer(unsigned(g)));
            write(v_OLINE, v_SPACE);
            write(v_OLINE, to_integer(unsigned(b)));
            write(v_OLINE, v_SPACE);
            writeline(file_RESULTS, v_OLINE);

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
        write(v_OLINE, to_integer(unsigned(r)));
        write(v_OLINE, v_SPACE);
        write(v_OLINE, to_integer(unsigned(g)));
        write(v_OLINE, v_SPACE);
        write(v_OLINE, to_integer(unsigned(b)));
        write(v_OLINE, v_SPACE);
        writeline(file_RESULTS, v_OLINE);
        wait for 10 ns;

    end loop;

   
    
    file_close(file_VECTORS);
    file_close(file_RESULTS);
    
     
    wait;
    
  end process;

  generate_clock : process
            begin
                clock <= '0';
                wait for TIME_DELAY/2;
                clock <= '1';
                wait for TIME_DELAY/2;
            end process;
 
end behave;