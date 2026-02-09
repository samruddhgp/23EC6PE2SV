module tb;
    logic clk = 0, rst;
    logic [3:0] req, gnt;

    arbiter dut (.*);

    always #5 clk = ~clk;

    assert property (@(posedge clk) $onehot0(gnt));

    initial begin
        $dumpfile("arbiter.vcd");
        $dumpvars(0, tb);

        rst = 1; #10; rst = 0;
        req = 4'b0011; @(posedge clk);
        req = 4'b0100; @(posedge clk);

        $finish;
    end
endmodule
