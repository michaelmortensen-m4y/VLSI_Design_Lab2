--------------------------------------------------------------------------------
-- Entity: RegNBit
-- Date:2018-03-20  
-- Author: Michael Mortensen     
--
-- Description: Unit: n-bit register
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY RegNBit IS
    generic(N : natural);
    PORT  (
        clock : IN std_logic;
        D : IN std_logic_vector(N-1 downto 0);
        Q : OUT std_logic_vector(N-1 DOWNTO 0)
    );
END RegNBit;

ARCHITECTURE arch OF RegNBit IS

    SIGNAL Q_tmp: std_logic_vector(N-1 DOWNTO 0);

BEGIN
    PROCESS(clock, D)
    BEGIN
        IF (clock'event AND clock = '1') THEN
            Q_tmp <= D;
        END IF;
    END PROCESS; 

    Q <= Q_tmp;

END arch;

