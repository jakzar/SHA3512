----------------
--Jakub Zaroda--
----------------

--modul przechowujacy rejestr stanu algorytmu oraz rejestr zawierajacy ostatnio obliczony skrot
--rejestr moze byc przywrocony do ustawien domyslnych
--rejestr moze wpisywac dane z zewnatrz badz z wnetrza koprocesora

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sha3_512_state_reg is port(
    in_clk       : in std_logic;                                --wejscie sygnalu zegarowego
    in_state_data   :   in std_logic_vector (1599 downto 0);    --magistrala wejsciowa danych z funkcji przetwarzajacej stan algorytmu 1600b
    in_padded_data   :   in std_logic_vector (575 downto 0);    --magistrala wejsciowa danych z zewnatrz 576b
    in_hash_init    :   in std_logic;                           --sygnal inicjalizacji stanu poczatkowego rejestru przechowujacego wartosc funkcji skrotu
    in_hash_wr      :   in std_logic;                           --sygnal zapisu do rejestru przechowujacego wartosc funkcji skrotu
    in_state_init   :   in  std_logic;                          --sygnal inicjalizacji stanu poczatkowego rejestru przechowujacego stan algorytmu
    in_state_wr     :   in  std_logic;                          --sygnal zapisu do rejestru przechowujacego stan algorytmu
    in_padded_value_wr : in std_logic;                          --sygnal zapisu danych z zewnatrz
    out_ext_data    :   out std_logic_vector (511 downto 0);    --magistrala wyjsciowa zawierajaca wartosc funkcji skrotu 512b
    out_int_data    :   out std_logic_vector (1599 downto 0)    --magistrala wyjsciowa zawierajaca obecny stan algorytmu
);
end sha3_512_state_reg;

architecture behaviour of sha3_512_state_reg is
    signal reg_state : std_logic_vector (1599 downto 0) := (others => '0');     --rejestr przechowujacy stan algorytmu
    signal reg_hash : std_logic_vector (511 downto 0) := (others => '0');       --rejestr przechowujacy wartosc ostatnio obliczonego skrotu
begin
    process(in_clk)
    begin
        if(rising_edge(in_clk)) then
            if(in_hash_init='1') then                                           --jesli sygnal in_hash_init jest w stanie wysokim
                reg_hash <= (others => '0');                                    --rejestr reg_hash inicjowany jest zerami
            end if; 

            if(in_hash_wr='1') then                                             --jesli sygnalin_hash_wr jest w stanie wysokim
                reg_hash <= in_state_data (1599 downto 1088);                   --do rejestru reg_hash wpisywanych jest 512bitow z magistrali in_state_data
            end if;

        end if;
    end process;

    process(in_clk)
    begin
        if(rising_edge(in_clk)) then
            if(in_state_init='1') then                                          --jesli sygnal in_state_init jest w stanie wysokim   
                reg_state <= (others => '0');                                   --rejestr reg_state inicjowany jest zerami
            end if;

            if(in_padded_value_wr='1') then                                     --jesli sygnal in_padded_value_wr jest w stanie wysokim
                reg_state <= (reg_state(1599 downto 1024) xor in_padded_data) & reg_state(1023 downto 0);    --512 bitow rejestru stanu algorytmu jest XORowane z z danymi z zewnatrz
            end if;
            
            if(in_state_wr='1') then                                            --jesli sygnal in_state_wr jest w stanie wysokim
                reg_state <= in_state_data;                                     --do rejestru reg_state wpisywane sa dane z magistrali in_state_data
            end if;
        end if;
    end process;

    out_ext_data <= reg_hash;                                                   --na magistrale out_ext_data wypisywana jest zawartosc rejestru reg_hash
    out_int_data <= reg_state;                                                  --na magistrale out_int_data wypisywana jest zawartosc rejestru reg_state

end behaviour;