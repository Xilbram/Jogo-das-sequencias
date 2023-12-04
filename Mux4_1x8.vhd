library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity Mux4_1x8 is port (
    S             : in  std_logic_vector(1 downto 0);
    L0, L1, L2, L3: in  std_logic_vector(7 downto 0);
    D             : out std_logic_vector(7 downto 0));
end Mux4_1x8;
        
architecture arqdtp of Mux4_1x8 is
    begin
    
     D <=   L0  when s <= "00" else
            L1  when s <= "01" else
            L2  when s <= "10" else
		    L3;	   
		    
end arqdtp;
