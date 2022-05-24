----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.04.2022 10:04:04
-- Design Name: 
-- Module Name: banc_registres - Behavioral
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

entity banc_registres is
    generic(NB: Natural := 16);
    Port ( addA : in STD_LOGIC_VECTOR (3 downto 0);
           addB : in STD_LOGIC_VECTOR (3 downto 0);
           addW : in STD_LOGIC_VECTOR (3 downto 0);
           W : in STD_LOGIC;
           DATA : in STD_LOGIC_VECTOR (NB-1 downto 0);
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR (NB-1 downto 0);
           QB : out STD_LOGIC_VECTOR (NB-1 downto 0));
end banc_registres;

architecture Behavioral of banc_registres is

type reg is array (0 to 15) of STD_LOGIC_VECTOR (NB-1 downto 0);
signal Registres: reg := (others => (NB-1 downto 0 => '0'));

begin

process
begin
    wait until rising_edge(CLK);
    -- Réinitialisation synchrone des registres si RST est haut
    if RST = '0' then
        Registres <= (others => (NB-1 downto 0 => '0'));
    -- Écriture synchrone si W est haut
    elsif W = '1' then
        Registres(to_integer(unsigned(addW))) <= DATA;
    end if;
end process;

-- Lecture asynchrone pour QA
-- Envoi direct de DATA dans QA 
-- lors d'une écriture sur la même adresse pendant un front montant de CLK
QA <= DATA when addA = addW and W = '1' and rising_edge(CLK) else
      Registres(to_integer(unsigned(addA)));

-- Lecture asynchrone pour QB
-- Envoi direct de DATA dans QB 
-- lors d'une écriture sur la même adresse pendant un front montant de CLK
QB <= DATA when addB = addW and W = '1' and rising_edge(CLK) else
      Registres(to_integer(unsigned(addB)));

end Behavioral;
