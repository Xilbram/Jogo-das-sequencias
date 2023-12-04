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
    
    signal count: std_logic_vector(7 downto 0);
    
begin
    
    process(Clock, Set, Enable, Load)
    
    begin
    
        if (Set = '1') then
        --count <= "00000011";
        count <= "01100011";
        elsif (Clock'event and Clock='1') then
            if (Enable='1') then
	        	count <= count + Load;
            end if;
        end if;
    end process;
	end_time <= '1' when (count < "00000001") else '0';

    t_out <= count;

end arqtime;
