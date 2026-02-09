module tb;
    logic clk = 0, rst;
    logic [3:0] count;

    counter dut (.*);

    always #5 clk = ~clk;

    covergroup cg_cnt @(posedge clk);
        cp : coverpoint count {
            bins zero = {0};
            bins max  = {15};
            bins roll = (15 => 0);
        }
    endgroup
    cg_cnt cg = new();

    initial begin
        $dumpfile("counter.vcd");
        $dumpvars(0, tb);

        rst = 1; #12; rst = 0;
        repeat (40) @(posedge clk);

        $display("Coverage = %0.2f %%", cg.get_inst_coverage());
        $finish;
    end
endmodule
