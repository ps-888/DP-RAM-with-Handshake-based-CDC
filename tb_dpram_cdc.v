module tb_dual_port_RAM_CDC;


 reg clk1, clk2, wr_en;
 reg [7:0] data_1;
 reg [9:0] addr_1, addr_2;
 wire [7:0] o2;


 dual_port_RAM_CDC uut (
   .clk1(clk1), .clk2(clk2),
   .data_1(data_1),
   .addr_1(addr_1), .addr_2(addr_2),
   .wr_en(wr_en),
   .o2(o2)
 );


 always #5 clk1 = ~clk1;
 always #8 clk2 = ~clk2;

 initial begin
   $dumpfile("cdc.vcd");
   $dumpvars(0, tb_dual_port_RAM_CDC);

   clk1 = 0; clk2 = 0;
   wr_en = 0;
   data_1 = 0;
   addr_1 = 0; addr_2 = 0;


   #10;
  
   wr_en = 1;
   #2;
   addr_1 = 10'd5;
   addr_2 = 10'd5;
   data_1 = 8'hA5;
   #10;
   wr_en = 0;


   #40;
   
  
   wr_en = 1;
   addr_1 = 10'd10;
   data_1 = 8'h3C;
   addr_2 = 10'd10;
   #25;
   wr_en = 0;


   #30;
   addr_2 = 10'd10;
   #20;


   $finish;
 end
endmodule
