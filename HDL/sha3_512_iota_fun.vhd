----------------
--Jakub Zaroda--
----------------

--modul realizujacy funkcje Iota()
--do rejestrow pomocniczych dane nie musza byc wczytywane w konwencji LE, poniewaz nie beda wykonywane zadne rotacjie na tych rejestrach
--umozliwia to wprost przepisanie na wyjscie danych z magistrali wyjsciowej bez koniecznosci kolejnej zamiany sposobu zapisu bajtow
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sha3_512_iota_fun is port(
    in_data      : in std_logic_vector (1599 downto 0);     --magistrala wejsciowa stanu algorytmu 1600b
    in_RC        : in std_logic_vector (63 downto 0);       --magistrala wejsciowa zmiennej rundowej RC 64b (LE)
    out_data     : out std_logic_vector (1599 downto 0)     --magistrala wyjsciowa stanu algorytmu 1600b
);
end sha3_512_iota_fun;

architecture behaviour of sha3_512_iota_fun is
    --rejestry pomocnicze przechowujace wartosci "linii"
    signal a_0_0  : std_logic_vector (63 downto 0);
    signal a_1_0  : std_logic_vector (63 downto 0);
    signal a_2_0  : std_logic_vector (63 downto 0);
    signal a_3_0  : std_logic_vector (63 downto 0);
    signal a_4_0  : std_logic_vector (63 downto 0);

    signal a_0_1  : std_logic_vector (63 downto 0);
    signal a_1_1  : std_logic_vector (63 downto 0);
    signal a_2_1  : std_logic_vector (63 downto 0);
    signal a_3_1  : std_logic_vector (63 downto 0);
    signal a_4_1  : std_logic_vector (63 downto 0);

    signal a_0_2  : std_logic_vector (63 downto 0);
    signal a_1_2  : std_logic_vector (63 downto 0);
    signal a_2_2  : std_logic_vector (63 downto 0);
    signal a_3_2  : std_logic_vector (63 downto 0);
    signal a_4_2  : std_logic_vector (63 downto 0);

    signal a_0_3  : std_logic_vector (63 downto 0);
    signal a_1_3  : std_logic_vector (63 downto 0);
    signal a_2_3  : std_logic_vector (63 downto 0);
    signal a_3_3  : std_logic_vector (63 downto 0);
    signal a_4_3  : std_logic_vector (63 downto 0);

    signal a_0_4  : std_logic_vector (63 downto 0);
    signal a_1_4  : std_logic_vector (63 downto 0);
    signal a_2_4  : std_logic_vector (63 downto 0);
    signal a_3_4  : std_logic_vector (63 downto 0);
    signal a_4_4  : std_logic_vector (63 downto 0);

begin
    a_0_0 <= in_data(1599 downto 1536);
    a_1_0 <= in_data(1535 downto 1472);
    a_2_0 <= in_data(1471 downto 1408);
    a_3_0 <= in_data(1407 downto 1344);
    a_4_0 <= in_data(1343 downto 1280);

    a_0_1 <= in_data(1279 downto 1216);
    a_1_1 <= in_data(1215 downto 1152);
    a_2_1 <= in_data(1151 downto 1088);
    a_3_1 <= in_data(1087 downto 1024);
    a_4_1 <= in_data(1023 downto 960);

    a_0_2 <= in_data(959 downto 896);
    a_1_2 <= in_data(895 downto 832);
    a_2_2 <= in_data(831 downto 768);
    a_3_2 <= in_data(767 downto 704);
    a_4_2 <= in_data(703 downto 640);

    a_0_3 <= in_data(639 downto 576);
    a_1_3 <= in_data(575 downto 512);
    a_2_3 <= in_data(511 downto 448);
    a_3_3 <= in_data(447 downto 384);
    a_4_3 <= in_data(383 downto 320);

    a_0_4 <= in_data(319 downto 256);
    a_1_4 <= in_data(255 downto 192);
    a_2_4 <= in_data(191 downto 128);
    a_3_4 <= in_data(127 downto 64);
    a_4_4 <= in_data(63 downto 0);


    out_data(1599 downto 1536) <= a_0_0 xor in_RC;      --wykonanie operacji xor ze zmienna RC
    out_data(1535 downto 1472) <= a_1_0;
    out_data(1471 downto 1408) <= a_2_0;
    out_data(1407 downto 1344) <= a_3_0;
    out_data(1343 downto 1280) <= a_4_0;
    out_data(1279 downto 1216) <= a_0_1;
    out_data(1215 downto 1152) <= a_1_1;
    out_data(1151 downto 1088) <= a_2_1;
    out_data(1087 downto 1024) <= a_3_1;
    out_data(1023 downto 960) <= a_4_1;
    out_data(959 downto 896) <= a_0_2;
    out_data(895 downto 832) <= a_1_2;
    out_data(831 downto 768) <= a_2_2;
    out_data(767 downto 704) <= a_3_2;
    out_data(703 downto 640) <= a_4_2;
    out_data(639 downto 576) <= a_0_3;
    out_data(575 downto 512) <= a_1_3;
    out_data(511 downto 448) <= a_2_3;
    out_data(447 downto 384) <= a_3_3;
    out_data(383 downto 320) <= a_4_3;
    out_data(319 downto 256) <= a_0_4;
    out_data(255 downto 192) <= a_1_4;
    out_data(191 downto 128) <= a_2_4;
    out_data(127 downto 64) <= a_3_4;
    out_data(63 downto 0) <= a_4_4;
   

end behaviour;