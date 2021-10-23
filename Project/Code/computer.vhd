library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity computer is
  Port ( clk : in std_logic;
         AC2  : out unsigned ( 7 downto 0 ) );
end computer;

architecture Behavioral of computer is

signal start_index : std_logic := '1' ;
signal FGI , FGO : std_logic ;

component AR is
    Port ( clk  :   in std_logic; 
           load :   in STD_LOGIC;
           inc :    in STD_LOGIC;
           input  : in  unsigned (9 downto 0);
           output : out unsigned (9 downto 0));
end component;


component AC is
    Port ( clk  :   in std_logic; 
           load :   in STD_LOGIC;
           inc :    in STD_LOGIC;
           rst :    in STD_LOGIC;
           sr  :    in STD_LOGIC;
           sl  :    in STD_LOGIC;
           input  : in  unsigned (7 downto 0);
           output : out unsigned (7 downto 0));
end component;


component ALU is
port ( A      : in  unsigned ( 7 downto 0 );
       B      : in  unsigned ( 7 downto 0 );
       opcode : in  unsigned ( 3 downto 0 );
       cf     : out std_logic;
       zf     : out std_logic;
       O      : out unsigned ( 7 downto 0 )
       );
end component;  

component CF is
    Port ( clk    : in std_logic;
           set    :   in  std_logic;
           output :   out std_logic
           );
end component;

component CR is
    Port ( clk  :   in std_logic; 
           load :   in STD_LOGIC;
           input  : in  unsigned (7 downto 0);
           output : out unsigned (7 downto 0));
end component;

component Dec_2x4 is

    Port ( input          : in  unsigned (1 downto 0);  -- 2-bit input from sequence counter
           output         : out unsigned (3 downto 0)  -- 4-bit output ( O ) to control unit
           );
        
end component;

component Dec_3x8 is

    Port ( input          : in  unsigned (2 downto 0);  -- 3-bit input from sequence counter
           output         : out unsigned (7 downto 0)  -- 8-bit output ( O ) to control unit
           );
        
end component;

component Dec_4x16 is

    Port ( input          : in  unsigned (3 downto 0);  -- 3-bit input from sequence counter
           output         : out unsigned (15 downto 0)  -- 8-bit output ( O ) to control unit
           );
        
end component;

--component F_reg is
--    Port ( clk    :   in  std_logic; 
--           set    :   in  std_logic;
--           reset  :   in  std_logic;
--           output :   out std_logic
--           );
--end component;

--component G_reg is
--    Port ( clk    :   in  std_logic; 
--           set    :   in  std_logic;
--           reset  :   in  std_logic;
--           output :   out std_logic
--           );
--end component;


--component R_reg is
--    Port ( clk    :   in  std_logic; 
--           set    :   in  std_logic;
--           reset  :   in  std_logic;
--           output :   out std_logic
--           );
--end component;


component I0_reg is
    Port ( clk    :   in  std_logic; 
           load   :   in  std_logic;
           input  :   in  std_logic;
           output :   out std_logic
           );
end component;

component I1_reg is
    Port ( clk    :   in  std_logic; 
           load   :   in  std_logic;
           input  :   in  std_logic;
           output :   out std_logic
           );
end component;

component INF is
    Port ( clk    :   in  std_logic; 
           set    :   in  std_logic;
           reset  :   in  std_logic;
           output :   out std_logic
           );
end component;

component INPR is
    Port ( clk  :   in std_logic; 
           load :   in STD_LOGIC;
           input  : in  unsigned (7 downto 0);
           output : out unsigned (7 downto 0));
end component;

component MAR is
    Port ( clk  :   in std_logic; 
           load :   in STD_LOGIC;
           rst :    in STD_LOGIC;
           input  : in  unsigned (9 downto 0);
           output : out unsigned (9 downto 0));
end component;

component MBR is
    Port ( clk  :   in std_logic; 
           load :   in STD_LOGIC;
           inc :    in STD_LOGIC;
           dec :    in STD_LOGIC;
           --rst :    in STD_LOGIC;
           input  : in  unsigned (15 downto 0);
           output1 : out unsigned ( 15 downto 0 );
           output2 : out unsigned (15 downto 0));
