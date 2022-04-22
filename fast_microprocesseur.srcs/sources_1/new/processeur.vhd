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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity processeur is
--  Port ( );
end processeur;


architecture Behavioral of processeur is

-- Constante de période d'horloge
constant CLK_period: TIME := 10ns;
-- Constante de nombre de bits de l'architecture
constant NB: Natural := 16;

-- Signal d'horloge
signal CLK: STD_LOGIC := '0';
-- Signal de reset
signal RST: STD_LOGIC := '0';
-- Pointeur d'instruction
signal IP: STD_LOGIC_VECTOR (NB-1 downto 0) := (others => '0');
-- Sortie de la mémoire d'instructions
signal Output: STD_LOGIC_VECTOR ((NB*4)-1 downto 0) := (others => '0');
-- MUX à la sortie de QA
signal MUX_QA: STD_LOGIC_VECTOR (NB-1 downto 0) := (others => '0');
-- Comparateur logique
signal LC_Mem_RE: STD_LOGIC:= '0';

-- Mémoire d'instructions du processeur
component memoire_instructions
    generic(NB: Natural := 16);
    Port ( add : in STD_LOGIC_VECTOR (NB-1 downto 0);
           CLK : in STD_LOGIC;
           Output : out STD_LOGIC_VECTOR (31 downto 0));
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

memoire_instructions_16: memoire_instructions generic map (NB => NB) Port Map (
   add => IP,
   CLK => CLK,
   Output => Output
);

A_LI_DI <= Output((NB*4)-1 downto NB*3);
OP_LI_DI <= Output((NB*3)-1 downto NB*2);
B_LI_DI <= Output((NB*2)-1 downto NB);
C_LI_DI <= Output(NB-1 downto 0);

banc_registre_16: banc_registres generic map (NB => NB) Port Map (
    addA => A_LI_DI(3 downto 0),
    addB => C_LI_DI(3 downto 0),
    addW => A_Mem_RE(3 downto 0),
    W => LC_Mem_RE,
    DATA => B_Mem_RE,
    RST => RST,
    CLK => CLK,
    QA => MUX_QA,
    QB => C_DI_EX
);

A_DI_EX <= A_LI_DI when rising_edge(CLK);
OP_DI_EX <= OP_LI_DI when rising_edge(CLK);
B_DI_EX <= MUX_QA when rising_edge(CLK);

A_EX_Mem <= A_DI_EX when rising_edge(CLK);
OP_EX_Mem <= OP_DI_EX when rising_edge(CLK);
B_EX_Mem <= B_DI_EX when rising_edge(CLK);

A_Mem_RE <= A_EX_Mem when rising_edge(CLK);
OP_Mem_RE <= OP_EX_Mem when rising_edge(CLK);
B_Mem_RE <= B_EX_Mem when rising_edge(CLK);



end Behavioral;
