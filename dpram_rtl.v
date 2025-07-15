module dual_port_RAM_CDC (
 input wire clk1, clk2,
 input wire [7:0] data_1,
 input wire [9:0] addr_1, addr_2,
 input wire wr_en,
 output reg [7:0] o2
);
 reg [7:0] ram[1023:0];


 reg req1, ack1;
 reg req_sync1, req_sync2, ack_sync1, ack_src;


 initial begin
   req1 = 0; ack1 = 0;
   req_sync1 = 0; req_sync2 = 0;
   ack_sync1 = 0; ack_src = 0;
   o2 = 0;
 end


 // Writing on clk1
 always @(posedge clk1) begin
   if (wr_en) begin
     req1 <= 1;
     ram[addr_1] <= data_1;
   end else begin
     req1 <= 0;
   end
 end


 // Synchronization logic for request
 always @(posedge clk2) begin
   req_sync1 <= req1;
   req_sync2 <= req_sync1;
   if (req_sync2 && !ack1) begin
     o2 <= ram[addr_2];  // Read operation
     ack1 <= 1;
   end else if (!req_sync2) begin
     ack1 <= 0;
   end
 end


 always @(posedge clk1) begin
   ack_sync1 <= ack1;
   ack_src <= ack_sync1;
 end


endmodule