end component;

component OPR is
    Port ( clk  :   in std_logic; 
           load :   in STD_LOGIC;
           input  : in  unsigned (3 downto 0);
           output : out unsigned (3 downto 0));
end component;

component OUTR is
    Port ( clk  :   in std_logic; 
           load :   in STD_LOGIC;
           input  : in  unsigned (7 downto 0);
           output : out unsigned (7 downto 0));
end component;

component PC is
    Port ( clk  :   in std_logic; 
           load :   in STD_LOGIC;
           inc :    in STD_LOGIC;
           rst :    in STD_LOGIC;
           input  : in  unsigned (9 downto 0);
           output : out unsigned (9 downto 0));
end component;

component RAM is
    Port ( clk          :  in  STD_LOGIC;
           address      :  in  unsigned (9 downto 0);
           wen          :  in  STD_LOGIC;
           data_in      :  in  unsigned (15 downto 0);
           data_out     :  out unsigned (15 downto 0)
           );
end component;

component ZF is
    Port ( clk    :   in std_logic ;
           set    :   in  std_logic;
           output :   out std_logic
           );
end component;

component inverter is
    Port ( input  : in unsigned (7 downto 0);
           output : out unsigned (7 downto 0));
end component;

component mux_2x1_10bit is
 Port (A : in  unsigned(9 downto 0 );
       B : in  unsigned(9 downto 0 );
       S : in  std_logic;
       O : out unsigned(9 downto 0 )
 );
end component;

component mux_2x1_16bit is
 Port (A : in  unsigned(15 downto 0 );
       B : in  unsigned(15 downto 0 );
       S : in  std_logic;
       O : out unsigned(15 downto 0 )
 );
end component;

component mux_4x1_8bit is
 Port (A : in  unsigned        ( 7 downto 0 );
       B : in  unsigned        ( 7 downto 0 );
       C : in  unsigned        ( 7 downto 0 );
       D : in  unsigned        ( 7 downto 0 );
       S : in  std_logic_vector( 1 downto 0 );
       O : out unsigned        ( 7 downto 0 )
 );
end component;



component sequence_counter is
Port ( clk , reset : in std_logic;
       output      : out unsigned ( 1 downto 0 ));
end component;

 
signal load_AR : std_logic ;
signal inc_AR  : std_logic ;
signal input_AR : unsigned ( 9 downto 0 ) ;
signal output_AR : unsigned ( 9 downto 0 ) ;
signal load_AC : std_logic;
signal inc_AC  : std_logic;
signal rst_AC  : std_logic;
signal sr_AC   : std_logic;
signal sl_AC   : std_logic;
--signal input_AC : unsigned ( 7 downto 0 );
signal output_AC : unsigned ( 7 downto 0 ) ;
 
--signal in1_ALU : unsigned ( 7 downto 0 ) ;
--signal in2_ALU : unsigned ( 7 downto 0 ) ;
--signal op_ALU  : unsigned ( 3 downto 0 ) ;
signal out_ALU : unsigned ( 7 downto 0 ) ;
 
 
signal set_CF : std_logic;
signal out_CF : std_logic;

signal set_ZF : std_logic;
signal out_ZF : std_logic;

signal load_CR : std_logic;
signal input_CR : unsigned ( 7 downto 0 ) ;
signal output_CR : unsigned ( 7 downto 0 ) ;
 
signal input_dec2x4  : unsigned ( 1 downto 0 ) ;
signal T : unsigned ( 3 downto 0 ) ;
 
--signal input_dec3x8  : unsigned ( 2 downto 0 ) ;
--signal output_dec3x8 : unsigned ( 7 downto 0 ) ;
 
--signal input_dec4x16  : unsigned ( 3 downto 0 ) ;
signal Q: unsigned ( 15 downto 0 ) ;
  
--signal set_F : std_logic ;
--signal reset_F : std_logic;
--signal out_F   :std_logic;
  
--signal set_G : std_logic ;
--signal reset_G : std_logic;
--signal out_G   :std_logic;
  
