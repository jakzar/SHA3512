----------------
--Jakub Zaroda--
----------------

--modul realizujacy funkcje rundy funkcji f
--do przeksztalcenia theta przekazywane sa wartosci z magistrali in_data, ktore po przeksztalceniu trafiaja do rejestru theta_out
--dane z rejestru theta_out wchodza na wejscie modulu sha3_512_rho_fun, po przeksztalceniu trafiaja do rejestru rho_out
--dane z rejestru rho_out wchodza na wejscie modulu sha3_512_pi_fun, po przeksztalceniu trafiaja do rejestru pi_out
--dane z rejestru pi_out wchodza na wejscie modulu sha3_512_chi_fun, po przeksztalceniu trafiaja do rejestru chi_out
--dane z rejestru chi_out wchodza na wejscie modulu sha3_512_iota_fun, po przeksztalceniu trafiaja na magistrale wyjsciowa out_data

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sha3_512_round_fun is port(
    in_data      : in std_logic_vector (1599 downto 0);     --magistrala wejsciowa stanu algorytmu 1600b
    in_RC        : in std_logic_vector (63 downto 0);       --magistrala wejsciowa zmiennej RC 64b
    out_data     : out std_logic_vector (1599 downto 0)     --magistrala wyjsciowa stanu algorytmu 1600b
);
end sha3_512_round_fun;

architecture behaviour of sha3_512_round_fun is
    signal theta_out : std_logic_vector (1599 downto 0);    --rejestr przechowujacy wartosc przeksztalcenia theta
    signal rho_out : std_logic_vector (1599 downto 0);      --rejestr przechowujacy wartosc przeksztalcenia rho
    signal pi_out : std_logic_vector (1599 downto 0);       --rejestr przechowujacy wartosc przeksztalcenia pi
    signal chi_out : std_logic_vector (1599 downto 0);      --rejestr przechowujacy wartosc przeksztalcenia chi
begin
        inst_theta: entity work.sha3_512_theta_fun port map(in_data, theta_out);
        inst_rho: entity work.sha3_512_rho_fun port map(theta_out, rho_out);
        inst_pi: entity work.sha3_512_pi_fun port map(rho_out, pi_out);
        inst_chi: entity work.sha3_512_chi_fun port map(pi_out, chi_out);
        inst_iota: entity work.sha3_512_iota_fun port map(chi_out, in_RC, out_data);
end behaviour;