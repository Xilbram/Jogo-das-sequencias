library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity counter_seq is
    port (
        Reset, Enable, Clock  : in  std_logic;
        end_sequence          : out std_logic; -- A saída end_sequence é ativada quando o contador já tiver contado 4 vezes
        seq                   : out std_logic_vector(2 downto 0)
    );
end counter_seq;

architecture arq_counterseq of counter_seq is
	signal tc: std_logic_vector(1 downto 0);
	signal contador: std_logic_vector(2 downto 0);
begin
    process (Clock, Reset)
    begin
		if reset = '1' then
			contador <= "000";
			tc <= "00";
		elsif (Clock'event and Clock = '1') then
			contador <= contador + 1;
			tc <= tc + 1;
		if tc = "11" then
			tc <= "00";
			end_sequence <= '1';
			seq <= contador;
		end if;
		end if;
    end process;
end arq_counterseq;
