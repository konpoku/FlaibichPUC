`include "defines.v"

module if_id(
	input wire										clk,
	input wire										rst,
	input wire[5:0]                            		stall,

	input wire[31:0]								if_pc_i,		
	input wire[31:0]          						if_inst_i,		
	output reg[31:0]      							id_pc_o,		
	(* MAX_FANOUT = 50 *) output reg[31:0]          						id_inst_o  		

);

	always @ (posedge clk) begin
		if (rst) begin
			id_pc_o <= `ZeroWord;
			id_inst_o <= `ZeroWord;
		end else  if(stall[1]==`NoStop) begin
			id_pc_o <= if_pc_i;
			id_inst_o <= if_inst_i;
		end
	end

endmodule