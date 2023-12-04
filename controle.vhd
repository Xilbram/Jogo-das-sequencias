library ieee;
use ieee.std_logic_1164.all;

entity controle is port(clock, enter, reset: in std_logic; --btn 1 é enter
end_game, end_sequence, end_round: in std_logic;
R1, E1, E2, E3, E4, E5, E6: out std_logic);

end controle;

architecture arc_controle of controle is

    type STATES is (Init, Setup, Selec, Sequence, Play, Check, Result);
    signal EstadoAtual, ProximoEstado: STATES := Init; -- O sistema começa no estado Init
   
   
begin

    process(clock, reset)
    begin
   
        if reset = '1' then
            EstadoAtual <= Init;
        elsif (clock'event and clock = '1') then
            EstadoAtual <= ProximoEstado;
        end if;
   
    end process;

process(EstadoAtual, enter, end_game, end_sequence, end_round)
    begin
   
        case EstadoAtual is
            when Init => ProximoEstado
            <= Setup; -- Init vai direto para Setup
                R1 <= '1';
                E1 <= '0';
                E2 <= '0';
                E3 <= '0';
                E4 <= '0';
                E5 <= '0';
                E6 <= '0';
           
            when Setup =>
                if enter = '1' then
                    ProximoEstado <= Selec; -- Vai para o estado Select quando enter for pressionado
                else
                    ProximoEstado <= Setup; -- Senão, fica no Setup
                end if;
                R1 <= '0';
                E1 <= '1';
                E2 <= '0';
                E3 <= '0';
                E4 <= '0';
                E5 <= '0';
                E6 <= '0';
               
            when Selec =>
                if (enter = '1') then
                    ProximoEstado <= Sequence; --Vai para o Sequence
                else
                    ProximoEstado <= Selec;
                end if;
                R1 <= '0';
                E1 <= '0';
                E2 <= '1';
                E3 <= '0';
                E4 <= '0';
                E5 <= '0';
                E6 <= '0';
           
            when Sequence =>
                if (end_sequence = '1') then  -- Depois que mostrou sequencia de 4 valores, o end_sequence = 1, logo
                    ProximoEstado <= Play;    -- Vai para o Play
                else
                    ProximoEstado <= Sequence; -- Senão, fica em Sequence
                end if;
                R1 <= '0';
                E1 <= '0';
                E2 <= '0';
                E3 <= '1';
                E4 <= '0';
                E5 <= '0';
                E6 <= '0';
           
            when Play =>
                if (enter = '1') then
                    ProximoEstado <= Check; -- Com enter vai para o Check
                else
                    ProximoEstado <= Play; -- Senão, fica em Play
                end if;
                R1 <= '0';
                E1 <= '0';
                E2 <= '0';
                E3 <= '0';
                E4 <= '1';
                E5 <= '0';
                E6 <= '0';
           
            when Check =>
                if (end_round = '1' or end_game = '1') then
                    ProximoEstado <= Result;  -- Se foi verificado que o jogo/partida acabou, vai para Result
                else
                    ProximoEstado <= selec; -- Senão, fica no Check --Não faz sentido ficar no Check, não?
                end if;
                R1 <= '0';
                E1 <= '0';
                E2 <= '0';
                E3 <= '0';
                E4 <= '0';
                E5 <= '1';
                E6 <= '0';
           
            when Result =>
                if (enter = '1') then
                    ProximoEstado <= Init; -- Se enter, vai para Init
                else
                    ProximoEstado <= Result; -- Senão, fica em Result
                end if;
                R1 <= '0';
                E1 <= '0';
                E2 <= '0';
                E3 <= '0';
                E4 <= '0';
                E5 <= '0';
                E6 <= '1';
               
        end case;
       
    end process;


end arc_controle;    