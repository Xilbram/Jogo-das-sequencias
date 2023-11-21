library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity counter_round is
  port (
    Set, Enable, Clock: in  std_logic;
    end_round         : out std_logic;
    X                 : out std_logic_vector(3 downto 0)
  );
end counter_round;


architecture arqround of counter_round is
  signal termo : std_logic_vector(15 downto 0) := (others => '0');

begin

  process (Clock, Set, Enable)
    variable temporary_count : unsigned(3 downto 0) := (others => '0');--inicializar todos os elementos do vetor com '0'
  begin
    if Set = '1' then
      temporary_count := (others => '0');
      termo <= (others => '0');
      end_round <= '0';
    elsif rising_edge(Clock) then --garante que operações desse processo só ocorram no instante da borda de subida do sinal de clock
      if Enable = '1' then
        if temporary_count < 15 then      ----------------------------------------------> - REVER - <-------------------------------------------------
          temporary_count := temporary_count + 1;
          termo <= '1' & termo(15 downto 1);
        else
          end_round <= '1';
        end if;
      end if;
    end if;
  end process;

  X <= termo(3 downto 0);

end arqround;
