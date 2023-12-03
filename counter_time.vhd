library ieee;
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;

entity counter_time is
    port (
        Set, Enable, Clock: in  std_logic;
        Load             : in  std_logic_vector(7 downto 0);
        end_time         : out std_logic;
        t_out            : out std_logic_vector(7 downto 0)
    );
end counter_time;

architecture arqtime of counter_time is
    
    signal count: std_logic_vector(7 downto 0) := "01100011";
    
begin
    
    process(Clock, Set, Enable, Load)
    
    begin
    
        if (Set = '1') then
            count <= count - Load;
        elsif (Enable = '1' and (Clock'event and clock='1')) then --garante que operações desse processo só ocorram no instante da borda de subida do sinal de clock
            if (count = "00000000") then  -- Contagem zerou
                count <= (others => '0');  --inicializar todos os elementos do vetor com '0'
                end_time <= '1';
            else
                count <= count - "00000001";
                end_time <= '0';
            end if;
            
        end if;
        
    end process;

    t_out <= count;

end arqtime;
