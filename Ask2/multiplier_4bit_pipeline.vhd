library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multiplier_4bit_pipeline is 
    port (
        A,B :in std_logic_vector(3 downto 0);
        S :out std_logic_vector (7 downto 0);
        clock : in std_logic
    );
end entity;

architecture structural of multiplier_4bit_pipeline is 
    component full_adder_numeric is 
        port (
            a,b,cin :in std_logic_vector(0 downto 0);
            sum,carry : out STD_LOGIC 
        );
    end component ;

    signal s0,s1,s2,s3 : std_logic_vector(3 downto 0);
    signal c_temp :std_logic_vector(7 downto 0);
    signal sum1_temp , carry1_temp,sum2_temp , carry2_temp : std_logic_vector(5 downto 0);
    signal c1_var , c2_var :std_logic_vector(2 downto 0);
    signal c_var : std_logic_vector(4 downto 0);
    signal s1_var , s2_var :std_logic_vector(5 downto 0);

begin
proc11 :  process (B)

begin
if B(2) = '0' then 
    s2 <= "0000";
else
     s2 <= A;
end if;

if B(0) = '0' then 
    s0 <= "0000";
else 
    s0 <= A;
end if;

if B(1) = '0' then 
    s1 <= "0000";
else 
    s1 <= A;
end if;



if B(3) = '0' then 
    s3 <= "0000";
else
     s3 <= A;
end if;

end process ;

process (clock)
    begin 

          if rising_edge(clock) then 
               
               
               c1_var(0) <= carry1_temp(0);
               c1_var(1) <= carry1_temp(1);
               c1_var(2) <= carry1_temp(2);
               c2_var(0) <= carry2_temp(0);
               c2_var(1) <= carry2_temp(1);
               c2_var(2) <= carry2_temp(2);
               c_var(0) <= c_temp(0);
               c_var(1) <= c_temp(1);
               c_var(2) <= c_temp(2);
               c_var(3) <= c_temp(3);
               c_var(4) <= c_temp(4);
               s1_var(0) <= sum1_temp(0);
               s1_var(1) <= sum1_temp(1);
               s1_var(2) <= sum1_temp(2);
               s1_var(3) <= sum1_temp(3);
               s1_var(4) <= sum1_temp(4);
               s1_var(5) <= sum1_temp(5);
               s2_var(0) <= sum2_temp(0);
               s2_var(1) <= sum2_temp(1);
               s2_var(2) <= sum2_temp(2);
               s2_var(3) <= sum2_temp(3);
               s2_var(4) <= sum2_temp(4);
               s2_var(5) <= sum2_temp(5);

               
          end if;
    end process;

sum1_temp(0) <= s0(0);

FA1 : full_adder_numeric port map (a(0)=>s0(1),b(0) =>s1(0),cin(0) =>'0',sum =>sum1_temp(1),carry =>carry1_temp(0));
FA2 : full_adder_numeric port map (a(0)=>s0(2),b(0) =>s1(1),cin(0) =>c1_var(0),sum =>sum1_temp(2),carry =>carry1_temp(1));
FA3 : full_adder_numeric port map (a(0)=>s0(3),b(0) =>s1(2),cin(0) =>c1_var(1),sum =>sum1_temp(3),carry =>carry1_temp(2));
FA4 : full_adder_numeric port map (a(0)=>'0',b(0) =>s1(3),cin(0) =>c1_var(2),sum =>sum1_temp(4),carry =>sum1_temp(5));

sum2_temp(0)  <= s2(0);

FA5 : full_adder_numeric port map (a(0)=>s2(1),b(0) =>s3(0),cin(0) =>'0',sum =>sum2_temp(1),carry =>carry2_temp(0));
FA6 : full_adder_numeric port map (a(0)=>s2(2),b(0) =>s3(1),cin(0) =>c2_var(0),sum =>sum2_temp(2),carry =>carry2_temp(1));
FA7 : full_adder_numeric port map (a(0)=>s2(3),b(0) =>s3(2),cin(0) =>c2_var(1),sum =>sum2_temp(3),carry =>carry2_temp(2));
FA8 : full_adder_numeric port map (a(0)=>'0',b(0) =>s3(3),cin(0) =>c2_var(2),sum =>sum2_temp(4),carry =>sum2_temp(5));


S(0) <= s1_var(0);
S(1) <= s1_var(1);

FA9 : full_adder_numeric port map (a(0)=>s1_var(2),b(0) =>s2_var(0),cin(0) =>'0',sum =>S(2),carry =>c_temp(0));
FA10 : full_adder_numeric port map (a(0)=>s1_var(3),b(0) =>s2_var(1),cin(0) =>c_var(0),sum =>S(3),carry =>c_temp(1));
FA11 : full_adder_numeric port map (a(0)=>s1_var(4),b(0) =>s2_var(2),cin(0) =>c_var(1),sum =>S(4),carry =>c_temp(2));
FA12 : full_adder_numeric port map (a(0)=>s1_var(5),b(0) =>s2_var(3),cin(0) =>c_var(2),sum =>S(5),carry =>c_temp(3));
FA13 : full_adder_numeric port map (a(0)=>'0',b(0) =>s2_var(4),cin(0) =>c_var(3),sum =>S(6),carry =>c_temp(4));
FA14 : full_adder_numeric port map (a(0)=>'0',b(0) =>s2_var(5),cin(0) =>c_var(4),sum =>S(7),carry =>c_temp(5));


   
end architecture;