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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memoire_instructions is
    generic (NB: Natural := 16);
    Port ( add : in STD_LOGIC_VECTOR (NB-1 downto 0);
           CLK : in STD_LOGIC;
           Output : out STD_LOGIC_VECTOR ((NB*4)-1 downto 0));
end memoire_instructions;

architecture Behavioral of memoire_instructions is

constant size: STD_LOGIC_VECTOR(NB downto 0) := '1' & (NB-1 downto 0 => '0');
type mem is array (0 to to_integer(unsigned(size))-1) of STD_LOGIC_VECTOR ((NB*4)-1 downto 0);
signal MEM_INSTR: mem := (others => ((NB*4)-1 downto 0 => '0'));

begin

process
begin
   wait until rising_edge(CLK);
   Output <= MEM_INSTR(to_integer(unsigned(add)));
end process;

end Behavioral;
