----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.04.2022 14:16:21
-- Design Name: 
-- Module Name: test_memoire_instructions_16bit - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_memoire_instructions_16bit is
--  Port ( );
end test_memoire_instructions_16bit;

architecture Behavioral of test_memoire_instructions_16bit is

component memoire_instructions
    Port ( add : in STD_LOGIC_VECTOR (15 downto 0);
           CLK : in STD_LOGIC;
           Output : out STD_LOGIC_VECTOR (63 downto 0));
end component;

constant CLK_period: TIME := 10ns;

signal add: STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
signal Output: STD_LOGIC_VECTOR (63 downto 0) := (others => '0');
signal CLK: STD_LOGIC := '0';

begin

memoire_instructions_16: memoire_instructions Port Map (
   add => add,
   CLK => CLK,
   Output => Output
);

process
begin
    wait for CLK_period/2;
    CLK <= not(CLK);
end process;

process
begin
    wait until rising_edge(CLK);
    add <= add + '1';
end process;

end Behavioral;