--signal set_R : std_logic ;
--signal reset_R : std_logic;
--signal out_R   :std_logic;
  
--signal input_inv : unsigned( 7 downto 0 ) ;
signal output_inv : unsigned ( 7 downto 0 ) ;
  
--signal in1_mux10 : unsigned ( 9 downto 0 ) ;
--signal in2_mux10 : unsigned ( 9 downto 0 ) ;
signal S_mux10   : std_logic ; 
signal out_mux10 : unsigned ( 9 downto 0 ) ;

--signal in1_mux16 : unsigned ( 15 downto 0 ) ;
--signal in2_mux16 : unsigned ( 15 downto 0 ) ;
signal S_mux16   : std_logic ; 
signal out_mux16 : unsigned ( 15 downto 0 ) ;

--signal in1_mux8 : unsigned ( 7 downto 0 ) ;
--signal in2_mux8 : unsigned ( 7 downto 0 ) ;
--signal in3_mux8 : unsigned ( 7 downto 0 ) ;
signal in4_mux8 : unsigned ( 7 downto 0 ) ;

signal S_mux8   : std_logic_vector( 1 downto 0 ) ; 
signal out_mux8 : unsigned ( 7 downto 0 ) ;
    
signal I0_load : std_logic;
signal I0_input: std_logic;
signal I0_output: std_logic;
   
 
signal I1_load : std_logic;
signal I1_input: std_logic;
signal I1_output: std_logic;

   
signal set_INF : std_logic ;
signal reset_INF : std_logic ;
signal out_INF   : std_logic;
signal load_INPR : std_logic;
signal input_INPR : unsigned(7 downto 0 ) ;
signal out_INPR   :unsigned(7 downto 0 ) ;
    
   
signal load_MBR : std_logic;
signal inc_MBR  : std_logic;
--signal input_MBR : unsigned(15 downto 0 ) ;
signal out1_MBR  :  unsigned(15 downto 0 ) ;
signal out2_MBR  :  unsigned(15 downto 0 ) ;
signal dec_MBR : std_logic ;
     
signal load_MAR : std_logic;
signal rst_MAR  : std_logic;
--signal input_MAR : unsigned(9 downto 0 ) ;
signal out_MAR  :  unsigned(9 downto 0 ) ;
     
signal load_OPR : std_logic;
signal input_OPR : unsigned(3 downto 0 ) ;
signal out_OPR  :  unsigned(3 downto 0 ) ;
signal load_OUTR : std_logic;
signal input_OUTR : unsigned(7 downto 0 ) ;
signal out_OUTR   :unsigned(7 downto 0 ) ;
     
     
     
signal load_PC : std_logic;
signal rst_PC  : std_logic;
signal inc_PC  : std_logic;
signal input_PC : unsigned(9 downto 0 ) ;
signal out_PC  :  unsigned(9 downto 0 ) ;
     
--signal address_ram : unsigned ( 9 downto 0 ) ;
signal wen_ram : std_logic ;
--signal data_in : unsigned ( 15 downto 0 ) ;
signal data_out_ram : unsigned ( 15 downto 0 ) ;

signal reset_counter  : std_logic ;
signal output_counter : unsigned ( 1 downto 0 ) ;

type states is ( s0 , s1 , s2 , s3 , s4 , s5 , s6 , s7 ) ;
signal state : states:= s0;
signal BUSS : unsigned ( 15 downto 0 ) ;

begin

  p1  : AR                port map ( clk , load_AR , inc_AR , input_AR , output_AR );
  p2  : AC                port map ( clk , load_AC , inc_AC , rst_AC , sr_AC , sl_AC , out_mux8 , output_AC ) ;
  p3  : ALU               port map ( BUSS( 7 downto 0 ) , output_AC ,   out_OPR  , set_cf  , set_zf , out_ALU );
  p4  : CF                port map ( set_CF , out_CF ) ; 
  p5  : ZF                port map ( set_ZF , out_ZF ) ;
  p6  : CR                port map ( clk , load_CR , input_CR , output_CR );
  p7  : Dec_2x4           port map ( output_counter , T ) ;
  --p8  : Dec_3x8           port map ( input_dec3x8 , output_dec3x8);
  p9  : Dec_4x16          port map ( out_OPR , Q );
