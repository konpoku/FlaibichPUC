// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (lin64) Build 2708876 Wed Nov  6 21:39:14 MST 2019
// Date        : Mon Jul 14 14:59:53 2025
// Host        : LAPTOP-4DRR49VU running 64-bit Ubuntu 24.04.2 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/konpoku/Flaibich/FlaibichPUC/FlaibichPUC.srcs/sources_1/ip/mult_gen_0/mult_gen_0_sim_netlist.v
// Design      : mult_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a200tfbg676-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "mult_gen_0,mult_gen_v12_0_16,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "mult_gen_v12_0_16,Vivado 2019.2" *) 
(* NotValidForBitStream *)
module mult_gen_0
   (A,
    B,
    P);
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [31:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [31:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [31:0]P;

  wire [31:0]A;
  wire [31:0]B;
  wire [31:0]P;
  wire [47:0]NLW_U0_PCASC_UNCONNECTED;
  wire [1:0]NLW_U0_ZERO_DETECT_UNCONNECTED;

  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "32" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_VALUE = "10000001" *) 
  (* C_B_WIDTH = "32" *) 
  (* C_CCM_IMP = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "0" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "1" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "31" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  mult_gen_0_mult_gen_v12_0_16 U0
       (.A(A),
        .B(B),
        .CE(1'b1),
        .CLK(1'b1),
        .P(P),
        .PCASC(NLW_U0_PCASC_UNCONNECTED[47:0]),
        .SCLR(1'b0),
        .ZERO_DETECT(NLW_U0_ZERO_DETECT_UNCONNECTED[1:0]));
endmodule

(* C_A_TYPE = "0" *) (* C_A_WIDTH = "32" *) (* C_B_TYPE = "0" *) 
(* C_B_VALUE = "10000001" *) (* C_B_WIDTH = "32" *) (* C_CCM_IMP = "0" *) 
(* C_CE_OVERRIDES_SCLR = "0" *) (* C_HAS_CE = "0" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_ZERO_DETECT = "0" *) (* C_LATENCY = "0" *) (* C_MODEL_TYPE = "0" *) 
(* C_MULT_TYPE = "1" *) (* C_OPTIMIZE_GOAL = "1" *) (* C_OUT_HIGH = "31" *) 
(* C_OUT_LOW = "0" *) (* C_ROUND_OUTPUT = "0" *) (* C_ROUND_PT = "0" *) 
(* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "artix7" *) (* ORIG_REF_NAME = "mult_gen_v12_0_16" *) 
(* downgradeipidentifiedwarnings = "yes" *) 
module mult_gen_0_mult_gen_v12_0_16
   (CLK,
    A,
    B,
    CE,
    SCLR,
    ZERO_DETECT,
    P,
    PCASC);
  input CLK;
  input [31:0]A;
  input [31:0]B;
  input CE;
  input SCLR;
  output [1:0]ZERO_DETECT;
  output [31:0]P;
  output [47:0]PCASC;

  wire \<const0> ;
  wire [31:0]A;
  wire [31:0]B;
  wire [31:0]P;
  wire [47:0]NLW_i_mult_PCASC_UNCONNECTED;
  wire [1:0]NLW_i_mult_ZERO_DETECT_UNCONNECTED;

  assign PCASC[47] = \<const0> ;
  assign PCASC[46] = \<const0> ;
  assign PCASC[45] = \<const0> ;
  assign PCASC[44] = \<const0> ;
  assign PCASC[43] = \<const0> ;
  assign PCASC[42] = \<const0> ;
  assign PCASC[41] = \<const0> ;
  assign PCASC[40] = \<const0> ;
  assign PCASC[39] = \<const0> ;
  assign PCASC[38] = \<const0> ;
  assign PCASC[37] = \<const0> ;
  assign PCASC[36] = \<const0> ;
  assign PCASC[35] = \<const0> ;
  assign PCASC[34] = \<const0> ;
  assign PCASC[33] = \<const0> ;
  assign PCASC[32] = \<const0> ;
  assign PCASC[31] = \<const0> ;
  assign PCASC[30] = \<const0> ;
  assign PCASC[29] = \<const0> ;
  assign PCASC[28] = \<const0> ;
  assign PCASC[27] = \<const0> ;
  assign PCASC[26] = \<const0> ;
  assign PCASC[25] = \<const0> ;
  assign PCASC[24] = \<const0> ;
  assign PCASC[23] = \<const0> ;
  assign PCASC[22] = \<const0> ;
  assign PCASC[21] = \<const0> ;
  assign PCASC[20] = \<const0> ;
  assign PCASC[19] = \<const0> ;
  assign PCASC[18] = \<const0> ;
  assign PCASC[17] = \<const0> ;
  assign PCASC[16] = \<const0> ;
  assign PCASC[15] = \<const0> ;
  assign PCASC[14] = \<const0> ;
  assign PCASC[13] = \<const0> ;
  assign PCASC[12] = \<const0> ;
  assign PCASC[11] = \<const0> ;
  assign PCASC[10] = \<const0> ;
  assign PCASC[9] = \<const0> ;
  assign PCASC[8] = \<const0> ;
  assign PCASC[7] = \<const0> ;
  assign PCASC[6] = \<const0> ;
  assign PCASC[5] = \<const0> ;
  assign PCASC[4] = \<const0> ;
  assign PCASC[3] = \<const0> ;
  assign PCASC[2] = \<const0> ;
  assign PCASC[1] = \<const0> ;
  assign PCASC[0] = \<const0> ;
  assign ZERO_DETECT[1] = \<const0> ;
  assign ZERO_DETECT[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "32" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_VALUE = "10000001" *) 
  (* C_B_WIDTH = "32" *) 
  (* C_CCM_IMP = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "0" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "1" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "31" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  mult_gen_0_mult_gen_v12_0_16_viv i_mult
       (.A(A),
        .B(B),
        .CE(1'b0),
        .CLK(1'b1),
        .P(P),
        .PCASC(NLW_i_mult_PCASC_UNCONNECTED[47:0]),
        .SCLR(1'b0),
        .ZERO_DETECT(NLW_i_mult_ZERO_DETECT_UNCONNECTED[1:0]));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2019.1"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
HPMPLvpmoX7LOmPj78BMT9X1rCnPz6PdhVGZQ307N9haGfAdMGVirvGR3e0Glyn2ieoWqXA6qOQL
t0xn28+h0g==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
Nxv/BnutRgdmHnLyK7kvDGjm7WGfFKW2mxQ6xUKF14zS4ziz5pSV0ueW4VqAzUyEPsErIAEuyV6F
m5KCqRBB197Q2NbZa7O7tdAqboX6tPAJzbB6u4U/MmNS1AQcSgtfj5srMbdBzDa5pR4V3HrI0MRj
0xhV1BWf725FYPP4av0=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
F5KGJgEDQsX2btdjtRUlSmNtuyodIhGXEa3/AXv1Y7qgSO8gknBfiqj5HcIaVA9b4npQpDnNcmq+
1ONAqLeLhdOm9TES+GsTAkh/lClvl89bzfqgOV33iqwQHYIHwSsWMRXT9JSUx+YWu+g6xKpT1Ycn
8BCPsq4QUJIqL6W16fheEHB/lkMgnespIWEYJJG6R6zvv2zG8GiU6cG8zHrRjdvAj8kOkhmiMvSd
YjGXJSMfjw7ojCPSUF+nb6WWhUEmoMA/6lgSVaXRm00YHSZ09k7rKTJWSXFSpTmkL2WOsQhNS0ek
jdTK2KF5K6z2YOK4zkfHgZ+fB0KJyANaLLJH/Q==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
lFuQXeJ0hi7qnIKAR+37XCSOwp8bGLukonngcICceOVpL87+rxvhP5TyNJ/zXpAWDF0BaRYlGr7d
isPiUStrvUthNyOqCr4vFZyhCdY8n+Mrv3OCvLoLQSarxVXbaKbXb0tPsXJCUdXTrCt9mr5x0Nda
6DAI8FBPlFMAiqnFXnYMwlUiSlkNWUpInuNw7+1eD8kUdckEUV1PDwZ0yjpFqMokMH9oJjN6z0Yy
65D8Tqo288ZMfZQuIimjski+X6EK157XbpyuoZIuYLJ7j6oaATdintgfZpgGzVvhCZtMbx6/SJtR
efW5vLBGiGs7rPBPE2T8fosHGOvmeC9QBSj8Ww==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2019_02", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Q8VVvHzTNgU3tZr4+8ia7ylST+kbNPWskONHDOT1dTkB7cHZIAWyzXpQZPuEgk2wJq21PoqmVlG9
t08IYzkfC8vYQ2LRf2Co3SXc7p3gF2OFMC68J9Nf9D+/PXJCJy3QO4H8oO39l6bn8c56K2ARnK0R
mMIALbCWSBDGCWGQmXWZJ+xmDGs1KgTeiSW3bZRftWJ6K8l8BhMit8BLOY2Mi3jJ0WRhN8kKd6JT
D4NU1jTZT6jEtmI7Gnj/AXG6auTqDPHsVQzf+ZzBsLTfw83CFoO70xM997L5cZXlqz8fEDmxezkr
wWxPwJbJeVkRV3tUxlo2Bs2x1uVkXQeNVMI8jg==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
oUeTLA0HA2uKORUHo1HidNC3lw54gxwlLUkv28qRPv1pz7AEVUbIJ7wsyu2Scju+EkC2Ivi8HbBn
jxkeqRDTAwAbAqIKnY3AdyfojN9Hb8SMLcLnpWLLCpb6E0vwA09r7uqKRZ8wYAgT9CPFvzpQ3zKt
9DTLgQ3rZtFxx2nfCug=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Fayrlym1l14Y48yZ195XboT9ZQmp/mAzUyHby3Y9qJTzDF+m6mRQ/ZbebObo8bu4VAm45JeETPx1
YI4UZNOK4IqKv0BZsAlzUfAYAmqmkmIJYbn2gWUCwXyKX5AoA4ONnlxEHxzZhqtsmEXvxwTEs25/
R7iLzeoMfmwwNHgPNQkteiR4zDlB76CYmgu6EOSUX5Nnitq1oh7qRuU8WqWN7lLfgIC6T7qNHwGD
RPze2yiP06fSG45jPrOn2fvBX9SRbUXjNtiFgmqim4anwJU46v7y3ubit/I6giZhz5PJMZfkDaFX
ag+uCMq4Q8ZEolqMBmjUjat86BdVd4Nmr0yUaA==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
kIpxh3qIIkWUg8aLJSPKvKhKTPFH7T8fisti5RtNaftS7xh3KDsGLYnF1lYhH2RVXgzbdaVqvtED
5QJazVo6wUFI91xgFeOR5jX+Ny5UBUX2MngsK+UZyZg5+EdtSiDtiJNtQqgjq1Rn+XQCGF3xP80n
7YvuVMbgRHCAfWrWw7ZJ7Y3raRzeIkx+koPFio7XnC+QdRJ0ItO1YtQgF4Sg1Ihr5TH8/RrNn903
kPa+anH9spo3SFCf2Ts11UXAGLdIBmOLMtEAKjjCUbtmjGSeSc0gn2q2I+xRTFcegLevlr/iuLTw
3lFndBAoW40xOiCDjWZ6Rz7J+jZhsRl3D0Bhwg==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
HqxXC97hHvgHTVxWl9jhrJIw08uUt4YnMgYZdliWhYIm9UKWUeL36DUmqpQlk6r82Et+68bxC/f7
rsyBLnJmvj4RgrCk45UU9nNkvgh5eBmppxr9EqtMCIlNn0WhzgxqfHBE2m3BNUy/ViF0j60riOM8
JbU8ZuQUyTEicp5DGvZCchiNMNrsM7j5SnH+Im6dV/eCNrQI2oRdzs4JF6lJnkh8OWufnRwWNH1R
zFYkZNSzBmTHlOB1kHaeT/kW2/kb43Nwv8sXLW/l0axrMg0P3Qjlh2rDiIdaMAwoSlLP3/N+qw2N
Vud2eVoamiuOZyxQXS5lnt6+pp+TSNwiXrOXGw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
QjUy/W4D+V7UXMYd9REUzL5WjLzaUTd6khl208a3zG1Py2rs8arRfAu/CAWey+q7bCxfx4hb1k/V
YdQ/MJjAxXlP4SZYAl1gXe+xriEwqfC3nxe8YVJ8LXMbn3rROAMp17khuB3LOD/ia3RqpCtH0fv3
bimIbi0TqL6UehpmQ3mw7MF5PtgwmRKUSXa2HkO3BAGEqgsxYdl/I+Hb9xuKWS4dySC78N6SG+Oo
0+WOHjQ/dxZHA1mGwXolW4itDdODLjRlSiFwWHkBhWS9MXA0F6mrs3OJJdHKtydX97EAhNqZcaWl
q2JLXZBw/u4noVEOnvosQglNzp3Jl5xJRgq7GQ==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 17232)
`pragma protect data_block
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
CV5mSpMcekXk0yF3OBDvyeJv
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
