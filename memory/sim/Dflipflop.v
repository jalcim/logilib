#! /usr/bin/vvp
:ivl_version "10.2 (stable)";
:ivl_delay_selection "TYPICAL";
:vpi_time_precision + 0;
:vpi_module "system";
:vpi_module "vhdl_sys";
:vpi_module "v2005_math";
:vpi_module "va_math";
S_0x7fffec7916a0 .scope module, "gate_nor" "gate_nor" 2 37;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "e1"
    .port_info 1 /INPUT 1 "e2"
    .port_info 2 /OUTPUT 1 "s"
o0x7f9869e90018 .functor BUFZ 1, C4<z>; HiZ drive
o0x7f9869e90048 .functor BUFZ 1, C4<z>; HiZ drive
L_0x7fffec7bafb0 .functor NOR 1, o0x7f9869e90018, o0x7f9869e90048, C4<0>, C4<0>;
v0x7fffec78cce0_0 .net "e1", 0 0, o0x7f9869e90018;  0 drivers
v0x7fffec7b3a80_0 .net "e2", 0 0, o0x7f9869e90048;  0 drivers
v0x7fffec7b3b40_0 .net "s", 0 0, L_0x7fffec7bafb0;  1 drivers
S_0x7fffec78f830 .scope module, "test_Dflipflop" "test_Dflipflop" 3 1;
 .timescale 0 0;
v0x7fffec7bac20_0 .var "a", 0 0;
v0x7fffec7bace0_0 .var "clk", 0 0;
v0x7fffec7bada0_0 .var "reset", 0 0;
v0x7fffec7bae40_0 .net "s1", 0 0, L_0x7fffec7bdcd0;  1 drivers
v0x7fffec7baf10_0 .net "s2", 0 0, L_0x7fffec7bde80;  1 drivers
S_0x7fffec7b3c60 .scope module, "test_Dflipflop" "Dflip_flop" 3 5, 4 22 0, S_0x7fffec78f830;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "a"
    .port_info 1 /INPUT 1 "clk"
    .port_info 2 /INPUT 1 "reset"
    .port_info 3 /OUTPUT 1 "s1"
    .port_info 4 /OUTPUT 1 "s2"
L_0x7fffec7bdcd0 .functor BUF 1, L_0x7fffec7bdd90, C4<0>, C4<0>, C4<0>;
L_0x7fffec7bde80 .functor BUF 1, L_0x7fffec7bdef0, C4<0>, C4<0>, C4<0>;
v0x7fffec7ba3d0_0 .net *"_s14", 0 0, L_0x7fffec7bdd90;  1 drivers
v0x7fffec7ba4b0_0 .net *"_s16", 0 0, L_0x7fffec7bdef0;  1 drivers
v0x7fffec7ba590_0 .net "a", 0 0, v0x7fffec7bac20_0;  1 drivers
v0x7fffec7ba630_0 .net "clk", 0 0, v0x7fffec7bace0_0;  1 drivers
v0x7fffec7ba760_0 .net "ignore", 0 0, L_0x7fffec7bc410;  1 drivers
v0x7fffec7ba800_0 .net "line", 3 0, L_0x7fffec7bdaf0;  1 drivers
v0x7fffec7ba8a0_0 .net "reset", 0 0, v0x7fffec7bada0_0;  1 drivers
v0x7fffec7ba940_0 .net "s1", 0 0, L_0x7fffec7bdcd0;  alias, 1 drivers
v0x7fffec7baa00_0 .net "s2", 0 0, L_0x7fffec7bde80;  alias, 1 drivers
L_0x7fffec7bd960 .part L_0x7fffec7bdaf0, 0, 1;
L_0x7fffec7bda00 .part L_0x7fffec7bdaf0, 1, 1;
L_0x7fffec7bdaf0 .concat8 [ 1 1 1 1], L_0x7fffec7bc250, L_0x7fffec7bc570, L_0x7fffec7bd690, L_0x7fffec7bd850;
L_0x7fffec7bdd90 .part L_0x7fffec7bdaf0, 2, 1;
L_0x7fffec7bdef0 .part L_0x7fffec7bdaf0, 3, 1;
S_0x7fffec7b3eb0 .scope module, "basc1" "basculeD" 4 28, 4 1 0, S_0x7fffec7b3c60;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "a"
    .port_info 1 /INPUT 1 "clk"
    .port_info 2 /INPUT 1 "reset"
    .port_info 3 /OUTPUT 1 "s1"
    .port_info 4 /OUTPUT 1 "s2"
