library IEEE;
Use IEEE. STD_LOGIC_1164.all;

entity full_adder_sq IS
port (
      a,b,cin :in STD_LOGIC;
      sum,carry : out STD_LOGIC;
      clock,reset : in STD_LOGIC
      );
end entity;

architecture structural of full_adder_sq is





component half_adder is
port (
      a,b :in STD_LOGIC;
      sum,carry: out STD_LOGIC
      );
end component;

 signal in_d1,out_q1: std_logic;
 signal in_d2,out_q2: std_logic;
 signal n_clock,n_reset : std_logic;
 signal output_sum,output_carry: std_logic;
 
 signal s1,c1,c2 : STD_LOGIC;

begin

w1: half_adder port map (
            a => a,
            b => b,
            sum => s1, 
            carry => c1
            );
      w2: half_adder port map (
            a => s1,
            b => cin, 
            sum => output_sum,
            carry => c2
            );
      output_carry <= c1 or c2;


process (clock,reset)
begin 

    if rising_edge(clock) then
        
        if reset = '1' then 
            sum <= '0';
            carry <= '0';
         else 
            sum <= output_sum;
            carry <= output_carry;
    
        end if; 
    end if;


end process ;
    
end architecture;

