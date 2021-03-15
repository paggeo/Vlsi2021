library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;


entity counter_up_down_3bit is
port( 
    clk, resetn , count_en : in std_logic;
    add_or_sub : in std_logic;
    sum : out std_logic_vector(2 downto 0);
    cout : out std_logic
    );
end entity;

architecture behavioral_arch of counter_up_down_3bit is
    signal count : std_logic_vector(2 downto 0);
    begin
        process(clk, resetn)
        
        begin
            if resetn='0' then
            -- Ασύγχρονος μηδενισμός
                count <= (others=>'0');
            elsif clk'event and clk='1' then

                    if count_en = '1' then
                    -- Μέτρηση μόνο αν count_en=’1’
                        case add_or_sub is 
                        when '0' =>
                            if count/=7 then
                                -- Αυξάνουμε το μετρητή μόνο αν
                                -- δεν είναι 7
                                    count <= count+1;
                                    cout <= '0' ;
                                else
                                    -- Αλλιώς τον μηδενίζουμε
                                    count<=(others=>'0');
                                    cout <= '1' ;
                                end if;
                        when '1'=>
                            if count/=0 then
                                -- Μειώνουμε το μετρητή μόνο αν
                                -- δεν είναι 0
                                    count <= count-1;
                                    cout <= '0' ;
                                else
                                    -- Αλλιώς τον κάνουμε 7
                                    count<=(others=>'1');
                                    cout <= '1' ;
                                end if;
                        when others =>
                                count <= (others => '-');
                                cout <= '-';
                        end case;
                    end if;
            end if;
        end process;
        sum<= count;
end architecture;