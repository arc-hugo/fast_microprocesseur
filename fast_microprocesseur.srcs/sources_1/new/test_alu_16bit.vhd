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



alu_16: alu port map (
    A => A_local,
    B => B_local,
    Ctrl_Alu => Ctrl_Alu_local,
    S => S_local,
    N => N_local,
    O => O_local,
    Z => Z_local,
    C => C_local
);
begin

end component;

begin


end Behavioral;
