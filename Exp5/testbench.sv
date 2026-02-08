class packet;
    rand bit d, rst;
    constraint c1 { rst dist {0:=90, 1:=10}; }
endclass

module tb;
    logic clk = 0;
    logic rst, d, q;

    dff dut (.*);

    packet pkt; 

    always #5 clk = ~clk;

    initial begin
        // Waveform
        $dumpfile("dff.vcd");
        $dumpvars(0, tb);

        pkt = new(); 

        repeat (50) begin
            pkt.randomize();
            rst = pkt.rst;
            d   = pkt.d;
            @(posedge clk);
        end

        #10 $finish;
    end
endmodule
