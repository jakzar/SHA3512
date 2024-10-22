----------------
--Jakub Zaroda--
----------------

--modul realizujacy funkcje Theta()
--do rejestrow pomocniczych wczytywane sa dane z magistrali in_data zgodnie z konwencja LE
--do rejestrow out_* wpisywane sa wartosci zrotowanych "linii" o wartosci okreslone w dokumnentacji
--na magistrale wyjsciowa bajty sa zapisywane zgodnie z konwencja BE
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sha3_512_theta_fun is port(
    in_data      : in std_logic_vector (1599 downto 0);         --magistrala wejsciowa stanu algorytmu 1600b
    out_data     : out std_logic_vector (1599 downto 0)         --magistrala wyjsciowa stanu algorytmu 1600b
);
end sha3_512_theta_fun;

architecture behaviour of sha3_512_theta_fun is
    --rejestry pomocnicze przechowujace "linie"
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

    --rejestry przechowujace dane z tablicy C zgodnie z dokumentacja
    signal c_0_z  : std_logic_vector (63 downto 0);
    signal c_1_z  : std_logic_vector (63 downto 0);
    signal c_2_z  : std_logic_vector (63 downto 0);
    signal c_3_z  : std_logic_vector (63 downto 0);
    signal c_4_z  : std_logic_vector (63 downto 0);

    --rejestry przechowujace zrotowane dane z tablicy C
    signal c_0_z_rt  : std_logic_vector (63 downto 0);
    signal c_1_z_rt  : std_logic_vector (63 downto 0);
    signal c_2_z_rt  : std_logic_vector (63 downto 0);
    signal c_3_z_rt  : std_logic_vector (63 downto 0);
    signal c_4_z_rt  : std_logic_vector (63 downto 0);

    --rejestry przechowujace dane z tablicy D zgodnie z dokumentacja
    signal d_0_z  : std_logic_vector (63 downto 0);
    signal d_1_z  : std_logic_vector (63 downto 0);
    signal d_2_z  : std_logic_vector (63 downto 0);
    signal d_3_z  : std_logic_vector (63 downto 0);
    signal d_4_z  : std_logic_vector (63 downto 0);

