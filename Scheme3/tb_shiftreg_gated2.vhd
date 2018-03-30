--------------------------------------------------------------------------------
-- Entity: tb_shiftreg_gated2
-- Date:2018-03-28  
-- Author: Michael Mortensen     
--
-- Description: Provided testbench for scheme c shift register with clock gating
--------------------------------------------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;
    use STD.textio.all;
    use IEEE.std_logic_textio.all;
    use IEEE.std_logic_signed.all;

entity E is
end E;

architecture A of E is

   signal    CLOCK : std_logic;
   signal    RESET : std_logic;
   signal       QK : std_logic_vector (7 downto 0);
   signal        Qout : std_logic_vector (31 downto 0);

   component ShiftReg32BitClockGated
      Port (   CLOCK : In    std_logic;
               RESET : In    std_logic;
                  QK : In    std_logic_vector (7 downto 0);
                   Qout : InOut   std_logic_vector (31 downto 0) );
   end component;

begin
   UUT : ShiftReg32BitClockGated
      Port Map ( CLOCK, RESET, QK, Qout );

   TB : block
   begin
   process
    CONSTANT NLOOPS : integer := 15;
    file cmdfile: TEXT;          -- Define the file 'handle'
    variable line_in,line_out: Line; -- Line buffers
    variable good: boolean;      -- Status of the read operations
    variable A,B: std_logic_vector(7 downto 0);
    variable S: std_logic_vector(55 downto 0);
    variable Z: std_logic_vector(31 downto 0);
    variable ERR: std_logic_vector(55 downto 0);
    variable c : integer;
    -- constant TEST_PASSED: string := "Test passed:";
    -- constant TEST_FAILED: string := "Test FAILED:";

    begin


  c := 1;
  FILE_OPEN(cmdfile,"testvecs.in",READ_MODE);
  
  reset <= '0';
  clock <= '0'; wait for 5 ns;
  reset <= '1';
  clock <= '1'; wait for 5 ns;
  clock <= '0'; wait for 5 ns;

-- -------------------------------------------------------------------------
  loop
    if endfile(cmdfile) then  -- Check EOF
    assert false
       report "End of file encountered; exiting."
       severity NOTE;
    exit;
    end if;

    readline(cmdfile,line_in);     -- Read a line from the file
    next when line_in'length = 0;  -- Skip empty lines

    hread(line_in,A,good);         -- Read the D argument as hex value
    assert good report "Text I/O read error" severity ERROR;

    QK(7 downto 0) <= A(7 downto 0);

    clock <= '1'; wait for 5 ns;
    clock <= '0'; wait for 5 ns;
    
    Z(31 downto 0)  := Qout(31 downto 0);

    write(line_out, string'("byte "));
    write(line_out,c-1);
    write(line_out, string'(" : "));
    if (c = 4) then
    hwrite(line_out,A,RIGHT,2);
    write(line_out, string'(" -> "));
    hwrite(line_out,Z,RIGHT,8);
    c := 0;
    else
    hwrite(line_out,A,RIGHT,2);
    end if;
    writeline(OUTPUT,line_out);     -- write the message
    --assert (Z = S) report "Z does not match in pattern " severity error;
    c := c + 1;
  end loop;
-- -------------------------------------------------------------------------
 
    write(line_out, string'("--------- END GATED 2   ------------------"));
    writeline(OUTPUT,line_out);

-- ===============================================================
  clock <= '1'; wait for 1000 ns;
  assert Qout = "11111111111111111111111111111111"
    report "--------- END SIMULATION  ------------------ " severity error;
-- ===============================================================


   end process;
 end block;
end A;

configuration CFG_tb_shiftreg_BEHAVIORAL of E is
   for A
      for UUT : ShiftReg32BitClockGated
         -- use configuration WORK.CFG_q_regs_enable_SCHEMATIC;
         use configuration WORK.CFG_SHIFTREG_GATED_SCHEMATIC;
      end for;

      for TB
      end for;

   end for;
end CFG_tb_shiftreg_BEHAVIORAL;
