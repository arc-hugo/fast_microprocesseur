----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.05.2022 15:35:58
-- Design Name: 
-- Module Name: test_gestion_alea_16bit - Behavioral
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

entity test_gestion_alea_16bit is
end test_gestion_alea_16bit;

architecture Behavioral of test_gestion_alea_16bit is

-- Gestionnaire des aléas
component gestion_alea
    generic(NB: Natural := 16);
    Port(CLK: in STD_LOGIC;
         OP_LI_DI: in STD_LOGIC_VECTOR(NB-1 downto 0);
         A_DI_EX: in STD_LOGIC_VECTOR(NB-1 downto 0);
         OP_DI_EX: in STD_LOGIC_VECTOR(NB-1 downto 0);
         B_LI_DI: in STD_LOGIC_VECTOR(NB-1 downto 0);
         C_LI_DI: in STD_LOGIC_VECTOR(NB-1 downto 0);
         IP: out STD_LOGIC;
         Alea: out STD_LOGIC
    );
end component;

constant CLK_period: TIME := 10ns;
constant NB: Natural := 16;

signal CLK: STD_LOGIC := '0';
signal OP_LI_DI: STD_LOGIC_VECTOR(NB-1 downto 0) := (others => '0');

begin


end Behavioral;
