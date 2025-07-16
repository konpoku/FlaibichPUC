module mem_ctrl(
    // Clock and Reset Signals
    input  wire        clk,
    input  wire        rst,
    output reg         stall_from_mem, // Pipeline stall signal

    // Interface to SRAM/Memory
    input  wire[31:0]  ram_data_i,     // Data read from SRAM

    // Interface to CPU MEM Stage
    input  wire[31:0]  mem_addr_i,     // Read/Write address
    input  wire[31:0]  mem_data_i,     // Data to be written
    input  wire        mem_we_n_i,     // Write Enable, active low
    input  wire        mem_oe_n_i,     // Read Enable, active low
    input  wire[3:0]   mem_be_n_i,     // Byte select signals
    input  wire        mem_ce_n_i,     // Chip Enable signal
    output reg [31:0]  ram_data_o      // Read data output to CPU
);

    // State machine definition
    parameter IDLE = 1'b0; // Idle state
    parameter BUSY = 1'b1; // Busy state (second cycle of SRAM access)
    
    reg state, next_state;

    wire mem_request = ~mem_ce_n_i && (~mem_oe_n_i || ~mem_we_n_i);
    
    wire is_uart_access = (mem_addr_i == 32'hbfd003f8) || (mem_addr_i == 32'hbfd003fc);


    always @(posedge clk) begin
        if (rst) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        // Default assignments for all outputs
        next_state     = IDLE;
        stall_from_mem = 1'b0;
        ram_data_o     = 32'b0;

        case(state)
            IDLE: begin
                if (mem_request) begin
                    if (is_uart_access) begin
                        next_state     = IDLE;
                        stall_from_mem = 1'b0;
                        ram_data_o     = ram_data_i;
                    end else begin
                        next_state     = BUSY;
                        stall_from_mem = 1'b1;
                    end
                end
            end

            BUSY: begin
                stall_from_mem = 1'b0;       // Continue stalling for this cycle.
                ram_data_o     = ram_data_i; // Provide valid data to the CPU.
                next_state     = IDLE;       // The transaction will finish, so return to IDLE on the next clock edge.
            end

            default: begin
                next_state     = IDLE;
                stall_from_mem = 1'b0;
                ram_data_o     = 32'b0;
            end
        endcase
    end

endmodule