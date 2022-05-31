----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.04.2022 11:33:50
-- Design Name: 
-- Module Name: memoire_instructions - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memoire_instructions_16bit is
    Port ( add : in STD_LOGIC_VECTOR (15 downto 0);
           CLK : in STD_LOGIC;
           Output : out STD_LOGIC_VECTOR (63 downto 0));
end memoire_instructions_16bit;

architecture Behavioral of memoire_instructions_16bit is

type mem is array (0 to 131071) of STD_LOGIC_VECTOR (63 downto 0);

-- AFC R1 16 (0009_0001_0010_0000)
-- AFC R3 2 (0009_0003_0002_0000)
-- COP R4 R1 (0008_0004_0001_0000)
-- LDR R4 10 (000A_0004_000A_0000)
-- LDR R5 500 (000A_0005_01F4_0000)
-- STR 10 R3 (000B_000A_0003_0000)
-- ADD R2 R1 R3 (0001_0002_0001_0003)
-- MUL R6 R1 R3 (0003_0006_0001_0003)
-- ADD R4 R6 R1 (0001_0004_0006_0001)
constant MEM_INSTR: mem := (X"0009_0001_0010_0000",
                            X"0009_0003_0002_0000",
                            X"0008_0004_0001_0000",
                            X"0001_0002_0001_0003",
                            X"000A_0004_000A_0000",
                            X"000A_0005_01F4_0000",
                            X"000B_000A_0003_0000",
                            X"0001_0002_0001_0003",
                            X"0003_0006_0001_0003",
                            X"0001_0004_0006_0001",
                            others => (63 downto 0 => '0'));

begin

process
begin
   wait until rising_edge(CLK);
   Output <= MEM_INSTR(to_integer(unsigned(add)));
end process;

end Behavioral;
