module tb;
    logic clk = 0, si, so;

    siso dut (.*);

    always #5 clk = ~clk;

    covergroup cg_shift @(posedge clk);
        coverpoint si;
        coverpoint so;
    endgroup
    cg_shift cg = new();

    initial begin
        $dumpfile("shift.vcd");
        $dumpvars(0, tb);

        repeat (20) begin
            si = $urandom();
            @(posedge clk);
        end

        $display("Coverage = %0.2f %%", cg.get_inst_coverage());
        $finish;
    end
endmodule
