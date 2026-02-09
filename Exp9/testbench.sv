module tb;
    logic clk = 0, rst, in, out;

    fsm101 dut (.*);

    always #5 clk = ~clk;

    initial begin
        $dumpfile("fsm101.vcd");
        $dumpvars(0, tb);

        rst = 1; #10; rst = 0;
        repeat (25) begin
            in = $urandom();
            @(posedge clk);
        end
        $finish;
    end
endmodule
