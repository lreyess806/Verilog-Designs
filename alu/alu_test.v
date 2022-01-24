module alu_test;

  localparam WIDTH = 8;

  localparam  PASSB = 3'b101, ADD = 3'b010, AND = 3'b011, XOR = 3'b100;

  reg         [2:0] opcode;
  reg   [WIDTH-1:0] in_a;  
  reg   [WIDTH-1:0] in_b;
  wire  [WIDTH-1:0] alu_out;
  wire              a_is_zero;

  alu
  #(
    .WIDTH(WIDTH)
   )
  alu_inst
  (
    .opcode     ( opcode    ),
    .in_a       ( in_a      ),
    .in_b       ( in_b      ),
    .a_is_zero  ( a_is_zero ),
    .alu_out    ( alu_out   )
  );

  task expected;
    input               exp_zero;
    input [WIDTH-1:0]   exp_out;
    if (a_is_zero !== exp_zero || alu_out !== exp_out) begin
      $display("TEST FAILED");
      $display("At time %0d opcode=%b in_a=%b in_b=%b a_is_zero=%b alu_out=%b",
               $time, opcode, in_a, in_b, a_is_zero, alu_out);
      if (a_is_zero !== exp_zero) begin
          $display("a_is_zero should be %b", exp_zero); end
      if (alu_out !== exp_out)
          $display("alu_out should be %b", exp_out);
      $finish;        
    end 
    else begin
      $display("At time %0d opcode=%b in_a=%b in_b=%b a_is_zero=%b alu_out=%b",
               $time, opcode, in_a, in_b, a_is_zero, alu_out);
    end
  endtask

  initial begin
        opcode=0;     in_a=8'h42; in_b=8'h86; #1 expected (1'b0, 8'h42);
        opcode=1;     in_a=8'h42; in_b=8'h86; #1 expected (1'b0, 8'h42);
        opcode=ADD;   in_a=8'h42; in_b=8'h86; #1 expected (1'b0, 8'hC8);
        opcode=AND;   in_a=8'h42; in_b=8'h86; #1 expected (1'b0, 8'h02);
        opcode=XOR;   in_a=8'h42; in_b=8'h86; #1 expected (1'b0, 8'hC4);
        opcode=PASSB; in_a=8'h42; in_b=8'h86; #1 expected (1'b0, 8'h86);
        opcode=6;     in_a=8'h42; in_b=8'h86; #1 expected (1'b0, 8'h42);
        opcode=7;     in_a=8'h42; in_b=8'h86; #1 expected (1'b0, 8'h42);
        opcode=7;     in_a=8'h00; in_b=8'h86; #1 expected (1'b1, 8'h00);
        $display("TEST PASSED");
        $finish;
  end
endmodule
