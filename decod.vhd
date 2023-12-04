library IEEE;
use IEEE.Std_Logic_1164.all;


entity decod is
port (G: in std_logic_vector(3 downto 0);
Decout: out std_logic_vector(6 downto 0)
);
end decod;


architecture decodificador of decod is
begin
Decout <= "1000000" when G = "0000" else
"1111001" when G = "0001" else
"0100100" when G = "0010" else
"0110000" when G = "0011" else
"0011001" when G = "0100" else
"0010010" when G = "0101" else
"0000010" when G = "0110" else
"1111000" when G = "0111" else
"0000000" when G = "1000" else
"0011000" when G = "1001" else --9
"0001000" when G = "1010" else --A
"0000011" when G = "1011" else--B
"1000110" when G = "1100" else--C
"0100001" when G = "1101" else--D
"0000110" when G = "1110" else--E
"0001110" when G = "1111" else--F
"0111111"; -- DEBUG
end decodificador;