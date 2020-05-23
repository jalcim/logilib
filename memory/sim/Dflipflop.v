#! /usr/bin/vvp
:ivl_version "10.2 (stable)";
:ivl_delay_selection "TYPICAL";
:vpi_time_precision + 0;
:vpi_module "system";
:vpi_module "vhdl_sys";
:vpi_module "v2005_math";
:vpi_module "va_math";
S_0x7fffdd1f7af0 .scope module, "gate_and" "gate_and" 2 8;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "e1"
    .port_info 1 /INPUT 1 "e2"
    .port_info 2 /OUTPUT 1 "s"
o0x7f338a750018 .functor BUFZ 1, C4<z>; HiZ drive
o0x7f338a750048 .functor BUFZ 1, C4<z>; HiZ drive
L_0x7fffdd21ecc0 .functor AND 1, o0x7f338a750018, o0x7f338a750048, C4<1>, C4<1>;
v0x7fffdd1f7c80_0 .net "e1", 0 0, o0x7f338a750018;  0 drivers
v0x7fffdd1f7550_0 .net "e2", 0 0, o0x7f338a750048;  0 drivers
v0x7fffdd1f3460_0 .net "s", 0 0, L_0x7fffdd21ecc0;  1 drivers
S_0x7fffdd1f3a40 .scope module, "gate_nor" "gate_nor" 2 37;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "e1"
    .port_info 1 /INPUT 1 "e2"
    .port_info 2 /OUTPUT 1 "s"
o0x7f338a750138 .functor BUFZ 1, C4<z>; HiZ drive
o0x7f338a750168 .functor BUFZ 1, C4<z>; HiZ drive
L_0x7fffdd21edc0 .functor NOR 1, o0x7f338a750138, o0x7f338a750168, C4<0>, C4<0>;
v0x7fffdd21a010_0 .net "e1", 0 0, o0x7f338a750138;  0 drivers
v0x7fffdd21a0d0_0 .net "e2", 0 0, o0x7f338a750168;  0 drivers
v0x7fffdd21a190_0 .net "s", 0 0, L_0x7fffdd21edc0;  1 drivers
S_0x7fffdd1f88a0 .scope module, "gate_or" "gate_or" 2 16;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "e1"
    .port_info 1 /INPUT 1 "e2"
    .port_info 2 /OUTPUT 1 "s"
o0x7f338a750258 .functor BUFZ 1, C4<z>; HiZ drive
o0x7f338a750288 .functor BUFZ 1, C4<z>; HiZ drive
L_0x7fffdd21eec0 .functor OR 1, o0x7f338a750258, o0x7f338a750288, C4<0>, C4<0>;
v0x7fffdd21a2b0_0 .net "e1", 0 0, o0x7f338a750258;  0 drivers
v0x7fffdd21a370_0 .net "e2", 0 0, o0x7f338a750288;  0 drivers
v0x7fffdd21a430_0 .net "s", 0 0, L_0x7fffdd21eec0;  1 drivers
S_0x7fffdd1fb870 .scope module, "gate_xor" "gate_xor" 2 23;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "e1"
    .port_info 1 /INPUT 1 "e2"
    .port_info 2 /OUTPUT 1 "s"
o0x7f338a750378 .functor BUFZ 1, C4<z>; HiZ drive
o0x7f338a7503a8 .functor BUFZ 1, C4<z>; HiZ drive
L_0x7fffdd21efc0 .functor XOR 1, o0x7f338a750378, o0x7f338a7503a8, C4<0>, C4<0>;
v0x7fffdd21a550_0 .net "e1", 0 0, o0x7f338a750378;  0 drivers
v0x7fffdd21a610_0 .net "e2", 0 0, o0x7f338a7503a8;  0 drivers
v0x7fffdd21a6d0_0 .net "s", 0 0, L_0x7fffdd21efc0;  1 drivers
S_0x7fffdd1fa880 .scope module, "test_Dflipflop" "test_Dflipflop" 3 1;
 .timescale 0 0;
