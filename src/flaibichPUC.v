`include "defines.v"

module FlaibichPUC(
	input  wire						clk,		
	input  wire						rst,		

	input  wire[31:0]            	rom_data_i,	
	input  wire                     stall_from_bus,
	output wire[31:0]          		rom_addr_o,	
	output wire                    	rom_ce_n_o,
	
	input  wire[31:0]            	ram_data_i,
	output wire[31:0]          		ram_addr_o,
	output wire[31:0]           	ram_data_o,
	output wire                    	ram_we_n,
	output wire[3:0]               	ram_be_n,
	output wire               		ram_ce_n,
	output wire						ram_oe_n
);

	wire[31:0]  id_pc, id_inst;
	wire[4:0] 	id_aluop;
	wire[2:0] 	id_alusel;
	wire[31:0] 	id_reg1, id_reg2;
	wire 		id_we;
	wire[4:0] 	id_waddr;
	wire[31:0] 	id_inst_o;
  	wire[31:0] 	id_link_address_o;

	wire[4:0] 	ex_aluop_i;
	wire[2:0] 	ex_alusel_i;
	wire[31:0] 	ex_reg1_i, ex_reg2_i;
	wire 		ex_we_i, ex_we_o;
	wire[4:0] 	ex_waddr_i;
    wire[31:0] 	ex_link_address_i, ex_inst_i;
	wire[4:0] 	ex_waddr_o;
	wire[31:0] 	ex_wdata_o;
	wire[4:0] 	ex_aluop_o;
	wire[31:0] 	ex_mem_addr_o;
	wire[31:0] 	ex_reg1_o, ex_reg2_o;

	wire 		mem_we_i;
	wire[4:0] 	mem_waddr_i;
	wire[31:0] 	mem_wdata_i;

	wire[4:0] 	mem_aluop_i;
	wire[31:0] 	mem_addr_i;
	wire[31:0] 	mem_reg1_i, mem_reg2_i;

	wire 		mem_we_o;
	wire[4:0] 	mem_waddr_o;
	wire[31:0] 	mem_wdata_o;
	
	wire 		wb_we;
	wire[4:0] 	wb_waddr;
	wire[31:0] 	wb_wdata;
	
	wire 		reg1_read, reg2_read;
	wire[31:0] 	reg1_data, reg2_data;
	wire[4:0] 	reg1_addr, reg2_addr;
	
	wire[5:0] 	stall;
	wire 		stall_from_id, stall_from_ex;	
  
	wire 		id_branch_flag_o;
	wire [31:0] branch_address;
	
	wire [31:0] rom_data_icache, ram_data_mem_o;
	wire 		stall_from_icache, stall_from_mem;

	if_pc if_pc_0(
		.clk(clk),
		.rst(rst),
		.stall(stall),

		.branch_flag_i(id_branch_flag_o),
		.branch_address_i(branch_address),

		.if_pc_o(rom_addr_o),
		.rom_ce_n_o(rom_ce_n_o)
	);

	icache icache_0(
		.clk(clk),
		.rst(rst),
		.stall_from_icache(stall_from_icache),
		.stall_from_bus(stall_from_bus),

		.pc_i(rom_addr_o),       
		.rom_ce_n_i(rom_ce_n_o),          
		.inst_i(rom_data_i),  
		.inst_o(rom_data_icache)            
	);

	if_id if_id_0(
		.clk(clk),
		.rst(rst),
		.stall(stall),

		.if_pc_i(rom_addr_o),
		.if_inst_i(rom_data_icache),
		.id_pc_o(id_pc),
		.id_inst_o(id_inst)      	
	);
	
	id id_0(
		.rst(rst),
		.id_pc_i(id_pc),
		.id_inst_i(id_inst),
        .ex_aluop_i(ex_aluop_o),
		.r1_data_i(reg1_data),
		.r2_data_i(reg2_data),

	   	.ex_we_i(ex_we_o),
		.ex_wdata_i(ex_wdata_o),
		.ex_waddr_i(ex_waddr_o),

		.mem_we_i(mem_we_o),
		.mem_wdata_i(mem_wdata_o),
		.mem_waddr_i(mem_waddr_o),

		.re1_o(reg1_read),
		.re2_o(reg2_read), 	  
		.r1_addr_o(reg1_addr),
		.r2_addr_o(reg2_addr), 
	
		.aluop_o(id_aluop),
		.alusel_o(id_alusel),
		.r1_data_o(id_reg1),
		.r2_data_o(id_reg2),
		.waddr_o(id_waddr),
		.we_o(id_we),
		.inst_o(id_inst_o),
	
		.branch_flag_o(id_branch_flag_o),
		.branch_target_o(branch_address),       
		.link_o(id_link_address_o),

		.stall_from_id(stall_from_id)	
	);

	regfile regfile_0(
		.clk (clk),
		.rst (rst),

		.reg_we_i	   (wb_we),
		.reg_w_addr_i  (wb_waddr),
		.reg_w_data_i  (wb_wdata),
		.reg_re1_i     (reg1_read),
		.reg_r_addr1_i (reg1_addr),
		.reg_re2_i     (reg2_read),
		.reg_r_addr2_i (reg2_addr),

		.reg_r_data1_o (reg1_data),
		.reg_r_data2_o (reg2_data)
	);

	id_ex id_ex_0(
		.clk(clk),
		.rst(rst),
		.stall(stall),

		.id_aluop_i(id_aluop),
		.id_alusel_i(id_alusel),
		.id_reg1_i(id_reg1),
		.id_reg2_i(id_reg2),
		.id_waddr_i(id_waddr),
		.id_we_i(id_we),
		.id_inst_i(id_inst_o),
		.id_link_i(id_link_address_o),

		.ex_aluop_o(ex_aluop_i),
		.ex_alusel_o(ex_alusel_i),
		.ex_reg1_o(ex_reg1_i),
		.ex_reg2_o(ex_reg2_i),
		.ex_waddr_o(ex_waddr_i),
		.ex_we_o(ex_we_i),
		.ex_inst_o(ex_inst_i),
		.ex_link_o(ex_link_address_i)
	);		
	
	ex ex_0(
		.clk(clk),
		.rst(rst),
		.stall_from_ex(stall_from_ex),  

		.aluop_i(ex_aluop_i),
		.alusel_i(ex_alusel_i),
		.reg1_i(ex_reg1_i),
		.reg2_i(ex_reg2_i),
		.waddr_i(ex_waddr_i),
		.we_i(ex_we_i),
	  	.inst_i(ex_inst_i),
		.link_address_i(ex_link_address_i),

		.waddr_o(ex_waddr_o),
		.we_o(ex_we_o),
		.wdata_o(ex_wdata_o),
		.aluop_o(ex_aluop_o),
		.mem_addr_o(ex_mem_addr_o),
		.reg2_o(ex_reg2_o)
	);

    ex_mem ex_mem_0(
		.clk(clk),
		.rst(rst),
	  	.stall(stall),

		.ex_waddr_i(ex_waddr_o),
		.ex_we_i(ex_we_o),
		.ex_wdata_i(ex_wdata_o),
	   	.ex_aluop_i(ex_aluop_o),
		.ex_mem_addr_i(ex_mem_addr_o),
		.ex_reg2_i(ex_reg2_o),

		.mem_waddr_o(mem_waddr_i),
		.mem_we_o(mem_we_i),
		.mem_wdata_o(mem_wdata_i),
		.mem_aluop_o(mem_aluop_i),
		.mem_addr_o(mem_addr_i),
		.mem_reg2_o(mem_reg2_i)						       	
	);
	
	mem mem_0(
		.rst(rst),
		.clk(clk),

		.waddr_i(mem_waddr_i),
		.we_i(mem_we_i),
		.wdata_i(mem_wdata_i),
	    .aluop_i(mem_aluop_i),
		.mem_addr_i(mem_addr_i),
		.reg2_i(mem_reg2_i),
		.mem_data_i(ram_data_mem_o),

		.waddr_o(mem_waddr_o),
		.we_o(mem_we_o),
		.wdata_o(mem_wdata_o),
        .mem_addr_o(ram_addr_o),
		.mem_data_o(ram_data_o),
		.mem_we_n_o(ram_we_n),
		.mem_be_n_o(ram_be_n),
		.mem_ce_n_o(ram_ce_n),
		.mem_oe_n_o(ram_oe_n)	
	);
	
	mem_ctrl mem_ctrl_0(
		.clk(clk),
		.rst(rst),
		.stall_from_mem(stall_from_mem),

		.ram_data_o(ram_data_mem_o),          

		.mem_addr_i(ram_addr_o),        	  
		.mem_data_i(ram_data_o),              
		.mem_we_n_i(ram_we_n),          	  
		.mem_be_n_i(ram_be_n),         	      
		.mem_oe_n_i(ram_oe_n),          	  
		.mem_ce_n_i(ram_ce_n),          	  
		.ram_data_i(ram_data_i)               
	);

	mem_wb mem_wb_0(
		.clk(clk),
		.rst(rst),
        .stall(stall),

		.mem_waddr_i(mem_waddr_o),
		.mem_we_i(mem_we_o),
		.mem_wdata_i(mem_wdata_o),

		.wb_waddr_o(wb_waddr),
		.wb_we_o(wb_we),
		.wb_wdata_o(wb_wdata)											       	
	);
	
	stall_ctrl stall_ctrl_0(
		.rst(rst),	
		.stall(stall),   

		.stall_from_bus(stall_from_bus),
		.stall_from_id(stall_from_id),
		.stall_from_ex(stall_from_ex),
		.stall_from_mem(stall_from_mem),
		.stall_from_icache(stall_from_icache)
	);

endmodule