----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.04.2022 09:30:15
-- Design Name: 
-- Module Name: processeur - Behavioral
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
library banc_registres;
library memoire_instructions;
library memoire_donnees;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity processeur_16bit is
--  Port ( );
end processeur_16bit;


architecture Behavioral of processeur_16bit is

-- Constante de période d'horloge
constant CLK_period: TIME := 10ns;
-- Constante de nombre de bits de l'architecture
constant NB: natural := 16;

-- Signal d'horloge du processeur
signal CLK: STD_LOGIC := '1';
-- Signal de reset du processeur
signal RST: STD_LOGIC := '1';


-- Pointeur d'instruction
signal IP: STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
-- Sortie de la mémoire d'instructions
signal Output: STD_LOGIC_VECTOR (63 downto 0) := (others => '0');

-- Sortie QB du banc de registre
signal QB: STD_LOGIC_VECTOR (15 downto 0) := (others => '0');

-- Flags de l'ALU
signal N: STD_LOGIC := '0';
signal O: STD_LOGIC := '0';
signal Z: STD_LOGIC := '0';
signal C: STD_LOGIC := '0';

-- MUX à la sortie de QA
signal MUX_QA: STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
-- MUX à la sortie de l'ALU
signal MUX_ALU: STD_LOGIC_VECTOR (15 downto 0) := (others => '0');

-- Comparateur logique au niveau 3
-- Identification de l'opération logique à appliquer
signal LC_ALU: STD_LOGIC_VECTOR (2 downto 0) := (others => '0');
-- Comparateur logique au niveau 5
-- Activation ou non du bit d'écriture en mémoire
signal LC_RE: STD_LOGIC := '0';

-- Mémoire d'instructions du processeur
component memoire_instructions_16bit
    Port ( add : in STD_LOGIC_VECTOR (15 downto 0);
           CLK : in STD_LOGIC;
           Output : out STD_LOGIC_VECTOR (63 downto 0));
end component;

-- Pipeline LI/DI
signal A_LI_DI: STD_LOGIC_VECTOR (NB-1 downto 0) := (others => '0'); 
signal OP_LI_DI: STD_LOGIC_VECTOR (NB-1 downto 0) := (others => '0'); 
signal B_LI_DI: STD_LOGIC_VECTOR (NB-1 downto 0) := (others => '0'); 
signal C_LI_DI: STD_LOGIC_VECTOR (NB-1 downto 0) := (others => '0');

-- Banc de registres
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

-- Pipeline DI/EX
signal A_DI_EX: STD_LOGIC_VECTOR (NB-1 downto 0) := (others => '0'); 
signal OP_DI_EX: STD_LOGIC_VECTOR (NB-1 downto 0) := (others => '0'); 
signal B_DI_EX: STD_LOGIC_VECTOR (NB-1 downto 0) := (others => '0');
signal C_DI_EX: STD_LOGIC_VECTOR (NB-1 downto 0) := (others => '0');

-- Unité arithmétique et logique
component alu
    generic (NB: Natural := 16);
    Port ( A : in STD_LOGIC_VECTOR (NB-1 downto 0);
           B : in STD_LOGIC_VECTOR (NB-1 downto 0);
           Ctrl_Alu : in STD_LOGIC_VECTOR (2 downto 0);
           S : out STD_LOGIC_VECTOR (NB-1 downto 0);
           N : out STD_LOGIC;
           O : out STD_LOGIC;
           Z : out STD_LOGIC;
           C : out STD_LOGIC);
end component;

-- Pipeline EX/Mem
signal A_EX_Mem: STD_LOGIC_VECTOR (NB-1 downto 0) := (others => '0'); 
signal OP_EX_Mem: STD_LOGIC_VECTOR (NB-1 downto 0) := (others => '0'); 
signal B_EX_Mem: STD_LOGIC_VECTOR (NB-1 downto 0) := (others => '0');

