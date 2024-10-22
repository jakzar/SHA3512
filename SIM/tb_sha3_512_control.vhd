library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.stop;

entity tb_sha3_512_control is
end tb_sha3_512_control;

architecture behavior of tb_sha3_512_control is

    constant inClkp : time := 10ns;
    signal in_clk : std_logic := '0';
    signal in_ext_data_wr       :  std_logic;
    signal in_ext_init         :    std_logic;
    signal out_state_reg_in_hash_init  :    std_logic;
    signal out_state_reg_in_hash_wr  :    std_logic;
    signal out_state_reg_in_state_init  :    std_logic;
    signal out_state_reg_in_state_wr  :    std_logic;
    signal out_round_number     :  std_logic_vector (5 downto 0);
    signal out_busy     :  std_logic;

    component sha3_512_control is
        port (
            in_clk       : in std_logic;
            in_ext_data_wr       : in std_logic;
            in_ext_init         :   in std_logic;
            out_state_reg_in_hash_init  :   out std_logic;
            out_state_reg_in_hash_wr  :   out std_logic;
            out_state_reg_in_state_init  :   out std_logic;
            out_state_reg_in_state_wr  :   out std_logic;
            out_round_number     : out std_logic_vector (5 downto 0);
            out_busy     : out std_logic
        );
    end component;

begin
    in_clk <= not in_clk after inClkp/2;
    UUT: sha3_512_control
        port map (
            in_clk => in_clk,
            in_ext_data_wr  =>  in_ext_data_wr,
            in_ext_init => in_ext_init,
            out_state_reg_in_hash_init => out_state_reg_in_hash_init,
            out_state_reg_in_hash_wr => out_state_reg_in_hash_wr,
            out_state_reg_in_state_init => out_state_reg_in_state_init,
            out_state_reg_in_state_wr => out_state_reg_in_state_wr,
            out_round_number => out_round_number,
            out_busy => out_busy
        );


        -- process(in_clk)
        -- begin
        --     if(rising_edge(in_clk)) then
        --         out_data_2<=out_data;
        --     end if;
        -- end process;


    stimulus_proc: process
    begin
        in_ext_init<='1';
        wait for 10 ns;
        in_ext_init<='0';
        in_ext_data_wr<='1';
        wait for 10 ns;
        in_ext_data_wr<='0';
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
