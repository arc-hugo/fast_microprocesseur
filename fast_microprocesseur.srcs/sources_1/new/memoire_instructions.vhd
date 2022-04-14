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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memoire_instructions is
    Port ( add : in STD_LOGIC_VECTOR (0 downto 0);
           CLK : in STD_LOGIC;
           OUT : out STD_LOGIC_VECTOR (31 downto 0));
end memoire_instructions;

architecture Behavioral of memoire_instructions is

begin


end Behavioral;