v0x7fffdd21e9a0_0 .var "a", 0 0;
v0x7fffdd21ea60_0 .var "clk", 0 0;
v0x7fffdd21eb20_0 .net "s1", 0 0, L_0x7fffdd220d80;  1 drivers
v0x7fffdd21ebf0_0 .net "s2", 0 0, L_0x7fffdd220f90;  1 drivers
S_0x7fffdd21a7f0 .scope module, "test_Dflipflop" "Dflip_flop" 3 5, 4 18 0, S_0x7fffdd1fa880;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "a"
    .port_info 1 /INPUT 1 "clk"
    .port_info 2 /OUTPUT 1 "s1"
    .port_info 3 /OUTPUT 1 "s2"
L_0x7fffdd220d80 .functor BUF 1, L_0x7fffdd220e40, C4<0>, C4<0>, C4<0>;
L_0x7fffdd220f90 .functor BUF 1, L_0x7fffdd221000, C4<0>, C4<0>, C4<0>;
v0x7fffdd21e3b0_0 .net *"_s32", 0 0, L_0x7fffdd220e40;  1 drivers
v0x7fffdd21e490_0 .net *"_s34", 0 0, L_0x7fffdd221000;  1 drivers
v0x7fffdd21e570_0 .net "a", 0 0, v0x7fffdd21e9a0_0;  1 drivers
v0x7fffdd21e640_0 .net "clk", 0 0, v0x7fffdd21ea60_0;  1 drivers
v0x7fffdd21e6e0_0 .net "line", 6 0, L_0x7fffdd220a60;  1 drivers
v0x7fffdd21e7a0_0 .net "s1", 0 0, L_0x7fffdd220d80;  alias, 1 drivers
v0x7fffdd21e860_0 .net "s2", 0 0, L_0x7fffdd220f90;  alias, 1 drivers
L_0x7fffdd21ffc0 .part L_0x7fffdd220a60, 2, 1;
L_0x7fffdd2200b0 .part L_0x7fffdd220a60, 0, 1;
L_0x7fffdd220260 .part L_0x7fffdd220a60, 2, 1;
L_0x7fffdd220350 .part L_0x7fffdd220a60, 1, 1;
L_0x7fffdd2204e0 .part L_0x7fffdd220a60, 3, 1;
L_0x7fffdd220580 .part L_0x7fffdd220a60, 5, 1;
L_0x7fffdd220720 .part L_0x7fffdd220a60, 4, 1;
L_0x7fffdd220810 .part L_0x7fffdd220a60, 6, 1;
LS_0x7fffdd220a60_0_0 .concat8 [ 1 1 1 1], L_0x7fffdd21fbd0, L_0x7fffdd21fd30, L_0x7fffdd21fee0, L_0x7fffdd21ff50;
LS_0x7fffdd220a60_0_4 .concat8 [ 1 1 1 0], L_0x7fffdd2201f0, L_0x7fffdd2206b0, L_0x7fffdd220440;
L_0x7fffdd220a60 .concat8 [ 4 3 0 0], LS_0x7fffdd220a60_0_0, LS_0x7fffdd220a60_0_4;
L_0x7fffdd220e40 .part L_0x7fffdd220a60, 6, 1;
L_0x7fffdd221000 .part L_0x7fffdd220a60, 5, 1;
S_0x7fffdd21aa30 .scope module, "basc1" "basculeD" 4 23, 4 1 0, S_0x7fffdd21a7f0;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "a"
    .port_info 1 /INPUT 1 "clk"
    .port_info 2 /OUTPUT 1 "s1"
    .port_info 3 /OUTPUT 1 "s2"
