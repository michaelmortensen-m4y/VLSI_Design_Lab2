--------------------------------------------------------------------------------
-- Entity: ShiftReg32BitClockGated
-- Date:2018-03-20  
-- Author: Michael Mortensen     
--
-- Description: Scheme 3: 32-bit shiftregister with clock gating
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
library IEEE_proposed;
    use IEEE_proposed.std_logic_components.all;

ENTITY ShiftReg32BitClockGated IS
    PORT (CLOCK : In    std_logic;
          RESET : In    std_logic;
          QK    : In    std_logic_vector (7 downto 0);
          Qout  : InOut std_logic_vector (31 downto 0) 
         );
END ShiftReg32BitClockGated;

ARCHITECTURE arch OF ShiftReg32BitClockGated IS

    COMPONENT RegNBit
        generic (N : natural);
        PORT  (
            clock : IN std_logic;        -- input clock, xx MHz.
            D : IN std_logic_vector(N-1 downto 0);
            Q : OUT std_logic_vector(N-1 DOWNTO 0)
        );
    END COMPONENT;
    
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
    
    SIGNAL byte0 : std_logic_vector(7 DOWNTO 0);
    SIGNAL byte1 : std_logic_vector(7 DOWNTO 0);
    SIGNAL byte2 : std_logic_vector(7 DOWNTO 0);
    SIGNAL byte3 : std_logic_vector(7 DOWNTO 0);
    
    signal clk0Sig : std_logic := '0';
    signal clk1Sig : std_logic := '0';
    signal clk2Sig : std_logic := '0';
    signal clk3Sig : std_logic := '0';
    
BEGIN

    clkG: ClockGen
        PORT MAP (clock => CLOCK, resetCG => RESET, clk0 => clk0Sig, clk1 => clk1Sig, clk2 => clk2Sig, clk3 => clk3Sig); 
    
    reg0: RegNBit
        generic map (N => 8)
        PORT MAP (clock => clk0Sig, D => QK, Q => byte0);
    reg1: RegNBit
        generic map (N => 8)
        PORT MAP (clock => clk1Sig, D => QK, Q => byte1);
    reg2: RegNBit
        generic map (N => 8)
        PORT MAP (clock => clk2Sig, D => QK, Q => byte2);
    reg3: RegNBit
        generic map (N => 8)
        PORT MAP (clock => clk3Sig, D => QK, Q => byte3); 
         
    Qout <= byte3 & byte2 & byte1 & byte0;

END arch;

configuration CFG_SHIFTREG_GATED_SCHEMATIC of ShiftReg32BitClockGated is
   for arch
   end for;

end CFG_SHIFTREG_GATED_SCHEMATIC;
