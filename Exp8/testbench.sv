interface fifo_if(input logic clk);
    logic wr, rd;
    logic [7:0] din;
    logic full, empty;
endinterface

module tb;
    logic clk = 0;
    always #5 clk = ~clk;

    fifo_if vif(clk);

    fifo dut (
        .clk(clk),
        .wr(vif.wr),
        .rd(vif.rd),
        .din(vif.din),
        .full(vif.full),
        .empty(vif.empty)
    );

    // Coverage (as per manual)
    covergroup cg_fifo @(posedge clk);
        cross vif.wr, vif.full;
    endgroup
    cg_fifo cg = new();

    initial begin
        // 🔹 WAVEFORM
        $dumpfile("fifo.vcd");
        $dumpvars(0, tb);

        // INIT
        vif.wr  = 0;
        vif.rd  = 0;
        vif.din = 0;

        // 🔹 WRITE PHASE (fill FIFO)
        repeat (18) begin
            @(posedge clk);
            vif.wr  = 1;
            vif.rd  = 0;
            vif.din = $urandom();
        end

        // 🔹 READ PHASE (drain FIFO)
        repeat (18) begin
            @(posedge clk);
            vif.wr = 0;
            vif.rd = 1;
        end

        // 🔹 IDLE
        @(posedge clk);
        vif.wr = 0;
        vif.rd = 0;

        $display("Coverage = %0.2f %%", cg.get_inst_coverage());
        #10 $finish;
    end
endmodule
