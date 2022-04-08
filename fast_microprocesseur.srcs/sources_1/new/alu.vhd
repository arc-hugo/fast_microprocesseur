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
    generic (Nb: Natural := 16);
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

signal S_Plus: STD_LOGIC_VECTOR ((NB*2)+1 downto 0) := (others => '0');
signal A_Plus: STD_LOGIC_VECTOR ((NB*2)+1 downto 0) := (others => '0');
signal B_Plus: STD_LOGIC_VECTOR ((NB*2)+1 downto 0) := (others => '0');

begin

-- Opérations sur l'ALU
S_Plus <= A_Plus + B_Plus when Ctrl_Alu = "000" else -- Addition
          A_Plus - B_Plus when Ctrl_Alu = "001" else -- Soustraction
          A_Plus * B_Plus when Ctrl_Alu = "010" else -- Multiplication
          A_Plus and B_Plus when Ctrl_Alu = "011" else -- ET logique
          A_Plus or B_Plus when Ctrl_Alu = "100" else -- OU logique
          not A when Ctrl_Alu = "101"; -- NON logique

-- Sortie de la valeur calculée
S <= S_Plus(NB-1 downto 0);

-- Gestion du Flag valeur négative (N)
N <= '1' when Ctrl_Alu = "001" and B_Plus > A_Plus else
     '1' when Ctrl_Alu = "010" and (A_Plus = (others => '0') or B_Plus = (others => '0')) else
     '0';

-- Gestion du Flag overflow multiplcation (O)
O <= '1' when Ctrl_Alu = "010" and S_Plus((NB*2)+1 downto NB) > (others => '0') else
     '0';

-- Gestion du Flag valeur nulle (Z)
Z <= '1' when S_Plus = (others => '0') else
     '0';

-- Gestion du Flag carry addition (C)
C <= '1' when Ctrl_Alu = "000" and S_Plus((NB*2)+1 downto NB) > (others => '0') else
     '0';

end Behavioral;
