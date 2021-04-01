library IEEE;
Use IEEE. STD_LOGIC_1164.all;

entity generic_latch is
    generic(N:integer :=2);
     port ( 
        d : in std_logic_vector (N-1 downto 0);
        clock,reset : in std_logic ;
        q : out std_logic_vector(N-1 downto 0)) ;
end entity ;

architecture behavioral OF generic_latch is
begin
    process 
    begin
          wait until rising_edge(clock); 
            if reset = '1' then 
                q <= (others =>'0');
            else 
                 
                 q <= d ;
                
            end if;
       
    end process ;
end architecture ;