`timescale 1ns/1ns
module counter_test;

    localparam WIDTH=5;

    reg     clk  ;
    reg     rst  ;
    reg     load ;
    reg     enab ;
    reg     [WIDTH-1:0] cnt_in;
    wire    [WIDTH-1:0] cnt_out;

    counter
    #(
        .WIDTH (WIDTH)
     )
    counter_inst(
        .clk        ( clk       ),
        .rst        ( rst       ),
        .load       ( load      ),
        .enab       ( enab      ),
        .cnt_in     ( cnt_in    ),
        .cnt_out    ( cnt_out   )
    );

    task expec;
        input [WIDTH-1:0] exp_out;
        if(cnt_out !== exp_out) begin
            $display("TEST FAILED");
            $display("At time %0d rst=%b load=%b enab=%d cnt_in=%h cnt_out=%h",
                    $time, rst, load, enab, cnt_in, cnt_out);
                    $finish;
        end
        else begin
            $display("At time %0d rst=%b load=%b enab=%d cnt_in=%h cnt_out=%h",
                    $time, rst, load, enab, cnt_in, cnt_out);
        end
    endtask

    initial repeat (7) begin #5 clk=1; #5 clk=0; end

    initial @(negedge clk) begin
        rst = 0; load = 1; enab =1; cnt_in=5'h15; @(negedge clk) expec (5'h15);
        rst = 0; load = 1; enab =1; cnt_in=5'h0A; @(negedge clk) expec (5'h0A);
        rst = 0; load = 1; enab =1; cnt_in=5'h1F; @(negedge clk) expec (5'h1F);
        rst = 1; load = 1; enab =1; cnt_in=5'h1F; @(negedge clk) expec (5'h00);
        rst = 0; load = 1; enab =1; cnt_in=5'h1F; @(negedge clk) expec (5'h1F);
        rst = 0; load = 0; enab =1; cnt_in=5'h1F; @(negedge clk) expec (5'h00);


        $display("TEST PASSED");
        $finish;
    end    

endmodule