L_0x7fffdd21fbd0 .functor BUF 1, L_0x7fffdd21fc40, C4<0>, C4<0>, C4<0>;
L_0x7fffdd21fd30 .functor BUF 1, L_0x7fffdd21fda0, C4<0>, C4<0>, C4<0>;
v0x7fffdd21c520_0 .net *"_s22", 0 0, L_0x7fffdd21fc40;  1 drivers
v0x7fffdd21c600_0 .net *"_s24", 0 0, L_0x7fffdd21fda0;  1 drivers
v0x7fffdd21c6e0_0 .net "a", 0 0, v0x7fffdd21e9a0_0;  alias, 1 drivers
v0x7fffdd21c800_0 .net "clk", 0 0, v0x7fffdd21ea60_0;  alias, 1 drivers
v0x7fffdd21c8f0_0 .net "line", 4 0, L_0x7fffdd21f960;  1 drivers
v0x7fffdd21ca00_0 .net "s1", 0 0, L_0x7fffdd21fbd0;  1 drivers
v0x7fffdd21cac0_0 .net "s2", 0 0, L_0x7fffdd21fd30;  1 drivers
L_0x7fffdd21f2d0 .part L_0x7fffdd21f960, 1, 1;
L_0x7fffdd21f470 .part L_0x7fffdd21f960, 0, 1;
L_0x7fffdd21f5b0 .part L_0x7fffdd21f960, 4, 1;
L_0x7fffdd21f710 .part L_0x7fffdd21f960, 2, 1;
L_0x7fffdd21f8c0 .part L_0x7fffdd21f960, 3, 1;
LS_0x7fffdd21f960_0_0 .concat8 [ 1 1 1 1], L_0x7fffdd21f0c0, L_0x7fffdd21f160, L_0x7fffdd21f200, L_0x7fffdd21f370;
LS_0x7fffdd21f960_0_4 .concat8 [ 1 0 0 0], L_0x7fffdd21f6a0;
L_0x7fffdd21f960 .concat8 [ 4 1 0 0], LS_0x7fffdd21f960_0_0, LS_0x7fffdd21f960_0_4;
L_0x7fffdd21fc40 .part L_0x7fffdd21f960, 3, 1;
L_0x7fffdd21fda0 .part L_0x7fffdd21f960, 4, 1;
S_0x7fffdd21acc0 .scope module, "nand1" "gate_nand" 4 6, 2 30 0, S_0x7fffdd21aa30;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "e1"
    .port_info 1 /INPUT 1 "e2"
    .port_info 2 /OUTPUT 1 "s"
L_0x7fffdd21f0c0 .functor NAND 1, v0x7fffdd21e9a0_0, v0x7fffdd21ea60_0, C4<1>, C4<1>;
v0x7fffdd21af20_0 .net "e1", 0 0, v0x7fffdd21e9a0_0;  alias, 1 drivers
v0x7fffdd21b000_0 .net "e2", 0 0, v0x7fffdd21ea60_0;  alias, 1 drivers
v0x7fffdd21b0c0_0 .net "s", 0 0, L_0x7fffdd21f0c0;  1 drivers
S_0x7fffdd21b210 .scope module, "nand2" "gate_nand" 4 9, 2 30 0, S_0x7fffdd21aa30;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "e1"
    .port_info 1 /INPUT 1 "e2"
    .port_info 2 /OUTPUT 1 "s"
L_0x7fffdd21f200 .functor NAND 1, L_0x7fffdd21f2d0, v0x7fffdd21ea60_0, C4<1>, C4<1>;
v0x7fffdd21b430_0 .net "e1", 0 0, L_0x7fffdd21f2d0;  1 drivers
v0x7fffdd21b510_0 .net "e2", 0 0, v0x7fffdd21ea60_0;  alias, 1 drivers
v0x7fffdd21b600_0 .net "s", 0 0, L_0x7fffdd21f200;  1 drivers
S_0x7fffdd21b710 .scope module, "nand3" "gate_nand" 4 11, 2 30 0, S_0x7fffdd21aa30;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "e1"
    .port_info 1 /INPUT 1 "e2"
    .port_info 2 /OUTPUT 1 "s"
