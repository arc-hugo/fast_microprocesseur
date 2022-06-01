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
         Output_OP: in STD_LOGIC_VECTOR(NB-1 downto 0);
         Output_B: in STD_LOGIC_VECTOR(NB-1 downto 0);
         Output_C: in STD_LOGIC_VECTOR(NB-1 downto 0);
         A_LI_DI: in STD_LOGIC_VECTOR(NB-1 downto 0);
         OP_LI_DI: in STD_LOGIC_VECTOR(NB-1 downto 0);
         A_DI_EX: in STD_LOGIC_VECTOR(NB-1 downto 0);
         OP_DI_EX: in STD_LOGIC_VECTOR(NB-1 downto 0);
         A_EX_Mem: in STD_LOGIC_VECTOR(NB-1 downto 0);
         OP_EX_Mem: in STD_LOGIC_VECTOR(NB-1 downto 0);
         Alea: out STD_LOGIC := '0'
    );
end gestion_alea;

architecture Behavioral of gestion_alea is

signal Count: STD_LOGIC_VECTOR(1 downto 0) := "00";

begin

process
begin
    wait until rising_edge(CLK);
    if Count > X"1" then
        Alea <= '1';
        Count <= Count - '1';
    elsif Output_OP > X"0" and Output_OP < X"9" then
        if OP_LI_DI > X"0" and OP_LI_DI < X"C"
           and (A_LI_DI = Output_B
                or (A_LI_DI = Output_C and Output_OP < X"8"))
                then
            Alea <= '1';
            Count <= "11";            
        elsif OP_DI_EX > X"0" and OP_DI_EX < X"C"
            and (A_DI_EX = Output_B
                 or (A_DI_EX = Output_C and Output_OP < X"8"))
                 then
            Alea <= '1';
            Count <= "10";
        elsif OP_EX_Mem > X"0" and OP_EX_Mem < X"C"
              and (A_EX_Mem = Output_B
                   or (A_EX_Mem = Output_C and Output_OP < X"8"))
                   then
            Alea <= '1';
            Count <= "01";
        end if;
    else
        Alea <= '0';
    end if;
end process;

end Behavioral;
