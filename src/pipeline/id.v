`include "defines.v"

module id(
	input wire									rst,

	input wire[31:0]					        id_pc_i,
	input wire[31:0]          				    id_inst_i,
	

	input wire[4:0]								ex_aluop_i,
	
	input wire[31:0]           				    r1_data_i,
	input wire[31:0]           				    r2_data_i,

	input wire									ex_we_i,
	input wire[31:0]							ex_wdata_i,
	input wire[4:0]            			        ex_waddr_i,
	
	input wire									mem_we_i,
	input wire[31:0]							mem_wdata_i,
	input wire[4:0]                  	        mem_waddr_i,

	output reg                    				re1_o,
	output reg                    				re2_o,     
	output reg[4:0]       						r1_addr_o,
	output reg[4:0]       						r2_addr_o, 	      
	
	output reg[4:0]         					aluop_o,
	output reg[2:0]        						alusel_o,
	output reg[31:0]           					r1_data_o,
	output reg[31:0]           					r2_data_o,
	output reg[4:0]       						waddr_o,
	output reg                   	 			we_o,
	
	output reg                    				branch_flag_o,
	output reg[31:0]           					branch_target_o,       
	output reg[31:0]           					link_o,

	output wire[31:0]          					inst_o,
	output wire        							stall_from_id    
);

	//wire[31:0] 	pc_plus_8 = id_pc_i + 8;
	//wire[31:0] 	pc_plus_4 = id_pc_i + 4;

    wire [31:0] branch_addr;
    wire [5:0]  op;
    wire [4:0]  rs;
    wire [4:0]  rt;
    wire [4:0]  rd;
    wire [4:0]  shamt;
    wire [5:0]  func;
    wire        is_inst_load;
    wire [31:0] pc_plus_4;

    reg         stall_load_use_1;
    reg         stall_load_use_2;
    reg [31:0]  imm;

    assign branch_addr = pc_plus_4 + {{14{id_inst_i[15]}}, id_inst_i[15:0], 2'b00};
    assign op          = id_inst_i[31:26];
    assign rs          = id_inst_i[25:21];
    assign rt          = id_inst_i[20:16];
    assign rd          = id_inst_i[15:11];
    assign shamt       = id_inst_i[10:6];
    assign func        = id_inst_i[5:0];
    assign pc_plus_4 = id_pc_i + 4;

    assign inst_o = id_inst_i;
    assign stall_from_id = stall_load_use_1 | stall_load_use_2;
    assign is_inst_load = (ex_aluop_i == `LW_OP) || (ex_aluop_i == `LB_OP); // Load-Use Hazard

    always @(*) begin
        if (rst == 1'b1) begin
            aluop_o <= `NOP_OP;
            alusel_o <= `RES_NOP;
            re1_o <= 1'b0;
            re2_o <= 1'b0;
            r1_addr_o <= 5'b00000;
            r2_addr_o <= 5'b00000;
            aluop_o <= `NOP_OP;
            alusel_o <= `RES_NOP;
            waddr_o <= 5'b00000;
            we_o <= 1'b0;
            branch_flag_o <= 1'b0;
            branch_target_o <= `ZeroWord;
            link_o <= `ZeroWord;
        end else begin 
            aluop_o <= `NOP_OP;
            alusel_o <= `RES_NOP;
			waddr_o <= rd;
			we_o <= `WriteDisable;  
			re1_o <= 1'b0;
			re2_o <= 1'b0;
			r1_addr_o <= rs;
			r2_addr_o <= rt;		
			//imm_o <= `ZeroWord;			
			link_o <= `ZeroWord;
			branch_target_o <= `ZeroWord;
			branch_flag_o <= `NotBranch;
            case (op)
                `R_INST: begin
                    case (func)
                        `ADD: begin
                            aluop_o <= `ADDU_OP;
                            alusel_o <= `RES_ARITHMETIC;
                            re1_o <= 1'b1;
                            re2_o <= 1'b1;
                            we_o <= `WriteEnable;
                        end
                        `ADDU: begin
                            aluop_o <= `ADDU_OP;
                            alusel_o <= `RES_ARITHMETIC;
                            re1_o <= 1'b1;
                            re2_o <= 1'b1;
                            we_o <= `WriteEnable;
                        end
                        `SUB,`SUBU: begin
                            aluop_o <= `SUBU_OP;
                            alusel_o <= `RES_ARITHMETIC;
                            re1_o <= 1'b1;
                            re2_o <= 1'b1;
                            we_o <= `WriteEnable;
                        end
                        `OR: begin
                            aluop_o <= `OR_OP;
                            alusel_o <= `RES_LOGIC;
                            re1_o <= 1'b1;
                            re2_o <= 1'b1;
                            we_o <= `WriteEnable;
                        end
                        `AND: begin
                            aluop_o <= `AND_OP;
                            alusel_o <= `RES_LOGIC;
                            re1_o <= 1'b1;
                            re2_o <= 1'b1;
                            we_o <= `WriteEnable;
                        end
                        `XOR: begin
                            aluop_o <= `XOR_OP;
                            alusel_o <= `RES_LOGIC;
                            re1_o <= 1'b1;
                            re2_o <= 1'b1;
                            we_o <= `WriteEnable;
                        end
                        `XOR: begin
                            aluop_o <= `XOR_OP;
                            alusel_o <= `RES_LOGIC;
                            re1_o <= 1'b1;
                            re2_o <= 1'b1;
                            we_o <= `WriteEnable;
                        end
                        `SLL: begin
                            aluop_o <= `SLL_OP;
                            alusel_o <= `RES_SHIFT;
                            re1_o <= 1'b0;
                            re2_o <= 1'b1;
                            we_o <= `WriteEnable;
                            imm[4:0] <= shamt;
                        end
                        `SLT: begin
                            aluop_o <= `SLT_OP;
                            alusel_o <= `RES_ARITHMETIC;
                            re1_o <= 1'b1;
                            re2_o <= 1'b1;
                            we_o <= `WriteEnable;
                        end
                        `SRA: begin
                            aluop_o <= `SRA_OP;
                            alusel_o <= `RES_SHIFT;
                            re1_o <= 1'b0;
                            re2_o <= 1'b1;
                            we_o <= `WriteEnable;
                            imm[4:0] <= shamt;
                        end
                        `SRL: begin
                            aluop_o <= `SRL_OP;
                            alusel_o <= `RES_SHIFT;
                            re1_o <= 1'b0;
                            re2_o <= 1'b1;
                            we_o <= `WriteEnable;
                            imm[4:0] <= shamt;
                        end
                        `JR: begin
                            aluop_o <= `JR_OP;
                            alusel_o <= `RES_JUMP_BRANCH;
                            re1_o <= 1'b1;
                            re2_o <= 1'b0;
                            we_o <= `WriteDisable;
                            branch_flag_o <= `Branch;
                            branch_target_o <= r1_data_o;
                            link_o <= `ZeroWord;
                        end
                        `JALR: begin
                            aluop_o <= `JALR_OP;
                            alusel_o <= `RES_JUMP_BRANCH;
                            re1_o <= 1'b1;
                            re2_o <= 1'b0;
                            we_o <= `WriteEnable;
                            waddr_o <= rd; // Write to rd
                            branch_target_o <= r1_data_o;
                            branch_flag_o <= `Branch;
                            link_o <= id_pc_i + 8;
                        end
                        default: begin
                            aluop_o <= `NOP_OP;
                            imm <= `ZeroWord;
                        end
                    endcase
                end
                `LUI: begin
                    aluop_o <= `OR_OP;
                    alusel_o <= `RES_LOGIC;
                    re1_o <= 1'b1;
                    re2_o <= 1'b0;
                    we_o <= `WriteEnable;
                    imm <= {id_inst_i[15:0], 16'h0000};
                    waddr_o <= rt; // Write to rt
                end
                `ORI: begin
                    aluop_o <= `OR_OP;
                    alusel_o <= `RES_LOGIC;
                    re1_o <= 1'b1;
                    re2_o <= 1'b0;
                    we_o <= `WriteEnable;
                    imm <= {16'h0000, id_inst_i[15:0]};
                    waddr_o <= rt; 
                end
                `ANDI: begin
                    aluop_o <= `AND_OP;
                    alusel_o <= `RES_LOGIC;
                    re1_o <= 1'b1;
                    re2_o <= 1'b0;
                    we_o <= `WriteEnable;
                    imm <= {16'h0000, id_inst_i[15:0]};
                    waddr_o <= rt; 
                end
                `XORI: begin
                    aluop_o <= `XOR_OP;
                    alusel_o <= `RES_LOGIC;
                    re1_o <= 1'b1;
                    re2_o <= 1'b0;
                    we_o <= `WriteEnable;
                    imm <= {16'h0000, id_inst_i[15:0]};
                    waddr_o <= rt; 
                end
                `ADDI,`ADDIU: begin
                    aluop_o <= `ADDU_OP;
                    alusel_o <= `RES_ARITHMETIC;
                    re1_o <= 1'b1;
                    re2_o <= 1'b0;
                    we_o <= `WriteEnable;
                    imm <= {{16{id_inst_i[15]}}, id_inst_i[15:0]}; // Sign-extend immediate
                    waddr_o <= rt; 
                end
                `J: begin
                    aluop_o <= `J_OP;
                    alusel_o <= `RES_JUMP_BRANCH;
                    re1_o <= 1'b0;
                    re2_o <= 1'b0;
                    we_o <= `WriteDisable;
                    branch_flag_o <= `Branch;
                    branch_target_o <= {pc_plus_4[31:28], id_inst_i[25:0], 2'b00}; // Jump address
                    link_o <= id_pc_i + 8; // Link address
                end
                `JAL: begin
                    aluop_o <= `JAL_OP;
                    alusel_o <= `RES_JUMP_BRANCH;
                    re1_o <= 1'b0;
                    re2_o <= 1'b0;
                    we_o <= `WriteEnable;
                    waddr_o <= 5'b11111; // $ra
                    branch_flag_o <= `Branch;
                    branch_target_o <= {pc_plus_4[31:28], id_inst_i[25:0], 2'b00}; // Jump address
                    link_o <= id_pc_i + 8;
                end
                `BEQ: begin
                    aluop_o <= `BEQ_OP;
                    alusel_o <= `RES_JUMP_BRANCH;
                    re1_o <= 1'b1;
                    re2_o <= 1'b1;
                    we_o <= `WriteDisable;
                    branch_flag_o <= (r1_data_o == r2_data_o) ? `Branch : `NotBranch;
                    branch_target_o <= (r1_data_o == r2_data_o) ? branch_addr : `ZeroWord;
                end
                `BNE: begin
                    aluop_o <= `BNE_OP;
                    alusel_o <= `RES_JUMP_BRANCH;
                    re1_o <= 1'b1;
                    re2_o <= 1'b1;
                    we_o <= `WriteDisable;
                    branch_flag_o <= (r1_data_o != r2_data_o) ? `Branch : `NotBranch;
                    branch_target_o <= (r1_data_o != r2_data_o) ? branch_addr : `ZeroWord;
                end
                `BGTZ: begin
                    aluop_o <= `BGTZ_OP;
                    alusel_o <= `RES_JUMP_BRANCH;
                    re1_o <= 1'b1;
                    re2_o <= 1'b0;
                    we_o <= `WriteDisable;
                    branch_flag_o <= (r1_data_o[31] == 1'b0 && r1_data_o != `ZeroWord) ? `Branch : `NotBranch;
                    branch_target_o <= (r1_data_o[31] == 1'b0 && r1_data_o != `ZeroWord) ? branch_addr : `ZeroWord;
                end
                `MUL: begin
                    aluop_o <= `MUL_OP;
                    alusel_o <= `RES_MUL;
                    re1_o <= 1'b1;
                    re2_o <= 1'b1;
                    we_o <= `WriteEnable;
                end
                `LW: begin
                    aluop_o <= `LW_OP;
                    alusel_o <= `RES_LOAD_STORE;
                    re1_o <= 1'b1;
                    re2_o <= 1'b0;
                    we_o <= `WriteEnable;
                    waddr_o <= rt; // Write to rt
                end
                `SW: begin
                    aluop_o <= `SW_OP;
                    alusel_o <= `RES_LOAD_STORE;
                    re1_o <= 1'b1;
                    re2_o <= 1'b1;
                    we_o <= `WriteDisable;
                end
                `LB: begin
                    aluop_o <= `LB_OP;
                    alusel_o <= `RES_LOAD_STORE;
                    re1_o <= 1'b1;
                    re2_o <= 1'b0;
                    waddr_o <= rt; // Write to rt
                    we_o <= `WriteEnable;
                end
                `SB: begin
                    aluop_o <= `SB_OP;
                    alusel_o <= `RES_LOAD_STORE;
                    re1_o <= 1'b1;
                    re2_o <= 1'b1;
                    we_o <= `WriteDisable;
                end
                default: begin
                    aluop_o <= `NOP_OP;
                    alusel_o <= `RES_NOP;
                end
            endcase
        end
    end

    always @(*) begin
        stall_load_use_1 <= `NoStop;
        if (rst) begin
            stall_load_use_1 <= 1'b0;
            r1_data_o <= `ZeroWord;
        end else if (is_inst_load && (ex_waddr_i == r1_addr_o) && (re1_o == 1'b1)) begin // Load-Use Hazard
            stall_load_use_1 <= 1'b1;
            r1_data_o <= `ZeroWord;
        end else if ((re1_o == 1'b1) && (ex_we_i == `WriteEnable) && (ex_waddr_i == r1_addr_o) && (r1_addr_o != 5'b0)) begin // Forwarding
            r1_data_o <= ex_wdata_i;
        end else if ((re1_o == 1'b1) && (mem_we_i == `WriteEnable) && (mem_waddr_i == r1_addr_o) && (r1_addr_o != 5'b0)) begin // Forwarding
            r1_data_o <= mem_wdata_i;
        end else if (re1_o == 1'b1) begin
            r1_data_o <= r1_data_i;
        end else if (re1_o == 1'b0) begin
            r1_data_o <= imm;
        end else begin
            r1_data_o <= `ZeroWord;
        end
    end

    always @(*) begin
        stall_load_use_2 <= `NoStop;
        if (rst) begin
            stall_load_use_2 <= 1'b0;
            r2_data_o <= `ZeroWord;
        end else if (is_inst_load && (ex_waddr_i == r2_addr_o) && (re2_o == 1'b1)) begin // Load-Use Hazard
            stall_load_use_2 <= 1'b1;
            r2_data_o <= `ZeroWord;
        end else if ((re2_o == 1'b1) && (ex_we_i == `WriteEnable) && (ex_waddr_i == r2_addr_o) && (r2_addr_o != 5'b0)) begin // Forwarding
            r2_data_o <= ex_wdata_i;
        end else if ((re2_o == 1'b1) && (mem_we_i == `WriteEnable) && (mem_waddr_i == r2_addr_o) && (r2_addr_o != 5'b0)) begin // Forwarding
            r2_data_o <= mem_wdata_i;
        end else if (re2_o == 1'b1) begin
            r2_data_o <= r2_data_i;
        end else if (re2_o == 1'b0) begin
            r2_data_o <= imm;
        end else begin
            r2_data_o <= `ZeroWord;
        end
    end

    
endmodule