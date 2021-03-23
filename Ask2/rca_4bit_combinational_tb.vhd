library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rca_4bit_combinational_tb IS
end entity;

architecture bench of rca_4bit_combinational_tb IS

    component rca_4bit_combinational
        port (
            a,b :in std_logic_vector(3 downto 0);
            cin : in std_logic;
            s : out std_logic_vector(3 downto 0);
            cout : out std_logic
        );
    end component;

    --Inputs
    signal a : std_logic_vector(3 downto 0) := (others => '0');
    signal b : std_logic_vector(3 downto 0) := (others => '0');
    signal cin : std_logic := '0';
    
    --Outputs
    signal s : std_logic_vector(3 downto 0);
    signal cout : std_logic;

    constant TIME_DELAY : time := 10 ns;
    
    begin 
        module: rca_4bit_combinational 
            port map (
                a=> a,
                b=>b,
                cin=> cin,
                s => s,
                cout => cout
            );
        simulation : process
            begin 

                for i   in 0 to 15 loop
                    for j  in 0 to 15 loop
                       for k in std_logic range '0' to '1' loop
                            a <= std_logic_vector(to_unsigned(i, 4));
                            b <= std_logic_vector(to_unsigned(j, 4));
                            cin <= k ;
                            wait for TIME_DELAY ;
                        end loop;
                    end loop;
                end loop;

        wait;
    end process;
end architecture;
        
