module counter
#(
  parameter integer WIDTH = 5
 )
 (
   input wire clk,
   input wire load,
   input wire enab,
   input wire rst,
   input wire [WIDTH-1:0] cnt_in,
   output reg [WIDTH-1:0] cnt_out    
 );

 reg [WIDTH-1:0] cnt_temp;

 always @*
   if ( rst  ) cnt_temp = 'b0; else
   if ( load ) cnt_temp = cnt_in; else
   if ( enab ) cnt_temp = cnt_out + 1; else
               cnt_temp = cnt_temp;  

 always @(posedge clk)
   cnt_out <= cnt_temp;

endmodule