----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.04.2022 11:54:40
-- Design Name: 
-- Module Name: test_memoire_donnees_16bit - Behavioral
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

entity test_memoire_donnees_16bit is
--  Port ( );
end test_memoire_donnees_16bit;

architecture Behavioral of test_memoire_donnees_16bit is

component memoire_donnees
    generic(NB: Natural := 16);
    Port (
            add : in STD_LOGIC_VECTOR (NB-1 downto 0);
            Input: in STD_LOGIC_VECTOR (NB-1 downto 0);
            RW: in STD_LOGIC;
            RST: in STD_LOGIC;
            CLK: in STD_LOGIC;
            Output: out STD_LOGIC_VECTOR (NB-1 downto 0)
           );
end component;

constant CLK_period: TIME := 10ns;
constant NB: Natural := 16;

signal add: STD_LOGIC_VECTOR (NB-1 downto 0) := (others => '0');
signal Input: STD_LOGIC_VECTOR (NB-1 downto 0) := (others => '0');
signal Output: STD_LOGIC_VECTOR (NB-1 downto 0) := (others => '0');
signal RW: STD_LOGIC := '0';
signal RST: STD_LOGIC := '0';
signal CLK: STD_LOGIC := '0';
signal dec: STD_LOGIC := '0';

begin

memoire_donnees_16: memoire_donnees generic map (NB => NB) Port Map (
   add => add,
   Input => Input,
   RW => RW,
   RST => RST,
   CLK => CLK,
   Output => Output
);

process
begin
    wait for CLK_period/2;
    CLK <= not(CLK);
end process;

process (CLK, dec)
begin
    if rising_edge(CLK) then
        if dec = '0' then
            add <= add + '1';
        else
            add <= add - '1';
        end if;
    end if;
end process;

process (CLK, dec)
begin
    if rising_edge(CLK) then
        if dec = '0' then
            Input <= add;
        end if;
    end if;
end process;

dec <= '1' after 495ns;
RW <= '1' after 495ns;

end Behavioral;