L_0x7fffdd21f370 .functor NAND 1, L_0x7fffdd21f470, L_0x7fffdd21f5b0, C4<1>, C4<1>;
v0x7fffdd21b960_0 .net "e1", 0 0, L_0x7fffdd21f470;  1 drivers
v0x7fffdd21ba20_0 .net "e2", 0 0, L_0x7fffdd21f5b0;  1 drivers
v0x7fffdd21bae0_0 .net "s", 0 0, L_0x7fffdd21f370;  1 drivers
S_0x7fffdd21bc30 .scope module, "nand4" "gate_nand" 4 12, 2 30 0, S_0x7fffdd21aa30;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "e1"
    .port_info 1 /INPUT 1 "e2"
    .port_info 2 /OUTPUT 1 "s"
L_0x7fffdd21f6a0 .functor NAND 1, L_0x7fffdd21f710, L_0x7fffdd21f8c0, C4<1>, C4<1>;
v0x7fffdd21be50_0 .net "e1", 0 0, L_0x7fffdd21f710;  1 drivers
v0x7fffdd21bf30_0 .net "e2", 0 0, L_0x7fffdd21f8c0;  1 drivers
v0x7fffdd21bff0_0 .net "s", 0 0, L_0x7fffdd21f6a0;  1 drivers
S_0x7fffdd21c140 .scope module, "not1" "gate_not" 4 8, 2 1 0, S_0x7fffdd21aa30;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "e1"
    .port_info 1 /OUTPUT 1 "s"
L_0x7fffdd21f160 .functor NOT 1, v0x7fffdd21e9a0_0, C4<0>, C4<0>, C4<0>;
v0x7fffdd21c360_0 .net "e1", 0 0, v0x7fffdd21e9a0_0;  alias, 1 drivers
v0x7fffdd21c420_0 .net "s", 0 0, L_0x7fffdd21f160;  1 drivers
S_0x7fffdd21cc00 .scope module, "nand1" "gate_nand" 4 26, 2 30 0, S_0x7fffdd21a7f0;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "e1"
    .port_info 1 /INPUT 1 "e2"
    .port_info 2 /OUTPUT 1 "s"
L_0x7fffdd21ff50 .functor NAND 1, L_0x7fffdd21ffc0, L_0x7fffdd2200b0, C4<1>, C4<1>;
v0x7fffdd21ce40_0 .net "e1", 0 0, L_0x7fffdd21ffc0;  1 drivers
v0x7fffdd21cf20_0 .net "e2", 0 0, L_0x7fffdd2200b0;  1 drivers
v0x7fffdd21cfe0_0 .net "s", 0 0, L_0x7fffdd21ff50;  1 drivers
S_0x7fffdd21d100 .scope module, "nand2" "gate_nand" 4 27, 2 30 0, S_0x7fffdd21a7f0;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "e1"
    .port_info 1 /INPUT 1 "e2"
    .port_info 2 /OUTPUT 1 "s"
L_0x7fffdd2201f0 .functor NAND 1, L_0x7fffdd220260, L_0x7fffdd220350, C4<1>, C4<1>;
v0x7fffdd21d320_0 .net "e1", 0 0, L_0x7fffdd220260;  1 drivers
v0x7fffdd21d3e0_0 .net "e2", 0 0, L_0x7fffdd220350;  1 drivers
v0x7fffdd21d4a0_0 .net "s", 0 0, L_0x7fffdd2201f0;  1 drivers
S_0x7fffdd21d5c0 .scope module, "nand3" "gate_nand" 4 29, 2 30 0, S_0x7fffdd21a7f0;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "e1"
    .port_info 1 /INPUT 1 "e2"
    .port_info 2 /OUTPUT 1 "s"
L_0x7fffdd220440 .functor NAND 1, L_0x7fffdd2204e0, L_0x7fffdd220580, C4<1>, C4<1>;
v0x7fffdd21d7e0_0 .net "e1", 0 0, L_0x7fffdd2204e0;  1 drivers
v0x7fffdd21d8c0_0 .net "e2", 0 0, L_0x7fffdd220580;  1 drivers
v0x7fffdd21d980_0 .net "s", 0 0, L_0x7fffdd220440;  1 drivers
S_0x7fffdd21dad0 .scope module, "nand4" "gate_nand" 4 30, 2 30 0, S_0x7fffdd21a7f0;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "e1"
    .port_info 1 /INPUT 1 "e2"
    .port_info 2 /OUTPUT 1 "s"