L_0x7fffec7bc250 .functor BUF 1, L_0x7fffec7bc2c0, C4<0>, C4<0>, C4<0>;
L_0x7fffec7bc410 .functor BUF 1, L_0x7fffec7bc480, C4<0>, C4<0>, C4<0>;
v0x7fffec7b6840_0 .net *"_s34", 0 0, L_0x7fffec7bc2c0;  1 drivers
v0x7fffec7b6920_0 .net *"_s36", 0 0, L_0x7fffec7bc480;  1 drivers
v0x7fffec7b6a00_0 .net "a", 0 0, v0x7fffec7bac20_0;  alias, 1 drivers
v0x7fffec7b6ad0_0 .net "clk", 0 0, v0x7fffec7bace0_0;  alias, 1 drivers
v0x7fffec7b6bc0_0 .net "line", 7 0, L_0x7fffec7bbee0;  1 drivers
v0x7fffec7b6cd0_0 .net "reset", 0 0, v0x7fffec7bada0_0;  alias, 1 drivers
v0x7fffec7b6dc0_0 .net "s1", 0 0, L_0x7fffec7bc250;  1 drivers
v0x7fffec7b6e80_0 .net "s2", 0 0, L_0x7fffec7bc410;  alias, 1 drivers
L_0x7fffec7bb220 .part L_0x7fffec7bbee0, 5, 1;
L_0x7fffec7bb430 .part L_0x7fffec7bbee0, 6, 1;
L_0x7fffec7bb5e0 .part L_0x7fffec7bbee0, 1, 1;
L_0x7fffec7bb7a0 .part L_0x7fffec7bbee0, 0, 1;
L_0x7fffec7bb8c0 .part L_0x7fffec7bbee0, 7, 1;
L_0x7fffec7bba00 .part L_0x7fffec7bbee0, 2, 1;
L_0x7fffec7bbb30 .part L_0x7fffec7bbee0, 3, 1;
L_0x7fffec7bbc90 .part L_0x7fffec7bbee0, 4, 1;
LS_0x7fffec7bbee0_0_0 .concat8 [ 1 1 1 1], L_0x7fffec7bb2c0, L_0x7fffec7bb360, L_0x7fffec7bb570, L_0x7fffec7bb6d0;
LS_0x7fffec7bbee0_0_4 .concat8 [ 1 1 1 1], L_0x7fffec7bb960, L_0x7fffec7bb0b0, L_0x7fffec7bb150, L_0x7fffec7bbc20;
L_0x7fffec7bbee0 .concat8 [ 4 4 0 0], LS_0x7fffec7bbee0_0_0, LS_0x7fffec7bbee0_0_4;
L_0x7fffec7bc2c0 .part L_0x7fffec7bbee0, 3, 1;
L_0x7fffec7bc480 .part L_0x7fffec7bbee0, 4, 1;
S_0x7fffec7b4120 .scope module, "and1" "gate_and" 4 7, 2 8 0, S_0x7fffec7b3eb0;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "e1"
    .port_info 1 /INPUT 1 "e2"
    .port_info 2 /OUTPUT 1 "s"
L_0x7fffec7bb150 .functor AND 1, v0x7fffec7bac20_0, L_0x7fffec7bb220, C4<1>, C4<1>;
v0x7fffec7b4380_0 .net "e1", 0 0, v0x7fffec7bac20_0;  alias, 1 drivers
v0x7fffec7b4460_0 .net "e2", 0 0, L_0x7fffec7bb220;  1 drivers
v0x7fffec7b4520_0 .net "s", 0 0, L_0x7fffec7bb150;  1 drivers
S_0x7fffec7b4640 .scope module, "nand1" "gate_nand" 4 9, 2 30 0, S_0x7fffec7b3eb0;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "e1"
    .port_info 1 /INPUT 1 "e2"
    .port_info 2 /OUTPUT 1 "s"
L_0x7fffec7bb2c0 .functor NAND 1, v0x7fffec7bac20_0, v0x7fffec7bace0_0, C4<1>, C4<1>;
v0x7fffec7b4860_0 .net "e1", 0 0, v0x7fffec7bac20_0;  alias, 1 drivers
v0x7fffec7b4920_0 .net "e2", 0 0, v0x7fffec7bace0_0;  alias, 1 drivers
v0x7fffec7b49c0_0 .net "s", 0 0, L_0x7fffec7bb2c0;  1 drivers
S_0x7fffec7b4b10 .scope module, "nand2" "gate_nand" 4 11, 2 30 0, S_0x7fffec7b3eb0;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "e1"
    .port_info 1 /INPUT 1 "e2"
    .port_info 2 /OUTPUT 1 "s"
