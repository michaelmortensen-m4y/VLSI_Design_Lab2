--------------------------------------------------------------------------------
-- Entity: ShiftReg32Bit
-- Date:2018-03-20  
-- Author: Michael Mortensen     
--
-- Description: Scheme 1: 32-bit shift register
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY ShiftReg32Bit IS
    PORT  (
        clk : IN std_logic;
        Data : IN std_logic_vector(7 downto 0);
        Qout : OUT std_logic_vector(31 DOWNTO 0)
    );
END ShiftReg32Bit;

ARCHITECTURE arch OF ShiftReg32Bit IS

    COMPONENT RegNBit
        generic(N : natural);
        PORT  (
            clock : IN std_logic;
            D : IN std_logic_vector(N-1 downto 0);
            Q : OUT std_logic_vector(N-1 DOWNTO 0)
        );
    END COMPONENT;
    
    SIGNAL byte0 : std_logic_vector(N-1 DOWNTO 0);
    SIGNAL byte1 : std_logic_vector(N-1 DOWNTO 0);
    SIGNAL byte2 : std_logic_vector(N-1 DOWNTO 0);
    SIGNAL byte3 : std_logic_vector(N-1 DOWNTO 0);
    
BEGIN

    reg0: RegNBit
        generic map (N => 8)
        PORT MAP (clock => clk, D => Data, Q => byte0);
    reg1: RegNBit
        generic map (N => 8)
        PORT MAP (clock => clk, D => byte0, Q => byte1);
    reg2: RegNBit
        generic map (N => 8)
        PORT MAP (clock => clk, D => byte1, Q => byte2);
    reg3: RegNBit
        generic map (N => 8)
        PORT MAP (clock => clk, D => byte2, Q => byte3);
        
    Qout <= byte3 & byte2 & byte1 & byte0;

END arch;


