library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity fir is 
    port (
        clk : in std_logic;
        rst : in std_logic;
        valid_in : in std_logic;
        x_in : in std_logic_vector(7 downto 0);
        valid_out : out std_logic;
        y_out : out std_logic_vector(18 downto 0)
        );
end entity;

architecture behavioral of fir is 

    signal x_inter1,x_inter2,x_inter3,x_inter4,x_inter5,x_inter6,x_inter7,x_inter8 : std_logic_vector(7 downto 0):=(others=>'0');
    signal coef1: std_logic_vector(7 downto 0):="00000001";
    signal coef2: std_logic_vector(7 downto 0):="00000010";
    signal coef3: std_logic_vector(7 downto 0):="00000011";
    signal coef4: std_logic_vector(7 downto 0):="00000100";
    signal coef5: std_logic_vector(7 downto 0):="00000101";
    signal coef6: std_logic_vector(7 downto 0):="00000110";
    signal coef7: std_logic_vector(7 downto 0):="00000111";
    signal coef8: std_logic_vector(7 downto 0):="00001000";
    signal x_mult1,x_mult2,x_mult3,x_mult4,x_mult5,x_mult6,x_mult7 , x_mult8: std_logic_vector(15 downto 0):=(others=>'0');
    signal x_temp1,x_temp2 ,x_temp3,x_temp4,x_temp5,x_temp6,x_temp7,x_temp8  : std_logic_vector(18 downto 0):=(others=>'0');
    signal valid_in_inter1, valid_in_inter2, valid_in_inter3 : std_logic := '0';

    signal x_temp1_2 ,x_temp3_4 , x_temp5_6 , x_temp7_8 : std_logic_vector(18 downto 0):=(others=>'0');
    signal x_temp1_4 ,x_temp5_8 : std_logic_vector(18 downto 0):=(others=>'0');

    begin 
        process (clk , rst , valid_in)
            begin 
                if (rising_edge(clk)) then
                    if (rst ='1') then 
                        x_inter8 <= (others => '0');
                        x_inter7 <= (others => '0');
                        x_inter6 <= (others => '0');
                        x_inter5 <=(others => '0');
                        x_inter4 <= (others => '0');
                        x_inter3 <= (others => '0');
                        x_inter2 <= (others => '0');
                        x_inter1 <=(others => '0');
                        valid_in_inter1 <= '0';
                        --x_mult1 <= (others => '0');
                    else
                        if (valid_in = '1') then
                            
                            x_inter8 <= x_inter7;
                            x_inter7 <= x_inter6;
                            x_inter6 <= x_inter5;
                            x_inter5 <= x_inter4;
                            x_inter4 <= x_inter3;
                            x_inter3 <= x_inter2;
                            x_inter2 <= x_inter1;
                            x_inter1 <= x_in;
                            valid_in_inter1 <= valid_in;
                         else 
                           valid_in_inter1 <= valid_in; 
                        end if;
                    end if;
                end if;
        end process;

        process (clk)
            begin
                if (rising_edge(clk)) then
                    x_mult1 <= coef1 * x_inter1;
                    x_mult2 <= coef2 * x_inter2;
                    x_mult3 <= coef3 * x_inter3;
                    x_mult4 <= coef4 * x_inter4;
                    x_mult5 <= coef5 * x_inter5;
                    x_mult6 <= coef6 * x_inter6;
                    x_mult7 <= coef7 * x_inter7;
                    x_mult8 <= coef8 * x_inter8;
                    
                    x_temp1_2 <= ("000"&x_mult1) + ("000"&x_mult2);
                    x_temp3_4 <= ("000"&x_mult3) + ("000"&x_mult4);
                    x_temp5_6 <= ("000"&x_mult5) + ("000"&x_mult6);
                    x_temp7_8 <= ("000"&x_mult7) + ("000"&x_mult8);
                    x_temp1_4 <= x_temp1_2 + x_temp3_4;
                    x_temp5_8 <= x_temp5_6 + x_temp7_8;
                    y_out <= x_temp1_4 + x_temp5_8;

                end if;
        end process;


         process (clk)
            begin
                if (rising_edge(clk)) then
                    valid_out <= valid_in_inter3;
                    valid_in_inter3 <= valid_in_inter2;
                    valid_in_inter2 <= valid_in_inter1;                          
                end if;
        end process;
end architecture;   
