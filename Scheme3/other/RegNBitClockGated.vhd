--------------------------------------------------------------------------------
-- Entity: RegNBitClockGated
-- Date:2018-03-20  
-- Author: Michael Mortensen     
--
-- Description: Unit: n-bit register
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY RegNBitClockGated IS
    generic(N : natural);
    PORT  (
        clock : IN std_logic;        -- input clock, xx MHz.
        D : IN std_logic_vector(N-1 downto 0);
        Q : OUT std_logic_vector(N-1 DOWNTO 0)
    );
END RegNBitClockGated;

ARCHITECTURE arch OF RegNBitClockGated IS

COMPONENT ClockGate
    generic (N : natural);
    PORT  (
        clock : IN std_logic;        -- input clock, xx MHz.
        Ddata : IN std_logic_vector(N-1 downto 0);
        Qdata : IN std_logic_vector(N-1 downto 0);
        gatedClock : OUT std_logic
    );
END COMPONENT;

    SIGNAL Q_tmp: std_logic_vector(N-1 DOWNTO 0);
    signal gclk: std_logic;

BEGIN

    clkgate: ClockGate
        generic map(N => 8)
        port map(clock => clock, Ddata => D, Qdata => Q_tmp, gatedClock => gclk);

    PROCESS(gclk, D)
    BEGIN
        IF (gclk = '1') THEN
            Q_tmp <= D;
        END IF;
    END PROCESS; 

    Q <= Q_tmp;

END arch;

