--------------------------------------------------------------------------------
-- Entity: ShiftReg32BitWithEnable
-- Date:2018-03-20  
-- Author: Michael Mortensen     
--
-- Description: Scheme 2: 32-bit shift register with enable
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
library IEEE_proposed;
    use IEEE_proposed.std_logic_components.all;

ENTITY ShiftReg32BitWithEnable IS
	PORT (CLOCK : In    std_logic;
          RESET : In    std_logic;
          en0   : In    std_logic;
          en1   : In    std_logic;
          en2   : In    std_logic;
          en3   : In    std_logic;
          QK    : In    std_logic_vector (7 downto 0);
          Qout  : InOut std_logic_vector (31 downto 0) 
         );
END ShiftReg32BitWithEnable;

ARCHITECTURE arch OF ShiftReg32BitWithEnable IS

    COMPONENT RegNBit
        generic(N : natural);
        PORT  (
            clock : IN std_logic; 
            D : IN std_logic_vector(N-1 downto 0);
            Q : OUT std_logic_vector(N-1 DOWNTO 0)
        );
    END COMPONENT;
    
    COMPONENT Mux2InputNBit
        generic(N : natural);
        PORT  (
            Sel : IN std_logic;
            D0 : IN std_logic_vector(N-1 DOWNTO 0);
            D1 : IN std_logic_vector(N-1 DOWNTO 0);
            Output : OUT std_logic_vector(N-1 DOWNTO 0)
        );
    END COMPONENT;
    
    SIGNAL byte0 : std_logic_vector(7 DOWNTO 0) := "00000000";
    SIGNAL byte1 : std_logic_vector(7 DOWNTO 0) := "00000000";
    SIGNAL byte2 : std_logic_vector(7 DOWNTO 0) := "00000000";
    SIGNAL byte3 : std_logic_vector(7 DOWNTO 0) := "00000000";
    
    SIGNAL mux0Out : std_logic_vector(7 DOWNTO 0);
    SIGNAL mux1Out : std_logic_vector(7 DOWNTO 0);
    SIGNAL mux2Out : std_logic_vector(7 DOWNTO 0);
    SIGNAL mux3Out : std_logic_vector(7 DOWNTO 0);
    
BEGIN

    reg0: RegNBit
        generic map (N => 8)
        PORT MAP (clock => CLOCK, D => mux0Out, Q => byte0);
    reg1: RegNBit
        generic map (N => 8)
        PORT MAP (clock => CLOCK, D => mux1Out, Q => byte1);
    reg2: RegNBit
        generic map (N => 8)
        PORT MAP (clock => CLOCK, D => mux2Out, Q => byte2);
    reg3: RegNBit
        generic map (N => 8)
        PORT MAP (clock => CLOCK, D => mux3Out, Q => byte3);
        
    mux0: Mux2InputNBit
        generic map (N => 8)
        PORT MAP (Sel => en3, D0 => byte0, D1 => QK, Output => mux0Out);
    mux1: Mux2InputNBit
        generic map (N => 8)
        PORT MAP (Sel => en2, D0 => byte1, D1 => QK, Output => mux1Out);
    mux2: Mux2InputNBit
        generic map (N => 8)
        PORT MAP (Sel => en1, D0 => byte2, D1 => QK, Output => mux2Out);
    mux3: Mux2InputNBit
        generic map (N => 8)
        PORT MAP (Sel => en0, D0 => byte3, D1 => QK, Output => mux3Out);
        
    Qout <= byte3 & byte2 & byte1 & byte0;

END arch;

configuration cfg_shiftreg_enable_schematic of ShiftReg32BitWithEnable is
   for arch
   end for;

end cfg_shiftreg_enable_schematic;


