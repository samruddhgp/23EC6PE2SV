module tb;
    logic clk = 0, rst;
    light_t color;

    traffic dut (.*);

    always #5 clk = ~clk;

    covergroup cg @(posedge clk);
        cp : coverpoint color {
            bins cycle = (RED => GREEN => YELLOW => RED);
        }
    endgroup
    cg c = new();

    initial begin
        $dumpfile("traffic.vcd");
        $dumpvars(0, tb);

        rst = 1; #10; rst = 0;
        repeat (10) @(posedge clk);

        $display("Coverage = %0.2f %%", c.get_inst_coverage());
        $finish;
    end
endmodule
