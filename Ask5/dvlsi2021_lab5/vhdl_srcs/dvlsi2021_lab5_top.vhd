library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dvlsi2021_lab5_top is
  port (
        DDR_cas_n         : inout STD_LOGIC;
        DDR_cke           : inout STD_LOGIC;
        DDR_ck_n          : inout STD_LOGIC;
        DDR_ck_p          : inout STD_LOGIC;
        DDR_cs_n          : inout STD_LOGIC;
        DDR_reset_n       : inout STD_LOGIC;
        DDR_odt           : inout STD_LOGIC;
        DDR_ras_n         : inout STD_LOGIC;
        DDR_we_n          : inout STD_LOGIC;
        DDR_ba            : inout STD_LOGIC_VECTOR( 2 downto 0);
        DDR_addr          : inout STD_LOGIC_VECTOR(14 downto 0);
        DDR_dm            : inout STD_LOGIC_VECTOR( 3 downto 0);
        DDR_dq            : inout STD_LOGIC_VECTOR(31 downto 0);
        DDR_dqs_n         : inout STD_LOGIC_VECTOR( 3 downto 0);
        DDR_dqs_p         : inout STD_LOGIC_VECTOR( 3 downto 0);
        FIXED_IO_mio      : inout STD_LOGIC_VECTOR(53 downto 0);
        FIXED_IO_ddr_vrn  : inout STD_LOGIC;
        FIXED_IO_ddr_vrp  : inout STD_LOGIC;
        FIXED_IO_ps_srstb : inout STD_LOGIC;
        FIXED_IO_ps_clk   : inout STD_LOGIC;
        FIXED_IO_ps_porb  : inout STD_LOGIC
       );
end entity; -- dvlsi2021_lab5_top

architecture arch of dvlsi2021_lab5_top is

  component design_1_wrapper is
    port (
          DDR_cas_n         : inout STD_LOGIC;
          DDR_cke           : inout STD_LOGIC;
          DDR_ck_n          : inout STD_LOGIC;
          DDR_ck_p          : inout STD_LOGIC;
          DDR_cs_n          : inout STD_LOGIC;
          DDR_reset_n       : inout STD_LOGIC;
          DDR_odt           : inout STD_LOGIC;
          DDR_ras_n         : inout STD_LOGIC;
          DDR_we_n          : inout STD_LOGIC;
          DDR_ba            : inout STD_LOGIC_VECTOR( 2 downto 0);
          DDR_addr          : inout STD_LOGIC_VECTOR(14 downto 0);
          DDR_dm            : inout STD_LOGIC_VECTOR( 3 downto 0);
          DDR_dq            : inout STD_LOGIC_VECTOR(31 downto 0);
          DDR_dqs_n         : inout STD_LOGIC_VECTOR( 3 downto 0);
          DDR_dqs_p         : inout STD_LOGIC_VECTOR( 3 downto 0);
          FIXED_IO_mio      : inout STD_LOGIC_VECTOR(53 downto 0);
          FIXED_IO_ddr_vrn  : inout STD_LOGIC;
          FIXED_IO_ddr_vrp  : inout STD_LOGIC;
          FIXED_IO_ps_srstb : inout STD_LOGIC;
          FIXED_IO_ps_clk   : inout STD_LOGIC;
          FIXED_IO_ps_porb  : inout STD_LOGIC;
          --------------------------------------------------------------------------
          ----------------------------------------------- PL (FPGA) COMMON INTERFACE
          ACLK                                : out STD_LOGIC;
          ARESETN                             : out STD_LOGIC_VECTOR(0 to 0);
          ------------------------------------------------------------------------------------
          -- PS2PL-DMA AXI4-STREAM MASTER INTERFACE TO ACCELERATOR AXI4-STREAM SLAVE INTERFACE
          M_AXIS_TO_ACCELERATOR_tdata         : out STD_LOGIC_VECTOR(7 downto 0);
          M_AXIS_TO_ACCELERATOR_tkeep         : out STD_LOGIC_VECTOR( 0    to 0);
          M_AXIS_TO_ACCELERATOR_tlast         : out STD_LOGIC;
          M_AXIS_TO_ACCELERATOR_tready        : in  STD_LOGIC;
          M_AXIS_TO_ACCELERATOR_tvalid        : out STD_LOGIC;
          ------------------------------------------------------------------------------------
          -- ACCELERATOR AXI4-STREAM MASTER INTERFACE TO PL2P2-DMA AXI4-STREAM SLAVE INTERFACE
          S_AXIS_S2MM_FROM_ACCELERATOR_tdata  : in  STD_LOGIC_VECTOR(31 downto 0);
          S_AXIS_S2MM_FROM_ACCELERATOR_tkeep  : in  STD_LOGIC_VECTOR( 3 downto 0);
          S_AXIS_S2MM_FROM_ACCELERATOR_tlast  : in  STD_LOGIC;
          S_AXIS_S2MM_FROM_ACCELERATOR_tready : out STD_LOGIC;
          S_AXIS_S2MM_FROM_ACCELERATOR_tvalid : in  STD_LOGIC
         );
  end component design_1_wrapper;
  
  --Arm-Image--
  component master_slave is 
    port(
        clock: in std_logic;
        reset : in std_logic;
        
        T_data_in : in std_logic_vector(7 downto 0);
        T_valid_in : in std_logic;
        T_last_in : in std_logic;
        T_ready_out : out std_logic;
        
        T_data_out : out  std_logic_vector(31 downto 0 );
        T_valid_out : out std_logic;
        T_last_out : out std_logic;
        T_ready_in : in std_logic
    );
    end component master_slave;
    
   component test is 
            port(
                clock: in std_logic;
                reset: in std_logic;
    
                pixel_din : in std_logic_vector(7 downto 0);
                pixel_valid_in : in std_logic;
                
    
                image_finished : out std_logic;
                pixel_valid_out : out std_logic;
                t_ready_in: in std_logic;
                t_ready_out : out std_logic;
    
                pixel_dout : out std_logic_vector(31 downto 0)
            );
        end component ;
