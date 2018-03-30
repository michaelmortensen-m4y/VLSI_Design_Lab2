--------------------------------------------------------------------------------
-- Entity: Mux2InputNBit
-- Date:2018-03-20  
-- Author: Michael Mortensen     
--
-- Description: 2-input n-bit multiplexer
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
library IEEE_proposed;
    use IEEE_proposed.std_logic_components.all;

ENTITY Mux2InputNBit IS
    generic(N : natural);
    PORT  (
        Sel : IN std_logic;
        D0 : IN std_logic_vector(N-1 DOWNTO 0);
        D1 : IN std_logic_vector(N-1 DOWNTO 0);
        Output : OUT std_logic_vector(N-1 DOWNTO 0)
    );
END Mux2InputNBit;

ARCHITECTURE arch OF Mux2InputNBit IS

BEGIN
    PROCESS(Sel, D0, D1)
    BEGIN
        CASE Sel IS
            when '0' =>    Output <= D0;
            when '1' =>    Output <= D1;
            when others => Output <= (others => 'Z');
        END CASE;
    END PROCESS;

END arch;
