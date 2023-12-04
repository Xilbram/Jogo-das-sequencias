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
	signal contador: std_logic_vector(2 downto 0);
begin
    process (Clock, Reset)
    begin
		if (reset = '1') then
			contador <= "000";
            end_sequence <= '0';
		elsif(Clock'event and Clock='1') then
		     if (Enable='1') then
                if(contador="011") then
                    end_sequence <= '1';

                else
                    contador <= contador +'1';
                    end_sequence <= '0';
                end if;
            end if;
		end if;
    end process;
    
    seq <= contador;
end arq_counterseq;