begin
    a_0_0 <= in_data(1543 downto 1536) & in_data(1551 downto 1544) & in_data(1559 downto 1552) & in_data(1567 downto 1560) & in_data(1575 downto 1568)  & in_data(1583 downto 1576) & in_data(1591 downto 1584) & in_data(1599 downto 1592);
    a_1_0 <= in_data(1479 downto 1472) & in_data(1487 downto 1480) & in_data(1495 downto 1488) & in_data(1503 downto 1496) & in_data(1511 downto 1504)  & in_data(1519 downto 1512) & in_data(1527 downto 1520) & in_data(1535 downto 1528);
    a_2_0 <= in_data(1415 downto 1408) & in_data(1423 downto 1416) & in_data(1431 downto 1424) & in_data(1439 downto 1432) & in_data(1447 downto 1440)  & in_data(1455 downto 1448) & in_data(1463 downto 1456) & in_data(1471 downto 1464);
    a_3_0 <= in_data(1351 downto 1344) & in_data(1359 downto 1352) & in_data(1367 downto 1360) & in_data(1375 downto 1368) & in_data(1383 downto 1376)  & in_data(1391 downto 1384) & in_data(1399 downto 1392) & in_data(1407 downto 1400);
    a_4_0 <= in_data(1287 downto 1280) & in_data(1295 downto 1288) & in_data(1303 downto 1296) & in_data(1311 downto 1304) & in_data(1319 downto 1312)  & in_data(1327 downto 1320) & in_data(1335 downto 1328) & in_data(1343 downto 1336);

    a_0_1 <= in_data(1223 downto 1216) & in_data(1231 downto 1224) & in_data(1239 downto 1232) & in_data(1247 downto 1240) & in_data(1255 downto 1248)  & in_data(1263 downto 1256) & in_data(1271 downto 1264) & in_data(1279 downto 1272);    
    a_1_1 <= in_data(1159 downto 1152) & in_data(1167 downto 1160) & in_data(1175 downto 1168) & in_data(1183 downto 1176) & in_data(1191 downto 1184)  & in_data(1199 downto 1192) & in_data(1207 downto 1200) & in_data(1215 downto 1208);
    a_2_1 <= in_data(1095 downto 1088) & in_data(1103 downto 1096) & in_data(1111 downto 1104) & in_data(1119 downto 1112) & in_data(1127 downto 1120)  & in_data(1135 downto 1128) & in_data(1143 downto 1136) & in_data(1151 downto 1144);
    a_3_1 <= in_data(1031 downto 1024) & in_data(1039 downto 1032) & in_data(1047 downto 1040) & in_data(1055 downto 1048) & in_data(1063 downto 1056)  & in_data(1071 downto 1064) & in_data(1079 downto 1072) & in_data(1087 downto 1080);
    a_4_1 <= in_data(967 downto 960) & in_data(975 downto 968) & in_data(983 downto 976) & in_data(991 downto 984) & in_data(999 downto 992)  & in_data(1007 downto 1000) & in_data(1015 downto 1008) & in_data(1023 downto 1016);

    a_0_2 <= in_data(903 downto 896) & in_data(911 downto 904) & in_data(919 downto 912) & in_data(927 downto 920) & in_data(935 downto 928)  & in_data(943 downto 936) & in_data(951 downto 944) & in_data(959 downto 952);
    a_1_2 <= in_data(839 downto 832) & in_data(847 downto 840) & in_data(855 downto 848) & in_data(863 downto 856) & in_data(871 downto 864)  & in_data(879 downto 872) & in_data(887 downto 880) & in_data(895 downto 888);
    a_2_2 <= in_data(775 downto 768) & in_data(783 downto 776) & in_data(791 downto 784) & in_data(799 downto 792) & in_data(807 downto 800)  & in_data(815 downto 808) & in_data(823 downto 816) & in_data(831 downto 824);
    a_3_2 <= in_data(711 downto 704) & in_data(719 downto 712) & in_data(727 downto 720) & in_data(735 downto 728) & in_data(743 downto 736)  & in_data(751 downto 744) & in_data(759 downto 752) & in_data(767 downto 760);
    a_4_2 <= in_data(647 downto 640) & in_data(655 downto 648) & in_data(663 downto 656) & in_data(671 downto 664) & in_data(679 downto 672)  & in_data(687 downto 680) & in_data(695 downto 688) & in_data(703 downto 696);

    a_0_3 <= in_data(583 downto 576) & in_data(591 downto 584) & in_data(599 downto 592) & in_data(607 downto 600) & in_data(615 downto 608)  & in_data(623 downto 616) & in_data(631 downto 624) & in_data(639 downto 632);
    a_1_3 <= in_data(519 downto 512) & in_data(527 downto 520) & in_data(535 downto 528) & in_data(543 downto 536) & in_data(551 downto 544)  & in_data(559 downto 552) & in_data(567 downto 560) & in_data(575 downto 568);
    a_2_3 <= in_data(455 downto 448) & in_data(463 downto 456) & in_data(471 downto 464) & in_data(479 downto 472) & in_data(487 downto 480)  & in_data(495 downto 488) & in_data(503 downto 496) & in_data(511 downto 504);
    a_3_3 <= in_data(391 downto 384) & in_data(399 downto 392) & in_data(407 downto 400) & in_data(415 downto 408) & in_data(423 downto 416)  & in_data(431 downto 424) & in_data(439 downto 432) & in_data(447 downto 440);
    a_4_3 <= in_data(327 downto 320) & in_data(335 downto 328) & in_data(343 downto 336) & in_data(351 downto 344) & in_data(359 downto 352)  & in_data(367 downto 360) & in_data(375 downto 368) & in_data(383 downto 376);

    a_0_4 <= in_data(263 downto 256) & in_data(271 downto 264) & in_data(279 downto 272) & in_data(287 downto 280) & in_data(295 downto 288)  & in_data(303 downto 296) & in_data(311 downto 304) & in_data(319 downto 312);
    a_1_4 <= in_data(199 downto 192) & in_data(207 downto 200) & in_data(215 downto 208) & in_data(223 downto 216) & in_data(231 downto 224)  & in_data(239 downto 232) & in_data(247 downto 240) & in_data(255 downto 248);
    a_2_4 <= in_data(135 downto 128) & in_data(143 downto 136) & in_data(151 downto 144) & in_data(159 downto 152) & in_data(167 downto 160)  & in_data(175 downto 168) & in_data(183 downto 176) & in_data(191 downto 184);
    a_3_4 <= in_data(71 downto 64) & in_data(79 downto 72) & in_data(87 downto 80) & in_data(95 downto 88) & in_data(103 downto 96)  & in_data(111 downto 104) & in_data(119 downto 112) & in_data(127 downto 120);
    a_4_4 <= in_data(7 downto 0) & in_data(15 downto 8) & in_data(23 downto 16) & in_data(31 downto 24) & in_data(39 downto 32)  & in_data(47 downto 40) & in_data(55 downto 48) & in_data(63 downto 56);

    c_0_z <= a_0_0 xor a_0_1 xor a_0_2 xor a_0_3 xor a_0_4;
    c_1_z<=a_1_0 xor a_1_1 xor a_1_2 xor a_1_3 xor a_1_4;
    c_2_z<=a_2_0 xor a_2_1 xor a_2_2 xor a_2_3 xor a_2_4;
    c_3_z<=a_3_0 xor a_3_1 xor a_3_2 xor a_3_3 xor a_3_4;
    c_4_z<=a_4_0 xor a_4_1 xor a_4_2 xor a_4_3 xor a_4_4;

    c_0_z_rt <= c_0_z(62 downto 0) & c_0_z(63);
    c_1_z_rt <= c_1_z(62 downto 0) & c_1_z(63) ;
    c_2_z_rt <= c_2_z(62 downto 0) & c_2_z(63) ;
    c_3_z_rt <= c_3_z(62 downto 0) & c_3_z(63) ;
    c_4_z_rt <= c_4_z(62 downto 0) & c_4_z(63) ;

    d_0_z<=c_4_z xor c_1_z_rt;
    d_1_z<=c_0_z xor c_2_z_rt;
    d_2_z<=c_1_z xor c_3_z_rt;
    d_3_z<=c_2_z xor c_4_z_rt;
    d_4_z<=c_3_z xor c_0_z_rt;


    out_data(1599 downto 1536) <= (a_0_0(7 downto 0) xor d_0_z(7 downto 0)) & (a_0_0(15 downto 8) xor d_0_z(15 downto 8)) & (a_0_0(23 downto 16) xor d_0_z(23 downto 16)) & (a_0_0(31 downto 24) xor d_0_z(31 downto 24)) & (a_0_0(39 downto 32) xor d_0_z(39 downto 32)) & (a_0_0(47 downto 40) xor d_0_z(47 downto 40)) & (a_0_0(55 downto 48) xor d_0_z(55 downto 48)) & (a_0_0(63 downto 56) xor d_0_z(63 downto 56));
    out_data(1535 downto 1472) <= (a_1_0(7 downto 0) xor d_1_z(7 downto 0)) & (a_1_0(15 downto 8) xor d_1_z(15 downto 8)) & (a_1_0(23 downto 16) xor d_1_z(23 downto 16)) & (a_1_0(31 downto 24) xor d_1_z(31 downto 24)) & (a_1_0(39 downto 32) xor d_1_z(39 downto 32)) & (a_1_0(47 downto 40) xor d_1_z(47 downto 40)) & (a_1_0(55 downto 48) xor d_1_z(55 downto 48)) & (a_1_0(63 downto 56) xor d_1_z(63 downto 56));
    out_data(1471 downto 1408) <= (a_2_0(7 downto 0) xor d_2_z(7 downto 0)) & (a_2_0(15 downto 8) xor d_2_z(15 downto 8)) & (a_2_0(23 downto 16) xor d_2_z(23 downto 16)) & (a_2_0(31 downto 24) xor d_2_z(31 downto 24)) & (a_2_0(39 downto 32) xor d_2_z(39 downto 32)) & (a_2_0(47 downto 40) xor d_2_z(47 downto 40)) & (a_2_0(55 downto 48) xor d_2_z(55 downto 48)) & (a_2_0(63 downto 56) xor d_2_z(63 downto 56));
    out_data(1407 downto 1344) <= (a_3_0(7 downto 0) xor d_3_z(7 downto 0)) & (a_3_0(15 downto 8) xor d_3_z(15 downto 8)) & (a_3_0(23 downto 16) xor d_3_z(23 downto 16)) & (a_3_0(31 downto 24) xor d_3_z(31 downto 24)) & (a_3_0(39 downto 32) xor d_3_z(39 downto 32)) & (a_3_0(47 downto 40) xor d_3_z(47 downto 40)) & (a_3_0(55 downto 48) xor d_3_z(55 downto 48)) & (a_3_0(63 downto 56) xor d_3_z(63 downto 56));
    out_data(1343 downto 1280) <= (a_4_0(7 downto 0) xor d_4_z(7 downto 0)) & (a_4_0(15 downto 8) xor d_4_z(15 downto 8)) & (a_4_0(23 downto 16) xor d_4_z(23 downto 16)) & (a_4_0(31 downto 24) xor d_4_z(31 downto 24)) & (a_4_0(39 downto 32) xor d_4_z(39 downto 32)) & (a_4_0(47 downto 40) xor d_4_z(47 downto 40)) & (a_4_0(55 downto 48) xor d_4_z(55 downto 48)) & (a_4_0(63 downto 56) xor d_4_z(63 downto 56));
    out_data(1279 downto 1216) <= (a_0_1(7 downto 0) xor d_0_z(7 downto 0)) & (a_0_1(15 downto 8) xor d_0_z(15 downto 8)) & (a_0_1(23 downto 16) xor d_0_z(23 downto 16)) & (a_0_1(31 downto 24) xor d_0_z(31 downto 24)) & (a_0_1(39 downto 32) xor d_0_z(39 downto 32)) & (a_0_1(47 downto 40) xor d_0_z(47 downto 40)) & (a_0_1(55 downto 48) xor d_0_z(55 downto 48)) & (a_0_1(63 downto 56) xor d_0_z(63 downto 56));
    out_data(1215 downto 1152) <= (a_1_1(7 downto 0) xor d_1_z(7 downto 0)) & (a_1_1(15 downto 8) xor d_1_z(15 downto 8)) & (a_1_1(23 downto 16) xor d_1_z(23 downto 16)) & (a_1_1(31 downto 24) xor d_1_z(31 downto 24)) & (a_1_1(39 downto 32) xor d_1_z(39 downto 32)) & (a_1_1(47 downto 40) xor d_1_z(47 downto 40)) & (a_1_1(55 downto 48) xor d_1_z(55 downto 48)) & (a_1_1(63 downto 56) xor d_1_z(63 downto 56));
    out_data(1151 downto 1088) <= (a_2_1(7 downto 0) xor d_2_z(7 downto 0)) & (a_2_1(15 downto 8) xor d_2_z(15 downto 8)) & (a_2_1(23 downto 16) xor d_2_z(23 downto 16)) & (a_2_1(31 downto 24) xor d_2_z(31 downto 24)) & (a_2_1(39 downto 32) xor d_2_z(39 downto 32)) & (a_2_1(47 downto 40) xor d_2_z(47 downto 40)) & (a_2_1(55 downto 48) xor d_2_z(55 downto 48)) & (a_2_1(63 downto 56) xor d_2_z(63 downto 56));
    out_data(1087 downto 1024) <= (a_3_1(7 downto 0) xor d_3_z(7 downto 0)) & (a_3_1(15 downto 8) xor d_3_z(15 downto 8)) & (a_3_1(23 downto 16) xor d_3_z(23 downto 16)) & (a_3_1(31 downto 24) xor d_3_z(31 downto 24)) & (a_3_1(39 downto 32) xor d_3_z(39 downto 32)) & (a_3_1(47 downto 40) xor d_3_z(47 downto 40)) & (a_3_1(55 downto 48) xor d_3_z(55 downto 48)) & (a_3_1(63 downto 56) xor d_3_z(63 downto 56));
    out_data(1023 downto 960) <= (a_4_1(7 downto 0) xor d_4_z(7 downto 0)) & (a_4_1(15 downto 8) xor d_4_z(15 downto 8)) & (a_4_1(23 downto 16) xor d_4_z(23 downto 16)) & (a_4_1(31 downto 24) xor d_4_z(31 downto 24)) & (a_4_1(39 downto 32) xor d_4_z(39 downto 32)) & (a_4_1(47 downto 40) xor d_4_z(47 downto 40)) & (a_4_1(55 downto 48) xor d_4_z(55 downto 48)) & (a_4_1(63 downto 56) xor d_4_z(63 downto 56));
    out_data(959 downto 896) <= (a_0_2(7 downto 0) xor d_0_z(7 downto 0)) & (a_0_2(15 downto 8) xor d_0_z(15 downto 8)) & (a_0_2(23 downto 16) xor d_0_z(23 downto 16)) & (a_0_2(31 downto 24) xor d_0_z(31 downto 24)) & (a_0_2(39 downto 32) xor d_0_z(39 downto 32)) & (a_0_2(47 downto 40) xor d_0_z(47 downto 40)) & (a_0_2(55 downto 48) xor d_0_z(55 downto 48)) & (a_0_2(63 downto 56) xor d_0_z(63 downto 56));
    out_data(895 downto 832) <= (a_1_2(7 downto 0) xor d_1_z(7 downto 0)) & (a_1_2(15 downto 8) xor d_1_z(15 downto 8)) & (a_1_2(23 downto 16) xor d_1_z(23 downto 16)) & (a_1_2(31 downto 24) xor d_1_z(31 downto 24)) & (a_1_2(39 downto 32) xor d_1_z(39 downto 32)) & (a_1_2(47 downto 40) xor d_1_z(47 downto 40)) & (a_1_2(55 downto 48) xor d_1_z(55 downto 48)) & (a_1_2(63 downto 56) xor d_1_z(63 downto 56));
    out_data(831 downto 768) <= (a_2_2(7 downto 0) xor d_2_z(7 downto 0)) & (a_2_2(15 downto 8) xor d_2_z(15 downto 8)) & (a_2_2(23 downto 16) xor d_2_z(23 downto 16)) & (a_2_2(31 downto 24) xor d_2_z(31 downto 24)) & (a_2_2(39 downto 32) xor d_2_z(39 downto 32)) & (a_2_2(47 downto 40) xor d_2_z(47 downto 40)) & (a_2_2(55 downto 48) xor d_2_z(55 downto 48)) & (a_2_2(63 downto 56) xor d_2_z(63 downto 56));
    out_data(767 downto 704) <= (a_3_2(7 downto 0) xor d_3_z(7 downto 0)) & (a_3_2(15 downto 8) xor d_3_z(15 downto 8)) & (a_3_2(23 downto 16) xor d_3_z(23 downto 16)) & (a_3_2(31 downto 24) xor d_3_z(31 downto 24)) & (a_3_2(39 downto 32) xor d_3_z(39 downto 32)) & (a_3_2(47 downto 40) xor d_3_z(47 downto 40)) & (a_3_2(55 downto 48) xor d_3_z(55 downto 48)) & (a_3_2(63 downto 56) xor d_3_z(63 downto 56));
    out_data(703 downto 640) <= (a_4_2(7 downto 0) xor d_4_z(7 downto 0)) & (a_4_2(15 downto 8) xor d_4_z(15 downto 8)) & (a_4_2(23 downto 16) xor d_4_z(23 downto 16)) & (a_4_2(31 downto 24) xor d_4_z(31 downto 24)) & (a_4_2(39 downto 32) xor d_4_z(39 downto 32)) & (a_4_2(47 downto 40) xor d_4_z(47 downto 40)) & (a_4_2(55 downto 48) xor d_4_z(55 downto 48)) & (a_4_2(63 downto 56) xor d_4_z(63 downto 56));
    out_data(639 downto 576) <= (a_0_3(7 downto 0) xor d_0_z(7 downto 0)) & (a_0_3(15 downto 8) xor d_0_z(15 downto 8)) & (a_0_3(23 downto 16) xor d_0_z(23 downto 16)) & (a_0_3(31 downto 24) xor d_0_z(31 downto 24)) & (a_0_3(39 downto 32) xor d_0_z(39 downto 32)) & (a_0_3(47 downto 40) xor d_0_z(47 downto 40)) & (a_0_3(55 downto 48) xor d_0_z(55 downto 48)) & (a_0_3(63 downto 56) xor d_0_z(63 downto 56));
    out_data(575 downto 512) <= (a_1_3(7 downto 0) xor d_1_z(7 downto 0)) & (a_1_3(15 downto 8) xor d_1_z(15 downto 8)) & (a_1_3(23 downto 16) xor d_1_z(23 downto 16)) & (a_1_3(31 downto 24) xor d_1_z(31 downto 24)) & (a_1_3(39 downto 32) xor d_1_z(39 downto 32)) & (a_1_3(47 downto 40) xor d_1_z(47 downto 40)) & (a_1_3(55 downto 48) xor d_1_z(55 downto 48)) & (a_1_3(63 downto 56) xor d_1_z(63 downto 56));
    out_data(511 downto 448) <= (a_2_3(7 downto 0) xor d_2_z(7 downto 0)) & (a_2_3(15 downto 8) xor d_2_z(15 downto 8)) & (a_2_3(23 downto 16) xor d_2_z(23 downto 16)) & (a_2_3(31 downto 24) xor d_2_z(31 downto 24)) & (a_2_3(39 downto 32) xor d_2_z(39 downto 32)) & (a_2_3(47 downto 40) xor d_2_z(47 downto 40)) & (a_2_3(55 downto 48) xor d_2_z(55 downto 48)) & (a_2_3(63 downto 56) xor d_2_z(63 downto 56));
    out_data(447 downto 384) <= (a_3_3(7 downto 0) xor d_3_z(7 downto 0)) & (a_3_3(15 downto 8) xor d_3_z(15 downto 8)) & (a_3_3(23 downto 16) xor d_3_z(23 downto 16)) & (a_3_3(31 downto 24) xor d_3_z(31 downto 24)) & (a_3_3(39 downto 32) xor d_3_z(39 downto 32)) & (a_3_3(47 downto 40) xor d_3_z(47 downto 40)) & (a_3_3(55 downto 48) xor d_3_z(55 downto 48)) & (a_3_3(63 downto 56) xor d_3_z(63 downto 56));
    out_data(383 downto 320) <= (a_4_3(7 downto 0) xor d_4_z(7 downto 0)) & (a_4_3(15 downto 8) xor d_4_z(15 downto 8)) & (a_4_3(23 downto 16) xor d_4_z(23 downto 16)) & (a_4_3(31 downto 24) xor d_4_z(31 downto 24)) & (a_4_3(39 downto 32) xor d_4_z(39 downto 32)) & (a_4_3(47 downto 40) xor d_4_z(47 downto 40)) & (a_4_3(55 downto 48) xor d_4_z(55 downto 48)) & (a_4_3(63 downto 56) xor d_4_z(63 downto 56));
    out_data(319 downto 256) <= (a_0_4(7 downto 0) xor d_0_z(7 downto 0)) & (a_0_4(15 downto 8) xor d_0_z(15 downto 8)) & (a_0_4(23 downto 16) xor d_0_z(23 downto 16)) & (a_0_4(31 downto 24) xor d_0_z(31 downto 24)) & (a_0_4(39 downto 32) xor d_0_z(39 downto 32)) & (a_0_4(47 downto 40) xor d_0_z(47 downto 40)) & (a_0_4(55 downto 48) xor d_0_z(55 downto 48)) & (a_0_4(63 downto 56) xor d_0_z(63 downto 56));
    out_data(255 downto 192) <= (a_1_4(7 downto 0) xor d_1_z(7 downto 0)) & (a_1_4(15 downto 8) xor d_1_z(15 downto 8)) & (a_1_4(23 downto 16) xor d_1_z(23 downto 16)) & (a_1_4(31 downto 24) xor d_1_z(31 downto 24)) & (a_1_4(39 downto 32) xor d_1_z(39 downto 32)) & (a_1_4(47 downto 40) xor d_1_z(47 downto 40)) & (a_1_4(55 downto 48) xor d_1_z(55 downto 48)) & (a_1_4(63 downto 56) xor d_1_z(63 downto 56));
    out_data(191 downto 128) <= (a_2_4(7 downto 0) xor d_2_z(7 downto 0)) & (a_2_4(15 downto 8) xor d_2_z(15 downto 8)) & (a_2_4(23 downto 16) xor d_2_z(23 downto 16)) & (a_2_4(31 downto 24) xor d_2_z(31 downto 24)) & (a_2_4(39 downto 32) xor d_2_z(39 downto 32)) & (a_2_4(47 downto 40) xor d_2_z(47 downto 40)) & (a_2_4(55 downto 48) xor d_2_z(55 downto 48)) & (a_2_4(63 downto 56) xor d_2_z(63 downto 56));
    out_data(127 downto 64) <= (a_3_4(7 downto 0) xor d_3_z(7 downto 0)) & (a_3_4(15 downto 8) xor d_3_z(15 downto 8)) & (a_3_4(23 downto 16) xor d_3_z(23 downto 16)) & (a_3_4(31 downto 24) xor d_3_z(31 downto 24)) & (a_3_4(39 downto 32) xor d_3_z(39 downto 32)) & (a_3_4(47 downto 40) xor d_3_z(47 downto 40)) & (a_3_4(55 downto 48) xor d_3_z(55 downto 48)) & (a_3_4(63 downto 56) xor d_3_z(63 downto 56));
    out_data(63 downto 0) <= (a_4_4(7 downto 0) xor d_4_z(7 downto 0)) & (a_4_4(15 downto 8) xor d_4_z(15 downto 8)) & (a_4_4(23 downto 16) xor d_4_z(23 downto 16)) & (a_4_4(31 downto 24) xor d_4_z(31 downto 24)) & (a_4_4(39 downto 32) xor d_4_z(39 downto 32)) & (a_4_4(47 downto 40) xor d_4_z(47 downto 40)) & (a_4_4(55 downto 48) xor d_4_z(55 downto 48)) & (a_4_4(63 downto 56) xor d_4_z(63 downto 56));
   

end behaviour;