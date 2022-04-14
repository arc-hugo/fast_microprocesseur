----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.04.2022 11:57:54
-- Design Name: 
-- Module Name: test_alu_16bit - Behavioral
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
library alu;
use IEEE.STD_LOGIC_1164.ALL;
use alu.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_alu_16bit is
--  Port ( );
end test_alu_16bit;

architecture Behavioral of test_alu_16bit is


component alu
generic (NB: Natural := 16);
Port ( A : in STD_LOGIC_VECTOR (NB-1 downto 0);
       B : in STD_LOGIC_VECTOR (NB-1 downto 0);
       Ctrl_Alu : in STD_LOGIC_VECTOR (2 downto 0);
       S : out STD_LOGIC_VECTOR (NB-1 downto 0);
       N : out STD_LOGIC;
       O : out STD_LOGIC;
       Z : out STD_LOGIC;
       C : out STD_LOGIC);
end component;

constant NB: Natural := 16;
signal A_local: STD_LOGIC_VECTOR (NB-1 downto 0) := (others => '0');
signal B_local: STD_LOGIC_VECTOR (NB-1 downto 0) := (others => '0');
signal Ctrl_local: STD_LOGIC_VECTOR (2 downto 0) := (others => '0');
signal S_local: STD_LOGIC_VECTOR (NB-1 downto 0) := (others => '0');
signal N_local: STD_LOGIC := '0';
signal O_local: STD_LOGIC := '0';
signal Z_local: STD_LOGIC := '0';
signal C_local: STD_LOGIC := '0';

begin

alu_16: alu generic map (NB => NB) Port Map (
    A => A_local,
    B => B_local,
    Ctrl_Alu => Ctrl_local,
    S => S_local,
    N => N_local,
    O => O_local,
    Z => Z_local,
    C => C_local
);

A_local <= X"EFFF" after 10ns;
B_local <= X"0002" after 20ns;
Ctrl_local <= "001" after 100ns, "010" after 200ns, "011" after 300ns, "100" after 400ns, "101" after 500ns;

end Behavioral;
