library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rca_4bit_pipeline_test IS
port (
    a,b :in std_logic_vector(3 downto 0);
    cin , clock: in std_logic;
    s : out std_logic_vector(3 downto 0);
    cout : out std_logic
);
end entity;

architecture structural of rca_4bit_pipeline_test is
    component full_adder_numeric
        port (
            a,b,cin :in std_logic_vector(0 downto 0);
            sum,carry : out STD_LOGIC
        );

    end component;

    component generic_latch is
        generic(N:integer :=2);
         port ( 
            d : in std_logic_vector (N-1 downto 0);
            clock,reset : in std_logic ;
            q : out std_logic_vector(N-1 downto 0)) ;
    end component ;
    
    signal c1,c2,c3: STD_LOGIC;
    signal s0_0,s0_1,s0_2 :std_logic;
    signal s1_0_a,s1_0_b,s1_1,s1_2 : std_logic;
    signal s2_0_a,s2_0_b,s2_1_a,s2_1_b,s2_2 :std_logic;
    signal s3_0_a,s3_0_b,s3_1_a,s3_1_b,s3_2_a,s3_2_b :std_logic;
    signal c1_reg ,c2_reg,c3_reg :std_logic;

    begin
       
        FA0:full_adder_numeric port map (
                    a(0)=>a(0),
                    b(0) => b(0),
                    cin(0) => cin,
                    sum => s0_0,
                    carry => c1
                );

        latch0: generic_latch
            generic map (N=>8)
            port map (d(0) => s0_0,d(1)=>c1,d(2)=>a(1),d(3)=>b(1),d(4)=>a(2),d(5)=>b(2),d(6)=>a(3),d(7)=>b(3),clock=>clock,reset=>'0',
                q(0) => s0_1,q(1)=>c1_reg,q(2)=>s1_0_a,q(3)=>s1_0_b,q(4)=>s2_0_a,q(5)=>s2_0_b,q(6)=>s3_0_a,q(7)=>s3_0_b);
             
              
        FA1:full_adder_numeric port map (
                a(0)=>s1_0_a,
                b(0) => s1_0_b,
                cin(0) => c1_reg,
                sum => s1_1 ,
                carry => c2
            );

        latch1: generic_latch
            generic map (N=>7)
            port map (d(0) => s0_1,d(1)=>s1_1,d(2)=>c2,d(3)=>s2_0_a,d(4)=>s2_0_b,d(5)=>s3_0_a,d(6)=>s3_0_b,clock=>clock,reset=>'0',
                q(0) => s0_2,q(1)=>s1_2,q(2)=>c2_reg,q(3)=>s2_1_a,q(4)=>s2_1_b,q(5)=>s3_1_a,q(6)=>s3_1_b);

        FA2:full_adder_numeric port map (
                a(0)=>s2_1_a,
                b(0) => s2_1_b,
                cin(0) => c2_reg,
                sum => s2_2 ,
                carry => c3
            );

        latch2: generic_latch
            generic map (N=>6)
            port map (d(0) => s0_2,d(1)=>s1_2,d(2)=>s2_2,d(3)=>c3,d(4)=>s3_1_a,d(5)=>s3_1_b,clock=>clock,reset=>'0',
                q(0) => s(0),q(1)=>s(1),q(2)=>s(2),q(3)=>c3_reg,q(4)=>s3_2_a,q(5)=>s3_2_b);

        FA3:full_adder_numeric port map (
                a(0)=>s3_2_a,
                b(0) => s3_2_b,
                cin(0) => c3_reg,
                sum => s(3),
                carry => cout
            );
            
          
    end architecture;
    