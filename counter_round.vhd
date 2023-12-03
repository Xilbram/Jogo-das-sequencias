library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_round is
    port (
        Set, Enable, Clock: in  std_logic;
        end_round         : out std_logic;
        X                 : out std_logic_vector(3 downto 0)
    );
end counter_round;

architecture arqround of counter_round is
    signal termo : unsigned(3 downto 0) := "1111";

begin

    process (Clock, Set, Enable)
        variable temporary_count : unsigned(3 downto 0) := (others => '0'); -- Não funcionou como sinal, deixei como variavel msm
    begin
        if Set = '1' then
            termo <= "1111";
            temporary_count := (others => '0');
            end_round <= '0';
        elsif rising_edge(Clock) then
            if Enable = '1' then
                if temporary_count > 0 then
                    temporary_count := temporary_count - "0001";
                    termo <= ('1' & termo(3 downto 0));
                else
                    end_round <= '1';
                end if;
            end if;
        end if;
    end process;

    X <= std_logic_vector(termo(3 downto 0));

end arqround;


-------------------ARQUIVO ANTERIOR----------------------------

--library ieee;
--use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;

--entity counter_round is
--    port (
--        Set, Enable, Clock: in  std_logic;
--        end_round         : out std_logic;
--        X                 : out std_logic_vector(3 downto 0)
--    );
--end counter_round;

--architecture arqround of counter_round is
--    signal termo : unsigned(15 downto 0) := (others => '0');

--begin

--    process (Clock, Set, Enable)
--        variable temporary_count : unsigned(3 downto 0) := (others => '0'); -- Não funciona como sinal
--    begin
--        if Set = '1' then
--            termo <= (others => '0');
--            temporary_count := (others => '0');
--            end_round <= '0';
--        elsif rising_edge(Clock) then
--            if Enable = '1' then
--                if temporary_count < 15 then              ------------------ rever -------------------
--                    temporary_count := temporary_count + "0001";
--                    termo <= ('1' & termo(15 downto 1));
--                else
--                    end_round <= '1';
--                end if;
--            end if;
--        end if;
--    end process;

--    X <= std_logic_vector(termo(3 downto 0));

--end arqround;
