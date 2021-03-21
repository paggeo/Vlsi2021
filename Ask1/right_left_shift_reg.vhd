library IEEE;
use IEEE.std_logic_1164.all;


entity right_left_shift_reg is
    port (
    clk,rst,en,pl: in std_logic;
    new_bit :in std_logic;
    right_or_left : in std_logic;
    din: in std_logic_vector(3 downto 0);
    output_bit: out std_logic
);
end right_left_shift_reg;

architecture behavioral_arch of right_left_shift_reg is

    signal reg_bits: std_logic_vector(3 downto 0);
    
    begin
        edge: process (clk,rst)
            begin
                if rst='0' then
                    reg_bits<=(others=>'0');
                elsif clk'event and clk='1' then
                        if pl='1' then
                            reg_bits <= din;
                        elsif en='1' then
                            case right_or_left is 
                                when '0'=>  output_bit <= reg_bits(0);
                                            reg_bits <= new_bit & reg_bits(3 downto 1);
                                            
                                            
                                            
                                when '1'=>  output_bit <= reg_bits(3);
                                            reg_bits <= reg_bits(2 downto 0) & new_bit;
                                            
                                            
                                when others =>   reg_bits <="XXXX";
                                
                                end case;

                        end if;
                end if;
                
            
        end process;

        
                
        

end behavioral_arch;