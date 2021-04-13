library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity filter_paraller is 
    port (
        clk : in std_logic;
        rst : in std_logic;
        valid_in : in std_logic;
        x_in_1 : in std_logic_vector(7 downto 0);
        x_in_2 : in std_logic_vector(7 downto 0);
        valid_out : out std_logic;
        y_out_1 : out std_logic_vector(18 downto 0);
        y_out_2 : out std_logic_vector(18 downto 0)
        );
end filter_paraller;

architecture behavioral of filter_paraller is 

    signal x_inter1,x_inter2,x_inter3,x_inter4,x_inter5,x_inter6,x_inter7 : std_logic_vector(7 downto 0):=(others=>'0');
    signal coef1: std_logic_vector(7 downto 0):="00000001";
    signal coef2: std_logic_vector(7 downto 0):="00000010";
    signal coef3: std_logic_vector(7 downto 0):="00000011";
    signal coef4: std_logic_vector(7 downto 0):="00000100";
    signal coef5: std_logic_vector(7 downto 0):="00000101";
    signal coef6: std_logic_vector(7 downto 0):="00000110";
    signal coef7: std_logic_vector(7 downto 0):="00000111";
    signal coef8: std_logic_vector(7 downto 0):="00001000";
    signal x1_mult1,x1_mult2,x1_mult3,x1_mult4,x1_mult5,x1_mult6,x1_mult7 , x1_mult8: std_logic_vector(15 downto 0):=(others=>'0');
    signal x2_mult1,x2_mult2,x2_mult3,x2_mult4,x2_mult5,x2_mult6,x2_mult7 , x2_mult8: std_logic_vector(15 downto 0):=(others=>'0');
    signal x1_temp1_2 ,x1_temp3_4 , x1_temp5_6 , x1_temp7_8 : std_logic_vector(18 downto 0):=(others=>'0');
    signal x1_temp1_4 ,x1_temp5_8 : std_logic_vector(18 downto 0):=(others=>'0');
    signal x2_temp1_2 ,x2_temp3_4 , x2_temp5_6 , x2_temp7_8 : std_logic_vector(18 downto 0):=(others=>'0');
    signal x2_temp1_4 ,x2_temp5_8 : std_logic_vector(18 downto 0):=(others=>'0');
    signal valid_in_inter1, valid_in_inter2, valid_in_inter3 : std_logic := '0';

    begin 
        process (clk , rst , valid_in)
            begin 
                if (rising_edge(clk)) then
                    if (rst ='1') then 
                        x_inter7 <= "00000000";
                        x_inter6 <= "00000000";
                        x_inter5 <="00000000";
                        x_inter4 <= "00000000";
                        x_inter3 <= "00000000";
                        x_inter2 <= "00000000";
                        x_inter1 <="00000000";
                        x1_mult1 <= "0000000000000000";
                        x2_mult1<= "0000000000000000";
                        x2_mult2<= "0000000000000000";
                        valid_in_inter1 <= '0';
                        
                    else
                        if (valid_in = '1') then
                            x1_mult1 <= "00000000"&x_in_1;
                            x2_mult1 <= "00000000"&x_in_2;
                            x2_mult2 <= "0000000"&x_in_1&"0";
                            x_inter7 <= x_inter5;
                            x_inter6 <= x_inter4;
                            x_inter5 <= x_inter3;
                            x_inter4 <= x_inter2;
                            x_inter3 <= x_inter1;
                            x_inter2 <= x_in_1;
                            x_inter1 <= x_in_2;
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
                    x1_mult2 <= coef2 * x_inter1;
                    x1_mult3 <= coef3 * x_inter2;
                    x1_mult4 <= coef4 * x_inter3;
                    x1_mult5 <= coef5 * x_inter4;
                    x1_mult6 <= coef6 * x_inter5;
                    x1_mult7 <= coef7 * x_inter6;
                    x1_mult8 <= coef8 * x_inter7;

                    x2_mult3 <= coef3 * x_inter1;
                    x2_mult4 <= coef4 * x_inter2;
                    x2_mult5 <= coef5 * x_inter3;
                    x2_mult6 <= coef6 * x_inter4;
                    x2_mult7 <= coef7 * x_inter5;
                    x2_mult8 <= coef8 * x_inter6;
                
                    x1_temp1_2 <= ("000"&x1_mult1) + ("000"&x1_mult2);
                    x1_temp3_4 <= ("000"&x1_mult3) + ("000"&x1_mult4);
                    x1_temp5_6 <= ("000"&x1_mult5) + ("000"&x1_mult6);
                    x1_temp7_8 <= ("000"&x1_mult7) + ("000"&x1_mult8);
                    x1_temp1_4 <= x1_temp1_2 + x1_temp3_4;
                    x1_temp5_8 <= x1_temp5_6 + x1_temp7_8;
                    y_out_1 <= x1_temp1_4 + x1_temp5_8;

                    x2_temp1_2 <= ("000"&x2_mult1) + ("000"&x2_mult2);
                    x2_temp3_4 <= ("000"&x2_mult3) + ("000"&x2_mult4);
                    x2_temp5_6 <= ("000"&x2_mult5) + ("000"&x2_mult6);
                    x2_temp7_8 <= ("000"&x2_mult7) + ("000"&x2_mult8);
                    x2_temp1_4 <= x2_temp1_2 + x2_temp3_4;
                    x2_temp5_8 <= x2_temp5_6 + x2_temp7_8;
                    y_out_2 <= x2_temp1_4 + x2_temp5_8;
                   
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