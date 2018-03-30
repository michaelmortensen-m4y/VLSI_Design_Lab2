--------------------------------------------------------------------------------
-- Entity: tb_ClockGen
-- Date:2018-03-29  
-- Author: Michael Mortensen     
--
-- Description: Testbench for Clock Gate logic
--------------------------------------------------------------------------------
LIBRARY ieee;  
 USE ieee.std_logic_1164.ALL;  
 USE ieee.std_logic_unsigned.all;  
 USE ieee.numeric_std.ALL;  

 ENTITY tb_ClockGen IS  
 END tb_ClockGen;  

 ARCHITECTURE behavior OF tb_ClockGen IS  
   -- Component Declaration for the Unit Under Test (UUT)  
   COMPONENT ClockGen  
   PORT  (
        clock : IN std_logic; 
        resetCG : in std_logic;
        clk0 : OUT std_logic;
        clk1 : OUT std_logic;
        clk2 : OUT std_logic;
        clk3 : OUT std_logic
    ); 
   END COMPONENT;  

   --Inputs  
   SIGNAL clock  : std_logic := '0';  
   SIGNAL reset  : std_logic := '0';  
    signal clk0Sig : std_logic := '0';
    signal clk1Sig : std_logic := '0';
    signal clk2Sig : std_logic := '0';
    signal clk3Sig : std_logic := '0';  
 BEGIN  
   -- Instantiate the Unit Under Test (UUT)  
   uut: ClockGen PORT MAP(  
     clock => clock,  
     resetCG => reset,
     clk0 => clk0Sig,
     clk1 => clk1Sig,
     clk2 => clk2Sig,
     clk3 => clk3Sig 
   );  

   PROCESS  
   BEGIN  
       wait for 5ns;  
       clock <= not clock;  
   END PROCESS;
  
   PROCESS  
   BEGIN  
       reset <= '0';  
       wait for 5ns;  
       reset <= not reset;  
       wait;  
   END PROCESS;  
 END;  