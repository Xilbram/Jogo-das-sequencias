library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

--usado no estado de setup
entity reg2b is port (
            D: in  std_logic_vector(1 downto 0);
            Reset : in  std_Logic;
            Enable: in  std_logic;
            CLK   : in  std_logic;
            Q     : out std_logic_vector(1 downto 0));
end reg2b;
        
architecture arqdtp of reg2b is
    begin
    process(CLK,reset)
    begin
        if(Enable = '1') then
            if(reset = '1') then
                q <= "00";
            elsif(CLK'event AND CLK = '1') then
    				q <= D;		
            end if;
        end if;
    end process;
	 
end arqdtp;
