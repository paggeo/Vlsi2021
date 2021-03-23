library IEEE;
Use IEEE. STD_LOGIC_1164.all;

ENTITY flipflop IS
     PORT ( 
         d, clock,reset : IN STD_LOGIC ;
        q : OUT STD_LOGIC) ;
END flipflop ;

ARCHITECTURE Behavior_1 OF flipflop IS
BEGIN
    PROCESS 
    BEGIN
          WAIT UNTIL rising_edge(clock); 
            if reset = '1' then 
                q <= '0';
            else 
                 
                 q <= d ;
                
            end if;
       
    END PROCESS ;
END Behavior_1 ;