library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity dec3to8_dataflow is
port(	
	dec_in :	in std_logic_vector(2 downto 0);
	dec_out :	out std_logic_vector(7 downto 0)
);
end dec3to8_dataflow;


architecture dataflow_arch of dec3to8_dataflow is
begin
	with dec_in select dec_out <=
		"00000001" when "000",
		"00000010" when "001",
		"00000100" when "010",
		"00001000" when "011",
		"00010000" when "100",
		"00100000" when "101",
		"01000000" when "110",
		"10000000" when "111",
		"--------" when others;
end dataflow_arch;