--  p10 : F_reg             port map ( clk , set_F , reset_F , out_F ) ;
--  p11 : G_reg             port map ( clk , set_G , reset_G , out_G ) ;
--  p12 : R_reg             port map ( clk , set_R , reset_R , out_R ) ;
  p13 : inverter          port map ( output_AC , output_inv ) ;
  p14 : mux_2x1_10bit     port map ( out_PC , output_AR , S_mux10 , out_mux10 ) ;
  p15 : mux_2x1_16bit     port map ( data_out_ram , BUSS , S_mux16 , out_mux16 ) ;
  p16 : mux_4x1_8bit      port map ( BUSS ( 7 downto 0 ) , out_ALU , output_inv , in4_mux8 , S_mux8 , out_mux8 ) ;
  p17 : I0_reg            port map ( clk , I0_load , I0_input , I0_output ) ;
  p18 : I1_reg            port map ( clk , I1_load , I1_input , I1_output ) ;
  p19 : INF               port map ( clk , set_INF , reset_INF , out_INF ) ;
  p20 : INPR              port map ( clk , load_INPR , input_INPR , out_INPR ) ;
  p21 : MBR               port map ( clk , load_MBR , inc_MBR , dec_MBR ,  out_mux16 , out1_MBR , out2_MBR );
  p22 : MAR               port map ( clk , load_MAR , rst_MAR , out_mux10 , out_MAR ); 
  p23 : OPR               port map ( clk , load_OPR , input_OPR , out_OPR) ;
  p24 : OUTR              port map ( clk , load_OUTR , input_OUTR , out_OUTR );
  p25 : PC                port map ( clk , load_PC , rst_PC , inc_PC , input_PC , out_PC );
  p26 : RAM               port map ( clk , out_MAR , wen_ram , out1_MBR , data_out_ram );
  p27 : sequence_counter  port map ( clk , reset_counter , output_counter ) ;
  AC2 <= output_AC;
  process ( clk ) 
     variable tmp : integer;
     begin 
      if start_index = '1' then
      
        if clk'event and clk = '1' then
        
        if T(0) = '1' then
           
           reset_counter <= '0';
        
        else
        
           tmp := tmp ;
           
        end if;
        
        if load_AR = '1' then
           
           input_AR <= BUSS ( 9 downto 0) ;       
        
        else
           
           input_AR <= input_AR ;
        
        end if;
        
        if load_OUTR = '1' then
           
           input_OUTR <= BUSS( 7 downto 0 ) ;
           
        else
         
           input_OUTR <= input_OUTR;
        
        end if;
        
        if load_CR = '1' then
        
            input_CR <= BUSS ( 7 downto 0 );
        else
          
            input_CR <= input_CR;
        
        end if; 
        
        if I0_load = '1' then
            
            I0_input <= BUSS (14);
            
        else 
        
           I0_input <= I0_input;
        
        end if;
        
         if I1_load = '1' then
           
           I1_input <= BUSS (14);
           
         else 
       
          I1_input <= I1_input;
       
         end if;
       
         if load_OPR = '1' then
         
             input_OPR <= BUSS ( 13 downto 10 ) ;
                
         else
            
             input_OPR <= input_OPR ;
            
         end if;
         
        
        case state is 
           
           when s0 =>
              
              if T(0) = '1' then
                 
                 load_MAR <= '1' ;
                 S_mux10 <= '0' ; 
              
              elsif T(1) = '1' then
              
                 load_MAR <= '0' ;
                 inc_PC   <= '1' ;
                 wen_ram  <= '0' ;
                 load_MBR <= '1' ;
                 S_mux16  <= '0' ;
                 
              elsif T(2) = '1' then
              
                 inc_pc   <= '0' ;
                 load_MBR <= '0' ;
                 I0_load  <= '1' ;
                 I1_load  <= '1' ;    
                 load_OPR <= '1' ;
                 load_AR  <= '1' ;
                 BUSS     <= out2_MBR ;
                 
               else -- T(3) = '1' then
                    
                    I0_load  <= '0' ;
                    I1_load  <= '0' ;
                    load_OPR <= '0' ;
                    
                    if I1_output = '0' and I0_output = '0' then
                    
                       if out_OPR(3) = '1' then 
                    
                          state <= s4 ; --register refrence
                    
                       else
                              
                          state <= s3;  --imediate : it doesnt need to change bus because 8 bit data is loaded into in1 of alu and is ready for operation
                                     
                       end if;
                                     
                    elsif I1_output = '1' and I0_output = '0' then
                    
                          state <= s5 ; --input output instruction
                     
                     elsif I1_output = '1' and I0_output = '1' then 
                         
                          state <= s1 ; --indirect 
                     
                     else -- I1 = '0' , I0 = '1' then
                               
                          state <= s2 ; -- direct     
                     
                     end if;
         
              end if; 
         
          when s1 => 
          
                if T(0) = '1' then
                
                   S_mux10 <= '1' ;
                   load_MAR <= '1' ;
                
                elsif T(1) = '1' then
                
                   load_MAR <= '0';
                   wen_ram <= '0' ;
                   S_mux16 <= '0' ;
                   load_MBR <= '1';
                   
                   
                elsif T(2) = '1' then
                
                   load_MBR <= '0' ;
                   BUSS     <= out2_MBR ;
                   load_AR  <= '1' ;
                   
                else --T(3)
                
                   load_AR  <= '0' ;
                   state <= s2 ;
                end if;         
                
          when s2 =>
          
                if T(0) = '1' then
                   
                   S_mux10 <= '1' ;
                   load_MAR <= '1' ;                   
                
                elsif T(1) = '1' then
    
                   load_MAR <= '0';
                   wen_ram <= '0' ;
                   S_mux16 <= '0' ;
                   load_MBR <= '1';
                
                else --T(2)
                
                   load_MBR <= '0';
                   state <= s3 ;    
                   BUSS  <= out2_MBR;--this cause that in next state (execution) direct and immediate are the same .      
                   reset_counter <= '1' ;
                           
                end if;
                
          when s3 => 
                
                if Q(0) = '1' or Q(1) = '1' or Q(2) = '1' or Q(3) = '1' or Q(4) = '1' or Q(5) = '1'  then 
                   
                   if T(0) = '1' then 
                   
                      S_mux8 <= "01" ;
                      load_AC <= '1' ;
            
                   else -- T(1) = '1' 
                   
                      load_AC <= '0';
                      reset_counter <= '1' ;
                      state <= s6;
                      
                   end if;
                         
                elsif Q(6) = '1' then
                
                   if T(0) = '1' then
                   
                      S_mux8 <= "00" ;
                      load_AC <= '1' ;
                   
                   else
                      
                      load_AC <= '0' ;
                      reset_counter <= '1' ;
                      state <= s6;
                      
                   end if;   
                
                elsif Q(7) = '1' then
                    
                    
                    if T(0) = '1' then
                       
                      BUSS(7 downto 0) <= output_AC ; --make 0 for othere 8 bit in connection of Ac , bus
                      BUSS(9 downto 8) <= "00";
                      load_MBR <= '1'; --check connection be 10 bit least vaildation
                      S_mux16 <= '1' ;
                      
                   else 
                     
                      load_MBR <= '0';
                      wen_ram <= '1' ; -- check be 0 in nxt_state 
                      state <= s6 ;
                      reset_counter <= '1' ;
                                    
                   end if;
               
               elsif Q(8) = '1' then
                   
                   if T(0) = '1' then
                   
                      BUSS(9 downto 0) <= output_AR ;
                      load_PC <= '1' ;
                  
                  else
                      
                      state <= s6 ;
                      reset_counter <= '1' ;
                      load_PC <= '0';    
               
                  end if;
                  
               elsif Q(9) = '1' then
                   
                   if  T(0) = '1' then
                     
                     BUSS ( 9 downto 0 ) <= out_PC ;
                     load_MBR <= '1' ;   
                     S_mux16 <= '1';      
                     
                   elsif T(1) = '1' then
                     
                     load_MBR <= '0' ;
                     wen_ram <= '1' ;
                     inc_AC  <= '1' ;
                     
                   elsif T(2) = '1' then
                   
                     wen_ram <= '0' ;
                     inc_AC  <= '0' ;     
                     BUSS( 9 downto 0 )  <= output_AR;
                     load_PC <= '1' ;
                     
                   else
                     
                     load_PC <= '0' ;
                     state <= s6 ;
                   
                      
                   end if;
               
               elsif Q(10) = '1' then
               
                  if T(0) = '1' then
                     
                     dec_MBR <= '1' ;
                     
                  elsif T(1) = '1' then
                     
                     dec_MBR <= '0' ;
                     wen_ram <= '1' ;
                     BUSS    <= out2_MBR;
                     load_AC <= '1' ;
                     
                  elsif T(2) = '1' then
                     
                     wen_ram <= '0' ;
                     load_AC <= '0' ;  
                     if out_cf = '1' then -- implement cary flag  
                     
                        inc_PC <= '1' ;
                     
                     else 
                        
                        inc_PC <= inc_PC ;
                     
                     end if; 
                           
                  else
                  
                     inc_PC <= '0';   
                     state <= s6 ;
                                     
                  end if;   
               
               elsif Q(11) = '1' then
                  
                  if T(0) = '1' then
                      
                     BUSS <= out2_MBR;
                     load_CR <= '1' ;
                  
                  else--if T(1) = '1' then
                  
                     load_CR <= '0' ;
                     state <= s6 ;
                     reset_counter <= '1' ;
                     
                  end if;
               
               elsif Q(12) = '1' then
                  
                  if T(0) = '1' then
                     
                     if out_zf = '1' then 
                         
                         inc_PC <= '1' ;
                     
                     else
                        
                         load_PC <= '1' ;
                         BUSS    <= out2_MBR ;    
                      
                      end if; 
                        
                  else
                  
                       load_PC <= '0';
                       inc_PC  <= '0';
                       state <= s6 ;
                       reset_counter <= '1' ;    
                  end if ;
                  
               else --if Q(13) = '1' then
                   
                  if T(0) = '1' then
                      
                      if out_cf = '1' then
                      
                         inc_PC <= '1' ;
                         
                      else 
                      
                         load_PC <= '1';
                         BUSS <= out2_MBR ;
                         
                      end if;
                 
                  else 
                      
                      load_PC <= '0';
                      inc_PC  <= '0';
                      state <= s6 ;
                      reset_counter <= '1' ;  
                      
                  end if ;
                                                         
               end if;
       
           when s4 => 
              
               if BUSS(0) = '1' then
                  
                  if T(0) = '1' then
                     
                     rst_AC <= '1' ;
                  
                  else 
                     
                     state <= s6 ;
                     reset_counter <= '1' ;                    
                     rst_AC <= '0';
                  
                  end if;      
                  
               elsif BUSS(1) = '1' then
               
                  if T(0) = '1' then
                     
                     set_CF <= '0' ;
                     set_ZF <= '0' ;
                  
                  else
                     
                     state <= s6 ;
                     reset_counter <= '1' ;    
                  
                  end if;
                         
               elsif BUSS(2) = '1' then
                
                  if T(0) = '1' then
                     
                     load_AC <= '1' ;
                     S_mux8 <= "10" ;
                     
                  else
                     
                     load_AC <= '0';
                     state <= s6 ;
                     reset_counter <= '1' ;     
                  
                  end if;              
               
               elsif BUSS(3) = '1' then
                  
                  if T(0) = '1' then
                     
                     sr_AC <= '1' ;
                                          
                  else
                     
                     sr_AC <= '0';
                     state <= s6 ;
                     reset_counter <= '1' ;   
                     
                  end if ; 
                  
               elsif BUSS(4) = '1' then
                   
                   if T(0) = '1' then
                      
                      sl_AC <= '1' ;
                                           
                   else
                      
                      sl_AC <= '0';
                      state <= s6 ;
                      reset_counter <= '1' ;   
                      
                   end if ; 
                 
               elsif BUSS(5) = '1' then
                   
                     
                   if T(0) = '1' then
                      
                      inc_AC <= '1' ;
                                           
                   else
                      
                      inc_AC <= '0';
                      state <= s6 ;
                      reset_counter <= '1' ;   
                      
                   end if ; 
                 
               else --if BUSS(6) = '1' then
                      
                      start_index <= '0';
                      state <= s6 ;
                      reset_counter <= '1' ;   
                      
               end if;  
                 
           when s5 =>         
                 
              if BUSS(0) = '1' then
                 
                 if T(0) = '1' then
                    
                    S_mux8 <= "00";
                    BUSS ( 7 downto 0 ) <=  out_INPR;
                    load_AC <= '1' ;
                    FGI <= '0';
                    
                 else 
                    
                    state <= s6 ;
                    reset_counter <= '1' ;                    
                    load_AC <= '0';
                 
                 end if;      
                 
              elsif BUSS(1) = '1' then
              
                 if T(0) = '1' then
                    
                    BUSS ( 7 downto 0 ) <= output_AC ;
                    load_OUTR <= '1' ;
                    FGO <= '0' ;
                    
                 else
                    
                    load_OUTR <= '0';
                    state <= s6 ;
                    reset_counter <= '1' ;    
                 
                 end if;
                        
              elsif BUSS(2) = '1' then
               
                 if T(0) = '1' then
                    
                    if FGI = '1' then
                       
                       inc_PC <= '1' ;
                    
                    else
                       
                       inc_PC <= inc_Pc ;
                       
                    end if;
                 
                 else
                    
                    inc_PC <= '0';
                    state <= s6 ;
                    reset_counter <= '1' ;     
                 
                 end if;              
              
              elsif BUSS(3) = '1' then
                 
     
                   if T(0) = '1' then
                      
                      if FGO = '1' then
                         
                         inc_PC <= '1' ;
                      
                      else
                         
                         inc_PC <= inc_Pc ;
                         
                      end if;
                   
                   else
                      
                      inc_PC <= '0';
                      state <= s6 ;
                      reset_counter <= '1' ;     
                   
                   end if;
               
              elsif BUSS(4) = '1' then
              
                  if T(0) = '1' then
                     
                     set_INF <= '1';
                     
                  else 
                   
                     state <= s6 ;
                     reset_counter <= '1' ;                       
                     set_INF <= '0';
                 
                  end if;    
              
              else -- if  BUSS(5) = '1' then
          
                  if T(0) = '1' then
                 
                    reset_INF <= '1';
                 
                  else 
               
                    state <= s6 ;
                    reset_counter <= '1' ;                       
                    reset_INF <= '0';
             
                 end if;    
              end if;
              
              when s6 =>
                 
                  if (out_INF = '1' ) then
                     
                     state <= s7 ;
                     reset_counter <= '1';
                     
                  else
                     
                     state <= s0 ;
                     reset_counter <= '1';
                     
                  end if;   
              
              when s7 =>
              
                  if T(0) = '1' then
                     
                     BUSS(9 downto 0 ) <= out_PC ;
                     reset_INF <= '1';    
                     load_MBR <= '1' ;
                     S_mux16 <= '1';
                     
                  elsif T(1) = '1' then
                     
                     reset_INF <= '0';    
                     load_MBR  <= '0'; 
                     rst_PC <= '1' ;
                     rst_MAR<= '1' ;
                     
                  elsif T(2) = '1' then
                  
                     rst_PC  <= '0' ;
                     rst_MAR <= '0' ;
                     inc_PC <= '1' ;
                     wen_ram <= '1' ;
                  
                  else
                  
                     wen_ram <= '0';
                     inc_PC <= '0';
                     state <= s0 ;
                     --reset_counter <= '1';
                  end if;                                            
           end case ;
     
     end if ;
        
     else
     
    tmp := tmp ; 
    
    end if ;
  
  end process;          

end Behavioral;
