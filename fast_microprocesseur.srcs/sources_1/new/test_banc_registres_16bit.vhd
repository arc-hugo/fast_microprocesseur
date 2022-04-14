----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.04.2022 10:49:29
-- Design Name: 
-- Module Name: test_banc_registres_16bit - Behavioral
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

entity test_banc_registres_16bit is
--  Port ( );
end test_banc_registres_16bit;

architecture Behavioral of test_banc_registres_16bit is

component banc_registres
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
end component;

constant CLK_period: TIME := 10ns;
constant NB: Natural := 16;

signal addA: STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
signal addB: STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
signal addW: STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
signal DATA: STD_LOGIC_VECTOR (NB-1 downto 0) := (others => '0');
signal QA: STD_LOGIC_VECTOR (NB-1 downto 0) := (others => '0');
signal QB: STD_LOGIC_VECTOR (NB-1 downto 0) := (others => '0');
signal W: STD_LOGIC := '0';
signal RST: STD_LOGIC := '0';
signal CLK: STD_LOGIC := '0';

begin

banc_registres_16: banc_registres generic map (NB => NB) Port Map (
    addA => addA,
    addB => addB,
    addW => addW,
    W => W,
    DATA => DATA,
    RST => RST,
    CLK => CLK,
    QA => QA,
    QB => QB
);

process
begin
    CLK <= not(CLK);
    wait for CLK_period/2;
end process;

addA <= X"5" after 100ns;
addB <= X"1", X"F" after 100ns;
addW <= X"5" after 150ns, X"F" after 160ns;
W <= '1' after 150ns, '0' after 200ns;
DATA <= X"FFFF" after 150ns;
RST <= '1' after 500ns;

end Behavioral;
