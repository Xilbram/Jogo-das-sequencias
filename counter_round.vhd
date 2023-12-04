library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity counter_round is
    port (
        Set, Enable, Clock: in  std_logic;
        end_round         : out std_logic;
        X                 : out std_logic_vector(3 downto 0)
    );
end counter_round;

architecture arqround of counter_round is
    signal counter:std_logic_vector(3 downto 0);

begin
    process (Clock, Set, Enable)
    begin
        if (Set='1') then
            counter <= "1111";
            --counter <= "0011";

        elsif(Clock'event and Clock='1') then
            if(Enable='1') then
                if(counter < "0001") then 
                    end_round <= '1';
                else
                    counter <= counter - '1';
                    end_round <= '0';
                end if;
            end if;
        end if;
    end process;

    X <= counter;

end arqround;


