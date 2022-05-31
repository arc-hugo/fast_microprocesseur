----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.05.2022 13:32:14
-- Design Name: 
-- Module Name: gestion_alea - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity gestion_alea is
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
end gestion_alea;

architecture Behavioral of gestion_alea is

signal Count: STD_LOGIC_VECTOR(1 downto 0) := "00";

begin

process (OP_LI_DI)
begin
    
end process;

process
begin
    wait until rising_edge(CLK);
    if Count > X"1" then
        Alea <= '1';
        Count <= Count - '1';
        IP <= '0';
    elsif OP_DI_EX < X"C" and OP_DI_EX > X"0" and OP_LI_DI > X"0"
                and ((A_DI_EX = B_LI_DI and OP_LI_DI < X"9")
                     or (A_DI_EX = C_LI_DI and OP_LI_DI < X"8")) then
        Alea <= '1';
        Count <= "11";
        IP <= '0';
    else
        Alea <= '0';
        if Count > X"0" then
            IP <= '0';
            Count <= Count - '1';
        else
            IP <= '1';
        end if;
    end if;
end process;

end Behavioral;