L_0x7fffec7bb570 .functor NAND 1, L_0x7fffec7bb5e0, v0x7fffec7bace0_0, C4<1>, C4<1>;
v0x7fffec7b4d60_0 .net "e1", 0 0, L_0x7fffec7bb5e0;  1 drivers
v0x7fffec7b4e20_0 .net "e2", 0 0, v0x7fffec7bace0_0;  alias, 1 drivers
v0x7fffec7b4f10_0 .net "s", 0 0, L_0x7fffec7bb570;  1 drivers
S_0x7fffec7b5020 .scope module, "nand3" "gate_nand" 4 13, 2 30 0, S_0x7fffec7b3eb0;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "e1"
    .port_info 1 /INPUT 1 "e2"
    .port_info 2 /OUTPUT 1 "s"
L_0x7fffec7bb6d0 .functor NAND 1, L_0x7fffec7bb7a0, L_0x7fffec7bb8c0, C4<1>, C4<1>;
v0x7fffec7b5240_0 .net "e1", 0 0, L_0x7fffec7bb7a0;  1 drivers
v0x7fffec7b5320_0 .net "e2", 0 0, L_0x7fffec7bb8c0;  1 drivers
v0x7fffec7b53e0_0 .net "s", 0 0, L_0x7fffec7bb6d0;  1 drivers
S_0x7fffec7b5530 .scope module, "nand4" "gate_nand" 4 14, 2 30 0, S_0x7fffec7b3eb0;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "e1"
    .port_info 1 /INPUT 1 "e2"
    .port_info 2 /OUTPUT 1 "s"
L_0x7fffec7bb960 .functor NAND 1, L_0x7fffec7bba00, L_0x7fffec7bbb30, C4<1>, C4<1>;
v0x7fffec7b57a0_0 .net "e1", 0 0, L_0x7fffec7bba00;  1 drivers
v0x7fffec7b5880_0 .net "e2", 0 0, L_0x7fffec7bbb30;  1 drivers
v0x7fffec7b5940_0 .net "s", 0 0, L_0x7fffec7bb960;  1 drivers
S_0x7fffec7b5a60 .scope module, "not1" "gate_not" 4 10, 2 1 0, S_0x7fffec7b3eb0;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "e1"
    .port_info 1 /OUTPUT 1 "s"
L_0x7fffec7bb360 .functor NOT 1, L_0x7fffec7bb430, C4<0>, C4<0>, C4<0>;
v0x7fffec7b5c30_0 .net "e1", 0 0, L_0x7fffec7bb430;  1 drivers
v0x7fffec7b5d10_0 .net "s", 0 0, L_0x7fffec7bb360;  1 drivers
S_0x7fffec7b5e30 .scope module, "or1" "gate_or" 4 16, 2 16 0, S_0x7fffec7b3eb0;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "e1"
    .port_info 1 /INPUT 1 "e2"
    .port_info 2 /OUTPUT 1 "s"
L_0x7fffec7bbc20 .functor OR 1, v0x7fffec7bada0_0, L_0x7fffec7bbc90, C4<0>, C4<0>;
v0x7fffec7b6050_0 .net "e1", 0 0, v0x7fffec7bada0_0;  alias, 1 drivers
v0x7fffec7b6130_0 .net "e2", 0 0, L_0x7fffec7bbc90;  1 drivers
v0x7fffec7b61f0_0 .net "s", 0 0, L_0x7fffec7bbc20;  1 drivers
S_0x7fffec7b6340 .scope module, "xor1" "gate_xor" 4 6, 2 23 0, S_0x7fffec7b3eb0;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "e1"
    .port_info 1 /INPUT 1 "e2"
    .port_info 2 /OUTPUT 1 "s"
