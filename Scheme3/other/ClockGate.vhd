--------------------------------------------------------------------------------
-- Entity: RegNBitClockGated
-- Date:2018-03-28  
-- Author: Michael Mortensen     
--
-- Description: Clock gated n-bit register
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY ClockGate IS
    generic(N : natural);
    PORT  (
        clock : IN std_logic;        -- input clock, xx MHz.
        Ddata : IN std_logic_vector(N-1 downto 0);
        Qdata : IN std_logic_vector(N-1 downto 0);
        gatedClock : OUT std_logic
    );
END ClockGate;

ARCHITECTURE arch OF ClockGate IS
BEGIN
    PROCESS(clock, Ddata, Qdata)
    BEGIN
        IF (clock'event AND clock = '1') THEN
            if Ddata = Qdata then
                gatedClock <= '0';
            else
                gatedClock <= '1';
            end if;
        END IF;
    END PROCESS;

END arch;