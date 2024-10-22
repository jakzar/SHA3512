----------------
--Jakub Zaroda--
----------------

--modul sha3_512_control odpowiada za sterowanie koprocesorem
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sha3_512_control is port(
    in_clk       : in std_logic;                                --wejscie sygnalu zegarowego 
    in_ext_data_wr       : in std_logic;                        --wejscie sygnalu zapisu danych z zewnatrz
    in_ext_init         :   in std_logic;                       --wejscie sygnalu resetu
    out_state_reg_in_hash_init  :   out std_logic;              --wyjscie sygnalu resetu rejestru reg_hash
    out_state_reg_in_hash_wr  :   out std_logic;                --wyjscie sygnalu zapisu do rejestru reg_hash
    out_state_reg_in_state_init  :   out std_logic;             --wyjscie sygnalu resetu rejestru reg_state
    out_state_reg_in_state_wr  :   out std_logic;               --wyjscie sygnalu zapisu do rejestru reg_state danych z wewnatrz koprocesora 
    out_round_number     : out std_logic_vector (5 downto 0);   --wyjscie magistrali przechowujacej numer rundy
    out_busy     : out std_logic;                               --wyjscie sygnalu pracy ukladu
    out_state_reg_in_padded_value : out std_logic               --wyjscie sygnalu zapisu do rejestru reg_state danych spoza koprocesora
);
end sha3_512_control;

architecture behaviour of sha3_512_control is
    signal reg_counter  : std_logic_vector (7 downto 0) := (others => '0');     --rejestr licznika
    signal reg_temp_round_number     : std_logic_vector (7 downto 0) := (others => '0');
begin
    process(in_clk)
    begin
        if (rising_edge(in_clk)) then                                           --przy kazdym zboczu narastajacym zegara licznik zlicza w gore
            if(in_ext_data_wr='1' or reg_counter /= x"00") then                 --o ile sygnal in_ext_data_wr jest w stanie wysokim lub licznik nie jest wyzerowany
                if(reg_counter = x"18") then                                    --jezeli licznik ma wartosc 24 to jest zerowany
                    reg_counter <=(others => '0');
                else
                    reg_counter <= std_logic_vector(to_unsigned(to_integer(unsigned(reg_counter))+1, 8));
                end if;
            end if;
        end if;
    end process;

    reg_temp_round_number <= (std_logic_vector(unsigned(reg_counter)-1));              --numer rundy jest o jeden mniejszy od wartosci licznika
    out_round_number <=  reg_temp_round_number(5 downto 0);
    out_state_reg_in_hash_init <= in_ext_init when (reg_counter=x"00") else '0';      --sygnal out_state_reg_in_hash_init jest w stanie wysokim gdy licznik jest wyzerowany oraz in_ext_init jest w stanie wysokim
    out_state_reg_in_hash_wr <= '1' when (reg_counter=x"18") else '0';                --sygnal out_state_reg_in_hash_wr jest w stanie wysokim ostatnim takcie pracy licznika
    out_state_reg_in_state_init <= in_ext_init when (reg_counter=x"00") else '0';     --sygnal out_state_reg_in_state_init jest w stanie wysokim gdy licznik jest wyzerowany oraz in_ext_init jest w stanie wysokim
    out_state_reg_in_state_wr <= '0' when (reg_counter=x"00") else '1';               --sygnal out_state_reg_in_state_wr jest w stanie wysokim gdy koprocesor wykonuje obliczenia
    out_busy <= '0' when (reg_counter=x"00") else '1';                                --sygnal out_busy jest w stanie wysokim gdy koprocesor wykonuje obliczenia
    out_state_reg_in_padded_value <= in_ext_data_wr;                                  --sygnal out_busy jest w stanie wysokim gdy in_ext_data_wr jest w stanie wysokim

end behaviour;