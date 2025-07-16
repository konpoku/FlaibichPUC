module uart_ctrl (
    input wire          clk,
    input wire          rst,
    
    input wire [31:0]   mem_data_i,
    input wire [31:0]   mem_addr_i,
    input wire          mem_oe_n,
    input wire          mem_we_n,
    
    output reg [31:0]   serial_o,
    output wire         txd,
    input  wire         rxd
);

    parameter clk_freq = 109*1000000;
    parameter baud = 9600;
    //parameter baud = 5*1000000; //debug
    
    wire [7:0] TxD_data;
    wire TxD_start;

    wire TxD_FIFO_empty;
    wire TxD_FIFO_full;
    //wire TxD_FIFO_busy;
    reg TxD_FIFO_wr_en;
    wire TxD_FIFO_rd_en;
    wire TxD_FIFO_valid;
    //reg [7:0] TxD_data_reg;
    reg [7:0] TxD_FIFO_data;
    reg RxD_FIFO_rd_en;
    wire RxD_FIFO_wr_en;
    wire [7:0] RxD_FIFO_data;
    wire RxD_FIFO_full;
    wire RxD_FIFO_valid;
    wire RxD_FIFO_empty;

    wire [7:0] RxD_data;
    wire RxD_data_ready;
    wire TxD_busy;
    wire RxD_clear;
    wire is_SerialState = (mem_addr_i == 32'hBFD003FC);
    wire is_SerialData  = (mem_addr_i == 32'hBFD003F8);

    assign RxD_clear = (rst == 1'b1) ? 1'b0 : RxD_data_ready;
    //assign TxD_FIFO_rd_en = ~TxD_busy && ~TxD_FIFO_empty;
    assign TxD_FIFO_rd_en = TxD_start;
    assign RxD_FIFO_wr_en = RxD_data_ready;

    async_receiver #(.ClkFrequency(clk_freq),.Baud(baud))   
        ext_uart_r(
            .clk(clk),                           
            .RxD(rxd),                           
            .RxD_data_ready(RxD_data_ready),     
            .RxD_clear(RxD_clear),               
            .RxD_data(RxD_data)                  
        );

    async_transmitter #(.ClkFrequency(clk_freq),.Baud(baud)) 
        ext_uart_t(
            .clk(clk),                           
            .TxD(txd),                            
            .TxD_busy(TxD_busy),              
            .TxD_start(TxD_start),            
            .TxD_data(TxD_data)               
        );

    fifo_generator_0 TxD_FIFO (
      .clk(clk),      // input wire clk
      .srst(rst),    // input wire srst
      .din(TxD_FIFO_data),      // input wire [7 : 0] din
      .wr_en(TxD_FIFO_wr_en),  // input wire wr_en
      .rd_en(TxD_FIFO_rd_en),  // input wire rd_en
      .dout(TxD_data),    // output wire [7 : 0] dout
      .full(TxD_FIFO_full),    // output wire full
      .valid(TxD_FIFO_valid),
      .empty(TxD_FIFO_empty)  // output wire empty
    );

    fifo_generator_0 RxD_FIFO (
      .clk(clk),      // input wire clk
      .srst(rst),    // input wire srst
      .din(RxD_data),      // input wire [7 : 0] din
      .wr_en(RxD_data_ready),  // input wire wr_en
      .rd_en(RxD_FIFO_rd_en),  // input wire rd_en, not used in this design
      .dout(RxD_FIFO_data),    // output wire [7 : 0] dout, not used in this design
      .full(RxD_FIFO_full),    // output wire full, not used in this design
      .valid(RxD_FIFO_valid),   // output wire valid, not used in this design
      .empty(RxD_FIFO_empty)   // output wire empty, not used in this design
    );

    //assign TxD_start = TxD_FIFO_valid && ~TxD_busy; 
    assign TxD_start = ~TxD_FIFO_empty && ~TxD_busy; // Start transmission when FIFO is not empty and transmitter is not busy
    always @(*) begin
        TxD_FIFO_wr_en = 1'b0;
        TxD_FIFO_data = 8'h00;
        RxD_FIFO_rd_en = 1'b0;
        serial_o = 32'h0; // Default value
        if(is_SerialState) begin
            TxD_FIFO_wr_en = 1'b0;
            TxD_FIFO_data = 8'h00; // Default value
            serial_o = {30'd0, {RxD_FIFO_valid, ~TxD_FIFO_full}}; // Serial status
        end
        else if (is_SerialData) begin
            if ((mem_we_n == 1'b1) && (~mem_oe_n == 1'b1)) begin
                //TODO for RxD
                TxD_FIFO_wr_en = 1'b0;
                TxD_FIFO_data = 8'h00; 
                RxD_FIFO_rd_en = 1'b1;
                serial_o = {24'd0, RxD_FIFO_data}; 
            end
            else begin
                TxD_FIFO_wr_en = 1'b1;
                //TxD_FIFO_rd_en = 1'b0;
                TxD_FIFO_data = mem_data_i[7:0]; // Write data to FIFO
                serial_o = 32'h0; // Default value
            end
        end else begin
        end
    end

endmodule
