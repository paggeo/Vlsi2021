library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity dec3to8_behavioral is
port(	
	dec_in :	in std_logic_vector(2 downto 0);
	dec_out :	out std_logic_vector(7 downto 0);
	e :in std_logic 
);
end dec3to8_behavioral;

-------------------------------------------------

architecture behavioral_arch of dec3to8_behavioral is
begin

   

    process (dec_in,e)
    begin
       
       if  e ='1' then
       	case dec_in is
	    	when "000" => dec_out <= "00000001";
	    	when "001" => dec_out <= "00000010";
	    	when "010" => dec_out <= "00000100";
	    	when "011" => dec_out <= "00001000";
	    	when "100" => dec_out <= "00010000";
	    	when "101" => dec_out <= "00100000";
	    	when "110" => dec_out <= "01000000";
	    	when "111" => dec_out <= "10000000";
	    	when others => dec_out <= "--------";
		end case;
		else 
			dec_out <= "00000000";
		end if ;

        

    end process;
	
end architecture;
