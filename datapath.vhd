library ieee;
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all; 

entity datapath is port(

    SW: in std_logic_vector(7 downto 0);
    CLK: in std_logic;
	 Enter: in std_logic;
    R1, E1, E2, E3, E4, E5, E6: in std_logic;
	 end_game, end_sequence, end_round: out std_logic;
    HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0: out std_logic_vector(6 downto 0);
    LEDR: out std_logic_vector(17 downto 0));

end datapath;

architecture arc_data of datapath is

-- signals


signal end_gameDebug, end_sequenceDebug, end_roundDebug,clk1, sim_2hz, control, E4_and_clk1, E5_or_E4clk1, E1_or_E5, R1_or_E5, rst_divfreq, count0aux,btn1,btn0, entradaMuxHex0: std_logic;
signal sel, ct_outAux: std_logic_vector(1 downto 0);
signal X: std_logic_vector(2 downto 0);
signal Y, Alpha, Beta, mux_hx7, mux_hx6, d7_hx0_2SEL,entradahex3,entradahex4,entradahex5: std_logic_vector(3 downto 0);
signal dec7_hx7, dec7_hx6, dec7_hx1_1, dec7_hx1_2, dec7_hx1_3, dec7_hx0_1, dec7_hx0_2, dec7_hx0_3, dec7_hx0_4, mux_hx1_1, mux_hx1_2, mux_hx1_3, mux_hx0_1, mux_hx0_2, mux_hx0_3, saidaHex3,saidaHex4,saidaHex5, L: std_logic_vector(6 downto 0);
signal reg8b_out, penalty, T_out, T_BCD, mux_control, mux_time, mux_soma1, mux_soma2, mux_soma3, mux_soma4, soma1, soma2, soma3, Seq, Seq_BCD: std_logic_vector(7 downto 0);
signal muxsomaX3, muxsomaX2, muxsomaX1, muxsomaX0, muxsomaBeta, saidaReg8, saidaMuxE5: std_logic_vector (7 downto 0);
signal termo, play, pisca, end_round_and_pisca, reg16b_in: std_logic_vector(15 downto 0);


----- components
component decod is
port (G: in std_logic_vector(3 downto 0);
Decout: out std_logic_vector(6 downto 0)
);
end component;


component decoder_termometrico is port(
    
    X: in  std_logic_vector(3 downto 0);
    S: out std_Logic_vector(15 downto 0));
    
end component;

component somador is port (
A: in std_logic_vector(7 downto 0);
B: in std_logic_vector(7 downto 0);
S: out std_logic_vector(7 downto 0)
);
end component;

component Div_Freq is -- Usar esse componente para o emulador
	port (	clk: in std_logic;
			reset: in std_logic;
			CLK_1Hz, sim_2hz: out std_logic
			);
end component;

component Div_Freq_DE2 is -- Usar esse componente para a placa DE2
	port (	clk: in std_logic;
			reset: in std_logic;
			CLK_1Hz, sim_2hz: out std_logic
			);
end component;

component counter_seq is port(
		Reset, Enable, Clock  : in  std_logic;
        end_sequence          : out std_logic; -- A saída end_sequence é ativada quando o contador já tiver contado 4 vezes
        seq                   : out std_logic_vector(2 downto 0));
end component;

component counter_time is port(

    Set, Enable, Clock: in  std_logic;
	 Load                     : in  std_logic_vector(7 downto 0);
    end_time                 : out std_logic;
    t_out                    : out std_logic_vector(7 downto 0));
    
end component;

component counter_round is port(

    Set, Enable, Clock: in  std_logic;
    end_round           : out std_logic;
    X                   : out std_logic_vector(3 downto 0));
    
end component;

component DecBCD is port (

	input  : in  std_logic_vector(7 downto 0);
	output : out std_logic_vector(7 downto 0));

end component;

component Reg8b is port(

    D     : in  std_logic_vector(7 downto 0);
    Reset : in  std_Logic;
    Enable: in  std_logic;
    CLK   : in  std_logic;
    Q     : out std_logic_vector(7 downto 0));
	 
