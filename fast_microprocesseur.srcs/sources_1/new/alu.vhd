----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.04.2022 09:48:58
-- Design Name: 
-- Module Name: alu - Behavioral
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

entity alu is
    generic (NB: Natural := 16);
    Port ( A : in STD_LOGIC_VECTOR (NB-1 downto 0);
           B : in STD_LOGIC_VECTOR (NB-1 downto 0);
           Ctrl_Alu : in STD_LOGIC_VECTOR (2 downto 0);
           S : out STD_LOGIC_VECTOR (NB-1 downto 0);
           N : out STD_LOGIC;
           O : out STD_LOGIC;
           Z : out STD_LOGIC;
           C : out STD_LOGIC);
end alu;

architecture Behavioral of alu is

signal S_Plus: STD_LOGIC_VECTOR ((NB*2)-1 downto 0) := (others => '0');

begin

-- Opérations sur l'ALU
S_Plus <= ((NB-1 downto 0 => '0') & A) + ((NB-1 downto 0 => '0')  & B) when Ctrl_Alu = "001" else -- Addition
          ((NB-1 downto 0 => '0')  & A) - ((NB-1 downto 0 => '0')  & B) when Ctrl_Alu = "010" else -- Soustraction
          A * B when Ctrl_Alu = "011" else -- Multiplication
          (NB-1 downto 0 => '0') & A when Ctrl_Alu = "100" else -- Division sur "011" non implémentée
          ((NB-1 downto 0 => '0')  & A) and ((NB-1 downto 0 => '0')  & B) when Ctrl_Alu = "101" else -- ET logique
          ((NB-1 downto 0 => '0')  & A) or ((NB-1 downto 0 => '0')  & B) when Ctrl_Alu = "110" else -- OU logique
          not ((NB-1 downto 0 => '0')  & A) when Ctrl_Alu = "111" else -- NON logique
          ((NB*2)-1 downto 0 => '0');

-- Sortie de la valeur calculée
S <= S_Plus(NB-1 downto 0);

-- Gestion du Flag valeur négative (N)
N <= '1' when Ctrl_Alu = "001" and B > A else
     '0';

-- Gestion du Flag overflow multiplcation (O)
O <= '1' when Ctrl_Alu = "010" and S_Plus((NB*2)-1 downto NB) > (NB-1 downto 0 => '0') else
     '0';

-- Gestion du Flag valeur nulle (Z)
Z <= '1' when S_Plus = ((NB*2)-1 downto 0  => '0') else
     '0';

-- Gestion du Flag carry addition (C)
C <= '1' when Ctrl_Alu = "000" and S_Plus((NB*2)-1 downto NB) > (NB-1 downto 0 => '0') else
     '0';

end Behavioral;