L_0x7fffdd2206b0 .functor NAND 1, L_0x7fffdd220720, L_0x7fffdd220810, C4<1>, C4<1>;
v0x7fffdd21dd40_0 .net "e1", 0 0, L_0x7fffdd220720;  1 drivers
v0x7fffdd21de20_0 .net "e2", 0 0, L_0x7fffdd220810;  1 drivers
v0x7fffdd21dee0_0 .net "s", 0 0, L_0x7fffdd2206b0;  1 drivers
S_0x7fffdd21e000 .scope module, "not1" "gate_not" 4 24, 2 1 0, S_0x7fffdd21a7f0;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "e1"
    .port_info 1 /OUTPUT 1 "s"
L_0x7fffdd21fee0 .functor NOT 1, v0x7fffdd21ea60_0, C4<0>, C4<0>, C4<0>;
v0x7fffdd21e1d0_0 .net "e1", 0 0, v0x7fffdd21ea60_0;  alias, 1 drivers
v0x7fffdd21e290_0 .net "s", 0 0, L_0x7fffdd21fee0;  1 drivers
    .scope S_0x7fffdd1fa880;
T_0 ;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7fffdd21e9a0_0, 0, 1;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7fffdd21ea60_0, 0, 1;
    %delay 5, 0;
    %pushi/vec4 1, 0, 1;
    %store/vec4 v0x7fffdd21e9a0_0, 0, 1;
    %pushi/vec4 1, 0, 1;
    %store/vec4 v0x7fffdd21ea60_0, 0, 1;
    %delay 5, 0;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7fffdd21e9a0_0, 0, 1;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7fffdd21ea60_0, 0, 1;
    %delay 5, 0;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7fffdd21e9a0_0, 0, 1;
    %pushi/vec4 1, 0, 1;
    %store/vec4 v0x7fffdd21ea60_0, 0, 1;
    %delay 5, 0;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7fffdd21e9a0_0, 0, 1;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7fffdd21ea60_0, 0, 1;
    %delay 5, 0;
    %pushi/vec4 1, 0, 1;
    %store/vec4 v0x7fffdd21e9a0_0, 0, 1;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7fffdd21ea60_0, 0, 1;
    %delay 5, 0;
    %pushi/vec4 0, 0, 1;
    %store/vec4 v0x7fffdd21e9a0_0, 0, 1;
    %pushi/vec4 1, 0, 1;
    %store/vec4 v0x7fffdd21ea60_0, 0, 1;
    %delay 5, 0;
    %pushi/vec4 1, 0, 1;
    %store/vec4 v0x7fffdd21e9a0_0, 0, 1;
    %pushi/vec4 1, 0, 1;
    %store/vec4 v0x7fffdd21ea60_0, 0, 1;
    %end;
    .thread T_0;
    .scope S_0x7fffdd1fa880;
T_1 ;
    %vpi_call 3 35 "$dumpfile", "signal/signal_Dflipflop.vcd" {0 0 0};
    %vpi_call 3 36 "$dumpvars" {0 0 0};
    %end;
    .thread T_1;
    .scope S_0x7fffdd1fa880;
T_2 ;
    %vpi_call 3 40 "$display", "\011\011time, \011a, \011clk, \011s1, \011s2" {0 0 0};
    %vpi_call 3 41 "$monitor", "%d \011%b \011%b \011%b \011%b", $time, v0x7fffdd21e9a0_0, v0x7fffdd21ea60_0, v0x7fffdd21eb20_0, v0x7fffdd21ebf0_0 {0 0 0};
    %end;
    .thread T_2;
# The file index is used to find the file name in the following table.
:file_names 5;
    "N/A";
    "<interactive>";
    "../primitive/src/gate.v";
    "test/test_Dflipflop.v";
    "src/basculeD.v";