end component;

component Reg2b is port(

    D     : in  std_logic_vector(1 downto 0);
    Reset : in  std_Logic;
    Enable: in  std_logic;
    CLK   : in  std_logic;
    Q     : out std_logic_vector(1 downto 0));
    
end component;

component Reg16b is port(

    D     : in  std_logic_vector(15 downto 0);
    Reset : in  std_Logic;
    Enable: in  std_logic;
    CLK   : in  std_logic;
    Q     : out std_logic_vector(15 downto 0));
    
end component;

component Comparador is port(
    
    in0, in1: in  std_logic_vector(7 downto 0);
    S       : out std_logic);
    
end component;

component Mux2_1x4 is port(

    S     : in  std_logic;
    L0, L1: in  std_logic_vector(3 downto 0);
    D     : out std_logic_vector(3 downto 0));
    
end component;

component Mux2_1x8 is port(

    S     : in  std_logic;
    L0, L1: in  std_logic_vector(7 downto 0);
    D     : out std_logic_vector(7 downto 0));
    
end component;

component Mux4_1x8 is port(

    S             : in  std_logic_vector(1 downto 0);
    L0, L1, L2, L3: in  std_logic_vector(7 downto 0);
    D             : out std_logic_vector(7 downto 0));
    
end component;

component Mux2_1x16 is port(

    S     : in  std_logic;
    L0, L1: in  std_logic_vector(15 downto 0);
    D     : out std_logic_vector(15 downto 0));
    
end component;

component Mux2_1x7 is port(

    S     : in  std_logic;
    L0, L1: in  std_logic_vector(6 downto 0);
    D     : out std_logic_vector(6 downto 0));
    
end component;

component ButtonSync is port(

    KEY1, KEY0, CLK: in  std_logic;
    BTN1, BTN0   : out std_logic);

end component;



begin

-- reg16b
reg16b_in <= sw(7 downto 0) & seq_BCD;
reg16b0: reg16b port map(reg16b_in,R1,E4,clk,play);


-- reg8b
reg8b0: reg8b port map(sw(7 downto 0), R1, E2, clk,saidaReg8);
alpha <= saidaReg8(7 downto 4);
beta <= saidaReg8(3 downto 0);


-- lógica da soma da sequência
seq <= ((mux_soma4 + mux_soma3) + (mux_soma2 + mux_soma1)) + ("0000" & beta);
decBCDsoma: decBCD port map(seq, Seq_BCD);


-- comparador 
comparador0: comparador port map(play(7 downto 0), play(15 downto 8), control);



------ HEX ----------------------------

--usando o decod7seg fornecido, "1111" apaga os displays

--HEX7
decod7segHEX7: decod port map(t_bcd(7 downto 4),dec7_hx7); 
hex7 <=  dec7_hx7;

--HEX6
decodHEX6: decod port map(t_bcd(3 downto 0),dec7_hx6); 
hex6 <=  dec7_hx6;


--HEX5
--end_gameDebug <= end_game;
--entradaHex5 <= "000" & end_gameDebug;
--decodHex5: decod port map(entradaHex5,saidaHex5);
HEX5 <= "1111111";

--HEX4
--end_roundDebug <= end_round;
entradaHex4 <= Y;
decodHex4: decod port map(entradaHex4,saidaHex4);
HEX4<= "1111111";

--HEX3 --debug
--end_sequenceDebug <= end_sequence;
entradaHex3 <= '0' & X;
decodHex3: decod port map(entradaHex3,saidaHex3);
HEX3 <= "1111111";

--HEX2
HEX2 <= "1111111";

--HEX1

L <= "1000111";

d7_hx1_1: decod port map("1111", dec7_hx1_1);
d7_hx1_2: decod port map(Seq_BCD(7 downto 4), dec7_hx1_2);
d7_hx1_3: decod port map(SW(7 downto 4), dec7_hx1_3);

