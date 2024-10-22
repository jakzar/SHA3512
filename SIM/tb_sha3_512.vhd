library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.stop;

entity tb_sha3_512 is
end tb_sha3_512;

architecture behavior of tb_sha3_512 is

    constant inClkp : time := 10ns;
    signal in_clk : std_logic := '0';
    signal in_reset : std_logic := '0';
    signal in_data_wr  : std_logic :='0';
    signal in_data_data  : std_logic_vector(575 downto 0);
    signal out_data_data : std_logic_vector(511 downto 0);
    signal out_busy : std_logic;

begin
    in_clk <= not in_clk after inClkp/2;
    uut: entity work.sha3_512 port map(in_clk, in_reset, in_data_wr, in_data_data, out_data_data, out_busy);
    process
        
    begin
        wait for 10 ns;
        --testowanie resetu
        in_reset <= '1';
        wait for 10 ns;
        in_reset <= '0';
        if(out_data_data = x"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000") then
            report "Reset works correctly";
        else
            report "Reset works incorrectly";
        end if;
        wait for 10 ns;

        --testowanie wyznaczania funkcji skrotu pustej wiadomosci Msg0
        in_data_data <= x"060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000080";
        in_data_wr <='1';
        wait for 10 ns;
        in_data_wr <='0';
        wait until (out_busy='0' and in_clk='0');
        if(out_data_data = x"A69F73CCA23A9AC5C8B567DC185A756E97C982164FE25859E0D1DCC1475C80A615B2123AF1F5F94C11E3E9402C3AC558F500199D95B6D3E301758586281DCD26") then
            report "Hash Msg0 is correct";
        else
            report "Hash Msg0 is incorrect";
        end if;

        wait for 10 ns;
        in_reset <= '1';
        wait for 10 ns;
        in_reset <= '0';

        --testowanie wyznaczania funkcji skrotu pustej wiadomosci Msg1600 blok1
        in_data_data <= x"A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3";
        in_data_wr <='1';
        wait for 10 ns;
        in_data_wr <='0';
        wait for 10 ns;
        wait until (out_busy='0' and in_clk='0');
        --blok2
        in_data_data <= x"A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3";
        in_data_wr <='1';
        wait for 10 ns;
        in_data_wr <='0';
        wait for 10 ns;
        wait until (out_busy='0' and in_clk='0');
        --blok3
        in_data_data <= x"A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A306000000000000000000000000000080";
        in_data_wr <='1';
        wait for 10 ns;
        in_data_wr <='0';
        wait for 10 ns;
        wait until (out_busy='0' and in_clk='0');

        if(out_data_data = x"E76DFAD22084A8B1467FCF2FFA58361BEC7628EDF5F3FDC0E4805DC48CAEECA81B7C13C30ADF52A3659584739A2DF46BE589C51CA1A4A8416DF6545A1CE8BA00") then
            report "Hash Msg1600 is correct";
        else
            report "Hash Msg1600 is incorrect";
        end if;

        wait for 10 ns;
        in_reset <= '1';
        wait for 10 ns;
        in_reset <= '0';


        --testowanie przerwania wyznaczania skrotu poprzez reset w trakcie pracy koprocesora - oczekiwane jest nieprzerwanie pracy
        in_data_data <= x"A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3";
        in_data_wr <='1';
        wait for 10 ns;
        in_data_wr <='0';
        wait for 10 ns;
        wait until (out_busy='0' and in_clk='0');
        --blok2
        in_data_data <= x"A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3";
        in_data_wr <='1';
        wait for 10 ns;
        in_data_wr <='0';
        wait for 120 ns;
        --przerwanie w trakcie pracy koprocesora
        in_reset <= '1';
        wait for 10 ns;
        in_reset <= '0';
        wait until (out_busy='0' and in_clk='0');
        --blok3
        in_data_data <= x"A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A306000000000000000000000000000080";
        in_data_wr <='1';
        wait for 10 ns;
        in_data_wr <='0';
        wait for 10 ns;
        wait until (out_busy='0' and in_clk='0');

        if(out_data_data = x"E76DFAD22084A8B1467FCF2FFA58361BEC7628EDF5F3FDC0E4805DC48CAEECA81B7C13C30ADF52A3659584739A2DF46BE589C51CA1A4A8416DF6545A1CE8BA00") then
            report "Reset didn't work while coprocessor was working (test went successfully)";
        else
            report "Reset worked while coprocessor was working (test didn't went successfully)";
        end if;

        wait for 10 ns;
        in_reset <= '1';
        wait for 10 ns;
        in_reset <= '0';

        --testowanie przerwania wyznaczania skrotu poprzez reset w nie podczas pracy koprocesora - oczekiwane jest przerwanie pracy; podanie nowych danych do przetwarzania niezaleznie od poprzednich danych
        in_data_data <= x"A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3";
        in_data_wr <='1';
        wait for 10 ns;
        in_data_wr <='0';
        wait for 10 ns;
        wait until (out_busy='0' and in_clk='1');
        --blok2
        in_data_data <= x"A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3";
        in_data_wr <='1';
        wait for 10 ns;
        in_data_wr <='0';
        wait until (out_busy='0' and in_clk='1');
        --reset
        in_reset <= '1';
        wait for 10 ns;
        in_reset <= '0';
        --nowe dane hash Msg0
        in_data_data <= x"060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000080";
        in_data_wr <='1';
        wait for 10 ns;
        in_data_wr <='0';
        wait for 10 ns;
        wait until (out_busy='0' and in_clk='1');

        if(out_data_data = x"A69F73CCA23A9AC5C8B567DC185A756E97C982164FE25859E0D1DCC1475C80A615B2123AF1F5F94C11E3E9402C3AC558F500199D95B6D3E301758586281DCD26") then
            report "Reset while the coprocessor wasn't working went successfully, and new data were hashed (test went succesfully) ";
        else
            report "Reset while the coprocessor wasn't working didn't went successfully, and new data weren't hashed (test didn't went succesfully) ";
        end if;



        stop;
    end process;

end behavior;
