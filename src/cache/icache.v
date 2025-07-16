module icache(
    // Clock and Reset
    input wire          clk,
    input wire          rst,

    // CPU Interface
    input wire [31:0]   pc_i,               // Instruction address from CPU
    input wire          rom_ce_n_i,         // Chip enable from CPU (active low)
    output reg [31:0]   inst_o,             // Instruction to CPU
    output reg          stall_from_icache,  // Stall signal to CPU

    // SRAM/Bus Interface
    input wire          stall_from_bus,     // Stall signal from bus
    input wire [31:0]   inst_i              // Instruction from SRAM
);

    //================================================================
    // Parameters
    //================================================================
    parameter CACHE_LINES     = 32;
    parameter INDEX_WIDTH     = $clog2(CACHE_LINES);
    // Original design implies a 20-bit address space for tag+index
    parameter TAG_WIDTH       = 20 - INDEX_WIDTH;

    // State machine encoding
    localparam S_IDLE = 1'b0;
    localparam S_BUSY = 1'b1;

    // Address decoding bit positions for clarity
    // PC[1:0]   : Byte Offset (ignored)
    // PC[6:2]   : Index (5 bits)
    // PC[21:7]  : Tag (15 bits)
    localparam INDEX_LSB = 2;
    localparam INDEX_MSB = INDEX_LSB + INDEX_WIDTH - 1;
    localparam TAG_LSB   = INDEX_MSB + 1;
    localparam TAG_MSB   = TAG_LSB + TAG_WIDTH - 1;

    //================================================================
    // Cache Memory
    //================================================================
    reg [31:0]              cache_data[0:CACHE_LINES-1];
    reg [TAG_WIDTH-1:0]     cache_tag[0:CACHE_LINES-1];
    reg [CACHE_LINES-1:0]   cache_valid;

    //================================================================
    // Internal Signals
    //================================================================
    reg         state, next_state;
    integer     i; // for initialization loop

    // Address decoding from input PC
    wire [INDEX_WIDTH-1:0] req_index = pc_i[INDEX_MSB:INDEX_LSB];
    wire [TAG_WIDTH-1:0]   req_tag   = pc_i[TAG_MSB:TAG_LSB];
    
    // Hit logic
    wire is_hit = cache_valid[req_index] && (cache_tag[req_index] == req_tag);
    wire cpu_req = ~rom_ce_n_i; // CPU is requesting an instruction
    
    //================================================================
    // Combinational Logic (State Machine Outputs & Next State)
    //================================================================
    always @(*) begin
        // Default assignments to prevent latches
        next_state        = S_IDLE;
        stall_from_icache = 1'b0;
        inst_o            = `ZeroWord;

        case (state)
            S_IDLE: begin
                if (cpu_req) begin
                    if (is_hit) begin
                        // HIT: Output data from cache, stay IDLE
                        inst_o     = cache_data[req_index];
                        next_state = S_IDLE;
                    end else if (~stall_from_bus) begin
                        // MISS: Stall the CPU and go to BUSY state to fetch from SRAM
                        stall_from_icache = 1'b1;
                        next_state        = S_BUSY;
                    end
                    // else: Bus is stalled, so we wait in IDLE
                end
                // else: No CPU request, do nothing
            end

            S_BUSY: begin
                // Pass instruction from SRAM directly to the CPU
                inst_o     = inst_i;
                // Transition back to IDLE in the next cycle
                next_state = S_IDLE;
            end

            default: begin
                // Should not be reached. Assign safe values.
                next_state        = S_IDLE;
                stall_from_icache = 1'b0;
                inst_o            = 32'hxxxxxxxx; // Use 'x' for don't care
            end
        endcase
    end

    //================================================================
    // Sequential Logic (State and Cache Updates)
    //================================================================
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset state and invalidate the entire cache
            state <= S_IDLE;
            cache_valid <= {CACHE_LINES{1'b0}};
            for (i = 0; i < CACHE_LINES; i = i + 1) begin
                cache_data[i] <= `ZeroWord;
                cache_tag[i]  <= {TAG_WIDTH{1'b0}};
            end
        end else begin
            // Update state register
            state <= next_state;

            // When leaving the BUSY state, write the fetched data into the cache.
            // Note: `req_index` and `req_tag` come from `pc_i`, which the CPU must
            // hold stable during the stall for this to work correctly.
            if (state == S_BUSY) begin
                cache_data[req_index]  <= inst_i;
                cache_tag[req_index]   <= req_tag;
                cache_valid[req_index] <= 1'b1;
            end
        end
    end

endmodule