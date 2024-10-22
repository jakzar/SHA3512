----------------
--Jakub Zaroda--
----------------

--modul sha3_512 laczy ze soba prace modulow skladowych
--przekazuje sygnaly wejsciowe do odpowiednich modulow oraz wypisuje odpowiednie wartosci na magistrale wyjsciowe
--korzysta z modulu sha3_512_control ktory odpowiada za sterowanie koprocesorem
--korzysta z modulu sha3_512_state_reg ktory odpowiada za przechowywanie stanu algorytmu oraz ostatnio obliczonego skrotu
--korzysta z modulu sha3_512_round_fun ktory odpowiada za wykonywanie funkcji rundy na stanie algorytmu
--korzysta z modulu sha3_512_rc_reg ktory odpowiada za wyznaczanie stalej rundowej RC

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sha3_512 is port(
    in_clk       : in std_logic;                                --wejscie sygnalu zegarowego
    in_reset       : in std_logic;                              --wejscie sygnalu resetu
    in_data_wr       : in std_logic;                            --wejscie sygnalu danych do przetworzenia
    in_data_data      : in std_logic_vector (575 downto 0);     --magistrala wejsciowa bloku danych do przetworzenia 576-bitowa
    out_data_data     : out std_logic_vector (511 downto 0);    --magistrala wyjsciowa zawierajaca wyznaczana funkcje skrotu 512-bitowa
    out_busy     : out std_logic                                --sygnal pracy ukladu
);
end sha3_512;

architecture behaviour of sha3_512 is
    signal wire_control_out_state_reg_in_hash_init  : std_logic;        --sygnal wewnetrzny odpowiadajacy za przywrocenie do stanu poczatkowego rejestru przechowujacego ostatnio obliczona wartosc skrotu
    signal wire_control_out_state_reg_in_hash_wr  : std_logic;          --sygnal wewnetrzny odpowiadajacy za zapis danych do rejestru reg_hash
    signal wire_control_out_state_reg_in_state_init  : std_logic;       --sygnal wewnetrzny odpowiadajacy za przywrocenie do stanu poczatkowego rejestru przechowujacego stan algorytmu
    signal wire_control_out_state_reg_in_state_wr  : std_logic;         --sygnal wewnetrzny odpowiadajacy za zapis do rejestru reg_state danych z wewnatrz koprocesora 
    signal wire_control_out_state_reg_in_padded_value : std_logic;      --sygnal wewnetrzny odpowiadajacy za zapis do rejestru reg_state danych z zewewnatrz koprocesora 

    signal wire_control_out_round_number  : std_logic_vector (5 downto 0);      --sygnal zawierajacy numer rundy
    signal wire_rc_round_val  : std_logic_vector (63 downto 0);                 --sygnal zawierajacy wartosc stalej rundowej RC

    signal wire_state_reg_out_int_data : std_logic_vector (1599 downto 0);      --sygnal wewnetrzny zawierajacy dane z rejestru stanu algorytmu
    signal wire_state_next_out_data : std_logic_vector (1599 downto 0);         --sygnal wewnetrzny zawierajacy dane z rejestru stanu algorytmu po wykonaniu na nim funkcji rundy
    
begin

    inst_sha3_512_control: entity work.sha3_512_control port map(in_clk, in_data_wr, in_reset, wire_control_out_state_reg_in_hash_init, wire_control_out_state_reg_in_hash_wr, wire_control_out_state_reg_in_state_init, wire_control_out_state_reg_in_state_wr, wire_control_out_round_number, out_busy, wire_control_out_state_reg_in_padded_value);
    inst_sha3_512_state_reg: entity work.sha3_512_state_reg port map(in_clk, wire_state_next_out_data, in_data_data, wire_control_out_state_reg_in_hash_init, wire_control_out_state_reg_in_hash_wr, wire_control_out_state_reg_in_state_init, wire_control_out_state_reg_in_state_wr, wire_control_out_state_reg_in_padded_value, out_data_data, wire_state_reg_out_int_data);
    inst_sha3_512_round_fun: entity work.sha3_512_round_fun port map(wire_state_reg_out_int_data, wire_rc_round_val ,wire_state_next_out_data);
    inst_sha3_512_rc_reg: entity work.sha3_512_rc_reg port map(wire_control_out_round_number, wire_rc_round_val);

end behaviour;