-------------------------------------------
-- INTERNAL SIGNAL & COMPONENTS DECLARATION

  signal aclk    : std_logic;
  signal aresetn : std_logic_vector(0 to 0);

  signal tmp_tdata  : std_logic_vector(7 downto 0);
  signal tmp_tlast  : std_logic;
  signal tmp_tvalid : std_logic;
  
  signal tmp_T_data_out : std_logic_vector(31 downto 0);
  signal tmp_T_valid_out : std_logic ;
  signal tmp_T_last_out: std_logic;
  
  signal tmp_tkeep1 : std_logic_vector ( 0 downto 0):= (others => '1');
  signal tmp_tkeep4 : std_logic_vector ( 3 downto 0) := (others =>'1');
  
  signal test_t_ready_out : std_logic := '1';
  signal test_t_ready_in : std_logic;
  
  signal one : std_logic := '1';
  


begin

  PROCESSING_SYSTEM_INSTANCE : design_1_wrapper
    port map (
              DDR_cas_n         => DDR_cas_n,
              DDR_cke           => DDR_cke,
              DDR_ck_n          => DDR_ck_n,
              DDR_ck_p          => DDR_ck_p,
              DDR_cs_n          => DDR_cs_n,
              DDR_reset_n       => DDR_reset_n,
              DDR_odt           => DDR_odt,
              DDR_ras_n         => DDR_ras_n,
              DDR_we_n          => DDR_we_n,
              DDR_ba            => DDR_ba,
              DDR_addr          => DDR_addr,
              DDR_dm            => DDR_dm,
              DDR_dq            => DDR_dq,
              DDR_dqs_n         => DDR_dqs_n,
              DDR_dqs_p         => DDR_dqs_p,
              FIXED_IO_mio      => FIXED_IO_mio,
              FIXED_IO_ddr_vrn  => FIXED_IO_ddr_vrn,
              FIXED_IO_ddr_vrp  => FIXED_IO_ddr_vrp,
              FIXED_IO_ps_srstb => FIXED_IO_ps_srstb,
              FIXED_IO_ps_clk   => FIXED_IO_ps_clk,
              FIXED_IO_ps_porb  => FIXED_IO_ps_porb,
              --------------------------------------------------------------------------
              ----------------------------------------------- PL (FPGA) COMMON INTERFACE
              ACLK                                => aclk,    -- clock to accelerator
              ARESETN                             => aresetn, -- reset to accelerator, active low
              ------------------------------------------------------------------------------------
              -- PS2PL-DMA AXI4-STREAM MASTER INTERFACE TO ACCELERATOR AXI4-STREAM SLAVE INTERFACE
              M_AXIS_TO_ACCELERATOR_tdata         => tmp_tdata,
              M_AXIS_TO_ACCELERATOR_tkeep         => tmp_tkeep1,
              M_AXIS_TO_ACCELERATOR_tlast         => tmp_tlast,
              M_AXIS_TO_ACCELERATOR_tready        => one,
              M_AXIS_TO_ACCELERATOR_tvalid        => tmp_tvalid,
              ------------------------------------------------------------------------------------
              -- ACCELERATOR AXI4-STREAM MASTER INTERFACE TO PL2P2-DMA AXI4-STREAM SLAVE INTERFACE
              S_AXIS_S2MM_FROM_ACCELERATOR_tdata  => tmp_T_data_out,
              S_AXIS_S2MM_FROM_ACCELERATOR_tkeep  => tmp_tkeep4,
              S_AXIS_S2MM_FROM_ACCELERATOR_tlast  => tmp_T_last_out,
              S_AXIS_S2MM_FROM_ACCELERATOR_tready => test_t_ready_in,
              S_AXIS_S2MM_FROM_ACCELERATOR_tvalid => tmp_T_valid_out
             );
             
       Fpga_filter : master_slave
            port map(
                clock       =>aclk,
                reset       =>aresetn(0),
                
                T_data_in   =>tmp_tdata,
                T_valid_in  =>tmp_tvalid,
                T_last_in   =>tmp_tlast,
                T_ready_out => test_t_ready_out,
               
                T_data_out  =>tmp_T_data_out,
                T_valid_out =>tmp_T_valid_out,
                T_last_out  =>tmp_T_last_out,
                T_ready_in   =>test_t_ready_in
            );
            
        --test_filter : test
            --port map (
                --clock =>aclk,
                --reset =>aresetn(0),
                --pixel_din =>tmp_tdata,
                --pixel_valid_in =>tmp_tvalid,
                --image_finished =>tmp_T_last_out,
                --pixel_valid_out =>tmp_T_valid_out,
                --t_ready_in =>test_t_ready_in,
                --t_ready_out =>test_t_ready_out,
                --pixel_dout =>tmp_T_data_out
            --);
---------------------------
-- COMPONENTS INSTANTIATIONS

end architecture; -- arch