L_0x7fffec7bb0b0 .functor XOR 1, v0x7fffec7bac20_0, v0x7fffec7bada0_0, C4<0>, C4<0>;
v0x7fffec7b6560_0 .net "e1", 0 0, v0x7fffec7bac20_0;  alias, 1 drivers
v0x7fffec7b6670_0 .net "e2", 0 0, v0x7fffec7bada0_0;  alias, 1 drivers
v0x7fffec7b6730_0 .net "s", 0 0, L_0x7fffec7bb0b0;  1 drivers
S_0x7fffec7b6fe0 .scope module, "basc2" "basculeD" 4 30, 4 1 0, S_0x7fffec7b3c60;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "a"
    .port_info 1 /INPUT 1 "clk"
    .port_info 2 /INPUT 1 "reset"
    .port_info 3 /OUTPUT 1 "s1"
    .port_info 4 /OUTPUT 1 "s2"
L_0x7fffec7bd690 .functor BUF 1, L_0x7fffec7bd700, C4<0>, C4<0>, C4<0>;
L_0x7fffec7bd850 .functor BUF 1, L_0x7fffec7bd8c0, C4<0>, C4<0>, C4<0>;
v0x7fffec7b9920_0 .net *"_s34", 0 0, L_0x7fffec7bd700;  1 drivers
v0x7fffec7b9a00_0 .net *"_s36", 0 0, L_0x7fffec7bd8c0;  1 drivers
v0x7fffec7b9ae0_0 .net "a", 0 0, L_0x7fffec7bd960;  1 drivers
v0x7fffec7b9bb0_0 .net "clk", 0 0, L_0x7fffec7bda00;  1 drivers
v0x7fffec7b9c50_0 .net "line", 7 0, L_0x7fffec7bd320;  1 drivers
v0x7fffec7b9d60_0 .net "reset", 0 0, v0x7fffec7bada0_0;  alias, 1 drivers
v0x7fffec7b9e00_0 .net "s1", 0 0, L_0x7fffec7bd690;  1 drivers
v0x7fffec7b9ec0_0 .net "s2", 0 0, L_0x7fffec7bd850;  1 drivers
L_0x7fffec7bc7d0 .part L_0x7fffec7bd320, 5, 1;
L_0x7fffec7bc950 .part L_0x7fffec7bd320, 6, 1;
L_0x7fffec7bcb00 .part L_0x7fffec7bd320, 1, 1;
L_0x7fffec7bcc10 .part L_0x7fffec7bd320, 0, 1;
L_0x7fffec7bcd30 .part L_0x7fffec7bd320, 7, 1;
L_0x7fffec7bce40 .part L_0x7fffec7bd320, 2, 1;
L_0x7fffec7bcf70 .part L_0x7fffec7bd320, 3, 1;
L_0x7fffec7bd0d0 .part L_0x7fffec7bd320, 4, 1;
LS_0x7fffec7bd320_0_0 .concat8 [ 1 1 1 1], L_0x7fffec7bc870, L_0x7fffec7bc8e0, L_0x7fffec7bca90, L_0x7fffec7bcba0;
LS_0x7fffec7bd320_0_4 .concat8 [ 1 1 1 1], L_0x7fffec7bcdd0, L_0x7fffec7bc6f0, L_0x7fffec7bc760, L_0x7fffec7bd060;
L_0x7fffec7bd320 .concat8 [ 4 4 0 0], LS_0x7fffec7bd320_0_0, LS_0x7fffec7bd320_0_4;
L_0x7fffec7bd700 .part L_0x7fffec7bd320, 3, 1;
L_0x7fffec7bd8c0 .part L_0x7fffec7bd320, 4, 1;
S_0x7fffec7b7250 .scope module, "and1" "gate_and" 4 7, 2 8 0, S_0x7fffec7b6fe0;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "e1"
    .port_info 1 /INPUT 1 "e2"
    .port_info 2 /OUTPUT 1 "s"
L_0x7fffec7bc760 .functor AND 1, L_0x7fffec7bd960, L_0x7fffec7bc7d0, C4<1>, C4<1>;
v0x7fffec7b7490_0 .net "e1", 0 0, L_0x7fffec7bd960;  alias, 1 drivers
v0x7fffec7b7570_0 .net "e2", 0 0, L_0x7fffec7bc7d0;  1 drivers
v0x7fffec7b7630_0 .net "s", 0 0, L_0x7fffec7bc760;  1 drivers
S_0x7fffec7b7750 .scope module, "nand1" "gate_nand" 4 9, 2 30 0, S_0x7fffec7b6fe0;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "e1"
    .port_info 1 /INPUT 1 "e2"
    .port_info 2 /OUTPUT 1 "s"
