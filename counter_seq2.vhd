library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity counter_seq2 is
    port (
        Reset, Enable, Clock  : in  std_logic;
        end_sequence          : out std_logic; -- A saída end_sequence é ativada quando o contador já tiver contado 4 vezes
        seq                   : out std_logic_vector(2 downto 0);
        count0                : out std_logic;
        ct_out                : out std_logic_vector(1 downto 0) -- Saída da contagem
    );
end counter_seq2;

architecture arq_counterseq of counter_seq2 is
    signal counter       : std_logic_vector(1 downto 0) := "00"; -- Sinal de 2 bits com valor inicial 0
    signal alpha, beta, X : std_logic_vector(3 downto 0) := "0000";
    signal F              : std_logic_vector(2 downto 0) := "000"; -- Valor atual de F

begin
    process (Clock, Reset)
    variable temporary_alpha_X : unsigned(7 downto 0); --Teve que ser declarado como variável, devido a sobrecarga do operador +
    variable temporary_result : unsigned(7 downto 0); --Dessa forma, os valores intermediários de + e * ficam armazenados nas variáveis 
    begin
        if (Reset = '1') then
            counter <= "00";
            count0  <= '0';
            F       <= ("000"); -- Inicializa F com '000'
            end_sequence <= '0';
        elsif (Enable = '1' and rising_edge(Clock)) then --garante que operações desse processo só ocorram no instante da borda de subida do sinal de clock
            if (counter = "11") then
                counter <= "00";
                count0  <= '1';
                
                -- Resultados intermediários armazenados
                temporary_alpha_X := unsigned(alpha) * unsigned(X);
                temporary_result := temporary_alpha_X + unsigned(beta);

                F <= std_logic_vector(temporary_result);
                end_sequence <= '1';
            else
                counter <= counter + "01";
                count0  <= '0';
                end_sequence <= '0';
            end if;
        end if;
    end process;

    seq     <= F;
    ct_out  <= counter; -- Saída recebe contador

end arq_counterseq;