mx1hx1: mux2_1x7 port map(E1, dec7_hx1_1, L, mux_hx1_1);
mx2hx1: mux2_1x7 port map(E4, dec7_hx1_2, dec7_hx1_3, mux_hx1_2);
mx3hx1: mux2_1x7 port map(entradaMuxHex0, mux_hx1_1, mux_hx1_2, HEX1);


--HEX0


d7_hx0_2SEL <= "00"&SEL(1 downto 0);
entradaMuxHex0 <= E4 or e3;

d7_hx0_1: decod port map("1111", dec7_hx0_1);
d7_hx0_2: decod port map(d7_hx0_2SEL, dec7_hx0_2);
d7_hx0_3: decod port map(Seq_BCD(3 downto 0), dec7_hx0_3);
d7_hx0_4: decod port map(SW(3 downto 0), dec7_hx0_4);

mx1hx0: mux2_1x7 port map(E1, dec7_hx0_1, dec7_hx0_2, mux_hx0_1);
mx2hx0: mux2_1x7 port map(E4, dec7_hx0_3, dec7_hx0_4, mux_hx0_2);
mx3hx0: mux2_1x7 port map(entradaMuxHex0, mux_hx0_1, mux_hx0_2, HEX0);

---- Reg2b & Penalty
reg2b0: reg2b port map(sw(1 downto 0), R1, E1, clk, SEL);
mux4_1x8Penalty: mux4_1x8 port map(SEL, "11111110","11111100","11111010","11111000",penalty); -- -2,-4,-6,-8 como entradas MUX


-- counter_seq

r1_or_E5 <= r1 or e5;
counterSeq0: counter_seq port map(r1_or_E5, E3, clk1,end_sequence,X);



---- counter_time
e5_or_E4clk1 <= e5 or(e4 and clk1);
counter_timer0: counter_time port map(R1, e5_or_E4clk1, clk,saidaMuxE5,end_game, t_out);


dec7bcd: decBCD port map(T_out, T_bcd);


--- Counter Round

counterRound0: COUnter_round port map(r1, e5, clk, end_round, Y);
dectermo: decoder_termometrico port map(Y, termo);


---- DIV FREQ


rst_divfreq <= E1 or E2;
--divfreq: div_freq_DE2 port map(CLK, rst_divfreq, CLK1, sim_2hz); -- usar este para a placa DE2
divfreq: div_freq port map(clk, rst_divfreq, clk1, sim_2hz); -- usar este para o emulador


---- SAIDA LEDR
pisca <= "1111111111111111" and (Sim_2hz & sim_2hz & Sim_2hz & Sim_2hz & Sim_2hz & Sim_2hz & Sim_2hz & Sim_2hz & Sim_2hz & sim_2hz & Sim_2hz & Sim_2hz & Sim_2hz & Sim_2hz & Sim_2hz & Sim_2hz);
ledr(15 downto 0) <= end_round_and_pisca;





-- Sinais/Entradas logicas



---- Multiplexadores
mux2_1x8Controle: mux2_1x8 port map(control,penalty,"00000000",mux_control);
mux2_1x8E5: mux2_1x8 port map(e5, "11111111", mux_control,saidaMuxE5);

mux2_1x16Ledr: mux2_1x16 port map(e6, termo, pisca,end_round_and_pisca);


muxSomaX3 <= "00"&X&"000";
muxSomaX2 <= "000"&X&"00";
muxSomaX1 <= "0000"&X&"0";
muxSomaX0 <= "00000"&X;

mux2_1x8Alpha3: mux2_1x8 port map(alpha(3), "00000000", muxSomaX3, mux_soma4);
mux2_1x8Alpha2: mux2_1x8 port map(alpha(2), "00000000", muxSomaX2, mux_soma3);
mux2_1x8Alpha1: mux2_1x8 port map(alpha(1), "00000000", muxSomaX1, mux_soma2);
mux2_1x8Alpha0: mux2_1x8 port map(alpha(0), "00000000", muxSomaX0, mux_soma1);


end arc_Data;