L_0x7fffec7bc870 .functor NAND 1, L_0x7fffec7bd960, L_0x7fffec7bda00, C4<1>, C4<1>;
v0x7fffec7b7970_0 .net "e1", 0 0, L_0x7fffec7bd960;  alias, 1 drivers
v0x7fffec7b7a30_0 .net "e2", 0 0, L_0x7fffec7bda00;  alias, 1 drivers
v0x7fffec7b7ad0_0 .net "s", 0 0, L_0x7fffec7bc870;  1 drivers
S_0x7fffec7b7c20 .scope module, "nand2" "gate_nand" 4 11, 2 30 0, S_0x7fffec7b6fe0;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "e1"
    .port_info 1 /INPUT 1 "e2"
    .port_info 2 /OUTPUT 1 "s"
L_0x7fffec7bca90 .functor NAND 1, L_0x7fffec7bcb00, L_0x7fffec7bda00, C4<1>, C4<1>;
v0x7fffec7b7e70_0 .net "e1", 0 0, L_0x7fffec7bcb00;  1 drivers
v0x7fffec7b7f30_0 .net "e2", 0 0, L_0x7fffec7bda00;  alias, 1 drivers
v0x7fffec7b8020_0 .net "s", 0 0, L_0x7fffec7bca90;  1 drivers
S_0x7fffec7b8130 .scope module, "nand3" "gate_nand" 4 13, 2 30 0, S_0x7fffec7b6fe0;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "e1"
    .port_info 1 /INPUT 1 "e2"
    .port_info 2 /OUTPUT 1 "s"
L_0x7fffec7bcba0 .functor NAND 1, L_0x7fffec7bcc10, L_0x7fffec7bcd30, C4<1>, C4<1>;
v0x7fffec7b8350_0 .net "e1", 0 0, L_0x7fffec7bcc10;  1 drivers
v0x7fffec7b8430_0 .net "e2", 0 0, L_0x7fffec7bcd30;  1 drivers
v0x7fffec7b84f0_0 .net "s", 0 0, L_0x7fffec7bcba0;  1 drivers
S_0x7fffec7b8640 .scope module, "nand4" "gate_nand" 4 14, 2 30 0, S_0x7fffec7b6fe0;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "e1"
    .port_info 1 /INPUT 1 "e2"
    .port_info 2 /OUTPUT 1 "s"
L_0x7fffec7bcdd0 .functor NAND 1, L_0x7fffec7bce40, L_0x7fffec7bcf70, C4<1>, C4<1>;
v0x7fffec7b88b0_0 .net "e1", 0 0, L_0x7fffec7bce40;  1 drivers
v0x7fffec7b8990_0 .net "e2", 0 0, L_0x7fffec7bcf70;  1 drivers
v0x7fffec7b8a50_0 .net "s", 0 0, L_0x7fffec7bcdd0;  1 drivers
S_0x7fffec7b8b70 .scope module, "not1" "gate_not" 4 10, 2 1 0, S_0x7fffec7b6fe0;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "e1"
    .port_info 1 /OUTPUT 1 "s"
L_0x7fffec7bc8e0 .functor NOT 1, L_0x7fffec7bc950, C4<0>, C4<0>, C4<0>;
v0x7fffec7b8d40_0 .net "e1", 0 0, L_0x7fffec7bc950;  1 drivers
v0x7fffec7b8e20_0 .net "s", 0 0, L_0x7fffec7bc8e0;  1 drivers
S_0x7fffec7b8f40 .scope module, "or1" "gate_or" 4 16, 2 16 0, S_0x7fffec7b6fe0;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "e1"
    .port_info 1 /INPUT 1 "e2"
    .port_info 2 /OUTPUT 1 "s"
L_0x7fffec7bd060 .functor OR 1, v0x7fffec7bada0_0, L_0x7fffec7bd0d0, C4<0>, C4<0>;
v0x7fffec7b9160_0 .net "e1", 0 0, v0x7fffec7bada0_0;  alias, 1 drivers
v0x7fffec7b9220_0 .net "e2", 0 0, L_0x7fffec7bd0d0;  1 drivers
v0x7fffec7b92e0_0 .net "s", 0 0, L_0x7fffec7bd060;  1 drivers
S_0x7fffec7b9430 .scope module, "xor1" "gate_xor" 4 6, 2 23 0, S_0x7fffec7b6fe0;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "e1"
    .port_info 1 /INPUT 1 "e2"
    .port_info 2 /OUTPUT 1 "s"
