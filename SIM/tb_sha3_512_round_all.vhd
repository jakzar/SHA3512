library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.stop;

entity tb_sha3_512_round_all is
end tb_sha3_512_round_all;

architecture behavior of tb_sha3_512_round_all is

    constant inClkp : time := 10ns;
    signal in_clk : std_logic := '0';
    signal in_data  : std_logic_vector(1599 downto 0);
    -- signal in_RC  : std_logic_vector(63 downto 0);
    signal out_data : std_logic_vector(1599 downto 0);
    signal out_data_2 : std_logic_vector(1599 downto 0);

    component sha3_512_round_all is
        port (
            in_clk  : in std_logic;
            in_data  : in  std_logic_vector(1599 downto 0);
            -- in_RC   : in  std_logic_vector(63 downto 0);
            out_data : out std_logic_vector(1599 downto 0)
        );
    end component;

begin
    in_clk <= not in_clk after inClkp/2;
    UUT: sha3_512_round_all
        port map (
            in_clk => in_clk,
            in_data  => in_data,
            -- in_RC => in_RC,
            out_data => out_data
        );


        -- process(in_clk)
        -- begin
        --     if(rising_edge(in_clk)) then
        --         out_data_2<=out_data;
        --     end if;
        -- end process;


    stimulus_proc: process
    begin
        in_data <= x"0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        -- in_RC <=x"0100000000000000";
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        stop;
    end process;

end behavior;
