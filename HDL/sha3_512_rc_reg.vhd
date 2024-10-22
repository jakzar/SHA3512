----------------
--Jakub Zaroda--
----------------

--modul sluzacy do wyznaczania wartosci zmiennej rundowej RC
-- logika dzialania opiera sie na konstrukcji CASE, ktora jako parametr przyjmuje numer rundy, a zwraca wartosc zmiennej RC

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sha3_512_rc_reg is port(
    in_round_number       : in std_logic_vector (5 downto 0);       --magistrala wejsciowa zawierajaca numer rundy (6 bitowa)
    out_rc     : out std_logic_vector (63 downto 0)                 --magistrala wyjsciowa zawierajaca wartosc zmiennej RC (64 bitowa)
);
end sha3_512_rc_reg;

architecture behaviour of sha3_512_rc_reg is
begin
    process(in_round_number)
    begin
        case in_round_number is                                     --konstrukcja case, przypisanie wartosci zgodnie z dokumentacja, po zastosowaniu zapisu LE
            when "000000" => out_rc <= x"0100000000000000";
            when "000001" => out_rc  <= x"8280000000000000";
            when "000010" => out_rc  <= x"8a80000000000080";
            when "000011" => out_rc  <= x"0080008000000080";
            when "000100" => out_rc  <= x"8b80000000000000";
            when "000101" => out_rc  <= x"0100008000000000";
            when "000110" => out_rc  <= x"8180008000000080";
            when "000111" => out_rc  <= x"0980000000000080";
            when "001000" => out_rc  <= x"8a00000000000000";
            when "001001" => out_rc  <= x"8800000000000000";
            when "001010" => out_rc  <= x"0980008000000000";
            when "001011" => out_rc  <= x"0a00008000000000";
            when "001100" => out_rc  <= x"8b80008000000000";
            when "001101" => out_rc  <= x"8b00000000000080";
            when "001110" => out_rc <=  x"8980000000000080";
            when "001111" => out_rc  <= x"0380000000000080";
            when "010000" => out_rc  <= x"0280000000000080";
            when "010001" => out_rc  <= x"8000000000000080";
            when "010010" => out_rc <=  x"0a80000000000000";
            when "010011" => out_rc  <= x"0a00008000000080";
            when "010100" => out_rc  <= x"8180008000000080";
            when "010101" => out_rc <=  x"8080000000000080";
            when "010110" => out_rc <=  x"0100008000000000";
            when "010111" => out_rc <=  x"0880008000000080";
            when others => out_rc <= x"0000000000000000";

        end case;
    end process;
end behaviour;