L_0x7fffec7bc6f0 .functor XOR 1, L_0x7fffec7bd960, v0x7fffec7bada0_0, C4<0>, C4<0>;
v0x7fffec7b9650_0 .net "e1", 0 0, L_0x7fffec7bd960;  alias, 1 drivers
v0x7fffec7b9760_0 .net "e2", 0 0, v0x7fffec7bada0_0;  alias, 1 drivers
v0x7fffec7b9820_0 .net "s", 0 0, L_0x7fffec7bc6f0;  1 drivers
S_0x7fffec7ba020 .scope module, "not1" "gate_not" 4 29, 2 1 0, S_0x7fffec7b3c60;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "e1"
    .port_info 1 /OUTPUT 1 "s"
L_0x7fffec7bc570 .functor NOT 1, v0x7fffec7bace0_0, C4<0>, C4<0>, C4<0>;
v0x7fffec7ba1f0_0 .net "e1", 0 0, v0x7fffec7bace0_0;  alias, 1 drivers
v0x7fffec7ba2b0_0 .net "s", 0 0, L_0x7fffec7bc570;  1 drivers
    .scope S_0x7fffec78f830;
T_0 ;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7fffec7bac20_0, 0, 1;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7fffec7bace0_0, 0, 1;
    %pushi/vec4 1, 0, 1;
    %store/vec4 v0x7fffec7bada0_0, 0, 1;
    %delay 5, 0;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7fffec7bac20_0, 0, 1;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7fffec7bace0_0, 0, 1;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7fffec7bada0_0, 0, 1;
    %delay 5, 0;
    %pushi/vec4 1, 0, 1;
    %store/vec4 v0x7fffec7bac20_0, 0, 1;
    %pushi/vec4 1, 0, 1;
    %store/vec4 v0x7fffec7bace0_0, 0, 1;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7fffec7bada0_0, 0, 1;
    %delay 5, 0;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7fffec7bac20_0, 0, 1;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7fffec7bace0_0, 0, 1;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7fffec7bada0_0, 0, 1;
    %delay 5, 0;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7fffec7bac20_0, 0, 1;
    %pushi/vec4 1, 0, 1;
    %store/vec4 v0x7fffec7bace0_0, 0, 1;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7fffec7bada0_0, 0, 1;
    %delay 5, 0;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7fffec7bac20_0, 0, 1;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7fffec7bace0_0, 0, 1;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7fffec7bada0_0, 0, 1;
    %delay 5, 0;
    %pushi/vec4 1, 0, 1;
    %store/vec4 v0x7fffec7bac20_0, 0, 1;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7fffec7bace0_0, 0, 1;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7fffec7bada0_0, 0, 1;
    %delay 5, 0;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7fffec7bac20_0, 0, 1;
    %pushi/vec4 1, 0, 1;
    %store/vec4 v0x7fffec7bace0_0, 0, 1;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7fffec7bada0_0, 0, 1;
    %delay 5, 0;
    %pushi/vec4 1, 0, 1;
    %store/vec4 v0x7fffec7bac20_0, 0, 1;
    %pushi/vec4 1, 0, 1;
    %store/vec4 v0x7fffec7bace0_0, 0, 1;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7fffec7bada0_0, 0, 1;
    %delay 5, 0;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7fffec7bac20_0, 0, 1;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7fffec7bace0_0, 0, 1;
    %pushi/vec4 1, 0, 1;
    %store/vec4 v0x7fffec7bada0_0, 0, 1;
    %delay 5, 0;
    %end;
    .thread T_0;
    .scope S_0x7fffec78f830;
T_1 ;
    %vpi_call 3 52 "$dumpfile", "signal/signal_Dflipflop.vcd" {0 0 0};
    %vpi_call 3 53 "$dumpvars" {0 0 0};
    %end;
    .thread T_1;
    .scope S_0x7fffec78f830;
T_2 ;
    %vpi_call 3 57 "$display", "\011\011time, \011a, \011clk, \011s1, \011s2" {0 0 0};
    %vpi_call 3 58 "$monitor", "%d \011%b \011%b \011%b \011%b", $time, v0x7fffec7bac20_0, v0x7fffec7bace0_0, v0x7fffec7bae40_0, v0x7fffec7baf10_0 {0 0 0};
    %end;
    .thread T_2;
# The file index is used to find the file name in the following table.
:file_names 5;
    "N/A";
    "<interactive>";
    "../primitive/src/gate.v";
    "test/test_Dflipflop.v";
    "src/basculeD.v";
