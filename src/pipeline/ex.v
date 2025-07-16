`include "defines.v"

module ex(
    input wire                              clk,
    input wire                              rst,
    
    input wire [4:0]                        aluop_i,
    input wire [2:0]                        alusel_i,
    input wire [31:0]                       reg1_i,
    input wire [31:0]                       reg2_i,
    input wire [4:0]                        waddr_i,
    input wire                              we_i,

    input wire [31:0]                       link_address_i,

    input wire [31:0]                       inst_i,
    output reg                              we_o,
    output reg [4:0]                        waddr_o,
    output reg [31:0]                       wdata_o,

    output wire [4:0]                       aluop_o,
    output wire [31:0]                      mem_addr_o,
    output wire [31:0]                      reg2_o,
    
    output reg                              stall_from_ex 
);
    wire [31:0] logicout, shiftres, arithmeticres;
    wire [31:0] result_sum, result_mul;
    wire [31:0] mul_1, mul_2;
    wire [31:0] reg2_i_sign;
    wire [31:0] maxu_sum;

    assign mul_1 = reg1_i;
    assign mul_2 = reg2_i;

    assign aluop_o = aluop_i;
    assign reg2_o  = reg2_i;
    assign mem_addr_o = reg1_i + {{16{inst_i[15]}}, inst_i[15:0]};
    assign reg2_i_sign = (aluop_i == `SUBU_OP) ? (~reg2_i) + 1 : reg2_i;
    assign result_sum = reg1_i + reg2_i_sign; // ADD or SUB
    assign result_mul = mul_1 * mul_2;
    assign maxu_sum = ($unsigned(reg1_i) > $unsigned(reg2_i)) ? reg1_i : reg2_i;

    assign logicout = (rst == `RstEnable) ? `ZeroWord :
            (aluop_i ==  `OR_OP)  ? (reg1_i | reg2_i) :
            (aluop_i ==  `AND_OP) ? (reg1_i & reg2_i) :
            (aluop_i ==  `XOR_OP) ? (reg1_i ^ reg2_i) : `ZeroWord;

    assign shiftres = (rst == `RstEnable) ? `ZeroWord :
            (aluop_i ==  `SLL_OP) ? (reg2_i << reg1_i[4:0]) :
            (aluop_i ==  `SRL_OP) ? (reg2_i >> reg1_i[4:0]) :
            (aluop_i ==  `SRA_OP) ? (reg2_i >>> reg1_i[4:0]) : `ZeroWord;
    assign arithmeticres = (rst == `RstEnable) ? `ZeroWord :
            (aluop_i ==  `MAXU_OP) ? maxu_sum :
            (aluop_i ==  `ADDU_OP || aluop_i == `SUBU_OP) ? result_sum :
            (aluop_i ==  `SLT_OP) ? ($unsigned(reg1_i) < $unsigned(reg2_i)) : `ZeroWord;
    
    always @(*) begin
        waddr_o = waddr_i;
        we_o = we_i;
        stall_from_ex = `NoStop;
        case (alusel_i)
            `RES_LOGIC:         wdata_o = logicout;
            `RES_SHIFT:         wdata_o = shiftres;
            `RES_ARITHMETIC:    wdata_o = arithmeticres;
            `RES_MUL:           wdata_o = result_mul;
            `RES_JUMP_BRANCH:   wdata_o = link_address_i;
            default:          wdata_o = `ZeroWord;
        endcase
    end
endmodule