--------------------------------------------------------------------------------
-- Entity: ClockGen
-- Date:2018-03-29  
-- Author: Michael Mortensen     
--
-- Description: Clock generator for scheme 3
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY ClockGen IS
    PORT  (
        clock : IN std_logic; 
        resetCG : in std_logic;
        clk0 : OUT std_logic;
        clk1 : OUT std_logic;
        clk2 : OUT std_logic;
        clk3 : OUT std_logic
    );
END ClockGen;

ARCHITECTURE arch OF ClockGen IS

    COMPONENT DFF
        PORT  (
            clock : IN std_logic;        -- input clock, xx MHz.
            reset : in std_logic;
            D : IN std_logic;
            Q : OUT std_logic
        );
    END COMPONENT;

--    SIGNAL Q3 : std_logic := '0'; -- Initial values not supported by design vision
--    SIGNAL Q2 : std_logic := '0';
--    SIGNAL Q1 : std_logic := '0';
--    SIGNAL Q0 : std_logic := '0';
--    SIGNAL Din : std_logic := '0';
--    SIGNAL NewD : std_logic := '1';
    
    SIGNAL Q3 : std_logic;
    SIGNAL Q2 : std_logic;
    SIGNAL Q1 : std_logic;
    SIGNAL Q0 : std_logic;
    SIGNAL Din : std_logic;
    SIGNAL NewD : std_logic;

BEGIN

    Din <= NewD OR Q0;
    
    ff0: DFF
        port map (clock => clock, reset => resetCG, D => Din, Q => Q3);
    ff1: DFF
        port map (clock => clock, reset => resetCG, D => Q3, Q => Q2);
    ff2: DFF
        port map (clock => clock, reset => resetCG, D => Q2, Q => Q1);
    ff3: DFF
        port map (clock => clock, reset => resetCG, D => Q1, Q => Q0);

    PROCESS(clock, resetCG)
    BEGIN
--        IF (clock'event AND clock = '1') THEN
--            Q0 <= Q1;
--            Q1 <= Q2;
--            Q2 <= Q3;
--            Q3 <= Din;
--        END IF;
--        IF (clock'event AND clock = '0' and resetCG = '1') THEN
--            NewD <= '0';
--        elsif (resetCG = '0') then  -- (Not supported by design vision?)
--            NewD <= '1';
--        END IF;
        IF (clock'event AND clock = '0' and resetCG = '1') THEN
            NewD <= '0';
        END IF;
        IF (resetCG = '0') then
            NewD <= '1';
        END IF;
    END PROCESS;
    
    clk0 <= Q0 NAND (NOT clock);
    clk1 <= Q1 NAND (NOT clock);
    clk2 <= Q2 NAND (NOT clock);
    clk3 <= Q3 NAND (NOT clock);

END arch;