-- Mémoire des données
component memoire_donnees
    generic(NB: Natural := 16);
    Port ( add : in STD_LOGIC_VECTOR (NB-1 downto 0);
           Input: in STD_LOGIC_VECTOR (NB-1 downto 0);
           RW: in STD_LOGIC;
           RST: in STD_LOGIC;
           CLK: in STD_LOGIC;
           Output: out STD_LOGIC_VECTOR (NB-1 downto 0));
end component;

-- Pipeline Mem/RE
signal A_Mem_RE: STD_LOGIC_VECTOR (NB-1 downto 0) := (others => '0'); 
signal OP_Mem_RE: STD_LOGIC_VECTOR (NB-1 downto 0) := (others => '0'); 
signal B_Mem_RE: STD_LOGIC_VECTOR (NB-1 downto 0) := (others => '0');

begin

-- Instanciation de la mémoire d'instruction
memoire_instructions_16: memoire_instructions_16bit Port Map (
   add => IP,
   CLK => CLK,
   Output => Output
);

-- Instanciation du banc de registres
banc_registre_16: banc_registres generic map (NB => NB) Port Map (
    addA => B_LI_DI(3 downto 0),
    addB => C_LI_DI(3 downto 0),
    addW => A_Mem_RE(3 downto 0),
    W => LC_RE,
    DATA => B_Mem_RE,
    RST => RST,
    CLK => CLK,
    QA => MUX_QA,
    QB => QB
);

alu_16: alu generic map (NB => NB) port map (
    A => B_DI_EX,
    B => C_DI_EX,
    Ctrl_Alu => LC_ALU,
    S => MUX_ALU,
    N => N,
    O => O,
    Z => Z,
    C => C
);

-- Processus de mise à jour de l'horloge
process
begin
    wait for CLK_period/2;
    CLK <= not(CLK);
end process;

-- Processus de mise à jour du pointeur d'instruction
process
begin
    wait until rising_edge(CLK);
    IP <= IP + '1';
end process;

-- Décalage des valeurs de A dans les pipelines
process
begin
    wait until rising_edge(CLK);
    A_LI_DI <= Output((NB*3)-1 downto NB*2);
    A_DI_EX <= A_LI_DI;
    A_EX_Mem <= A_DI_EX;
    A_Mem_RE <= A_EX_Mem;
end process;

-- Décalage des valeurs de OP dans les pipelines
process
begin
    wait until rising_edge(CLK);
    OP_LI_DI <= Output((NB*4)-1 downto NB*3);
    OP_DI_EX <= OP_LI_DI;
    OP_EX_Mem <= OP_DI_EX;
    OP_Mem_RE <= OP_EX_Mem;
end process;

-- Décalage des valeurs de B dans les pipelines
process
begin
    wait until rising_edge(CLK);
    B_LI_DI <= Output((NB*2)-1 downto NB);
    if OP_LI_DI > X"08" and OP_LI_DI < X"0C"then
        B_DI_EX <= B_LI_DI;
    else
        B_DI_EX <= MUX_QA;
    end if;
    if OP_DI_EX > X"7" then
        B_EX_Mem <= B_DI_EX;
    else
        B_EX_Mem <= MUX_ALU;
    end if;
    B_Mem_RE <= B_EX_Mem;
end process;

-- Décalage des valeurs de C dans les pipelines
process
begin
    wait until rising_edge(CLK);
    C_LI_DI <= Output(NB-1 downto 0);
    C_DI_EX <= QB;
end process;

-- Transmission de l'instruction dans l'ALU
-- Uniquement si valeur inférieure à 8
LC_ALU <= OP_DI_EX(2 downto 0) when OP_DI_EX < X"8"
          else "000";

-- Écriture dans le banc de registres
-- NOP = 00
-- JMP = 0C
-- JMF = 0D
LC_RE <= '0' when OP_Mem_RE = X"0C" 
             or OP_Mem_RE = X"0D"
             or OP_Mem_RE = X"00"
             else '1';
             

end Behavioral;
