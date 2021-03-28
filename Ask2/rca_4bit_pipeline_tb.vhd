library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rca_4bit_pipeline_tb IS
end entity;

architecture bench of rca_4bit_pipeline_tb IS

    component rca_4bit_pipeline
        port (
            a,b :in std_logic_vector(3 downto 0);
            cin , clock: in std_logic;
            s : out std_logic_vector(3 downto 0);
            cout : out std_logic
        );
    end component;

    --Inputs
    signal a : std_logic_vector(3 downto 0) := (others => '0');
    signal b : std_logic_vector(3 downto 0) := (others => '0');
    signal cin : std_logic := '0';
    signal clock : std_logic;
    
    --Outputs
    signal s : std_logic_vector(3 downto 0);
    signal cout : std_logic;

     constant TIME_DELAY : time := 40 ns;
    constant CLOCK_PERIOD : time := 10 ns;

    begin 
    module: rca_4bit_pipeline
        port map (
            a=> a,
            b=>b,
            cin=> cin,
            s => s,
            cout => cout,
            clock => clock
        );
    simulation : process
        begin 

            for i   in 0 to 15 loop
                for j  in 0 to 15 loop
                  
                        a <= std_logic_vector(to_unsigned(i, 4));
                        b <= std_logic_vector(to_unsigned(j, 4));
                        
                        wait for TIME_DELAY ;
                    end loop;
                end loop;
           

    wait;
end process;

generate_clock : process
    begin
    clock <= '0';
    wait for CLOCK_PERIOD/2;
    clock <= '1';
    wait for CLOCK_PERIOD/2;
    end process;

end bench;