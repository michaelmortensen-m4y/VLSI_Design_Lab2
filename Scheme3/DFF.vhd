--------------------------------------------------------------------------------
-- Entity: DFF
-- Date:2018-03-20  
-- Author: Michael Mortensen     
--
-- Description: Unit: D-type flip flop
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY DFF IS
    PORT  (
        clock : IN std_logic;        -- input clock, xx MHz.
        reset : IN std_logic;
        D : IN std_logic;
        Q : OUT std_logic
    );
END DFF;

ARCHITECTURE arch OF DFF IS

BEGIN
    PROCESS(clock, reset)
    BEGIN
        if (reset = '0') then
            Q <= '0';
        elsif (clock'event AND clock = '1') THEN
            Q <= D;
        END IF;
    END PROCESS; 

END arch;

