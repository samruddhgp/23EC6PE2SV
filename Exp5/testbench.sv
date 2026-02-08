class packet;
    rand bit d, rst;
    constraint c1 { rst dist {0:=90, 1:=10}; }
endclass

module tb;
    logic clk=0, rst, d, q;
    dff dut (.*);

    always #5 clk = ~clk;

    initial begin
        $dumpfile("dff.vcd");
        $dumpvars(0, tb);

        packet pkt = new();
        repeat (50) begin
            pkt.randomize();
            rst = pkt.rst;
            d   = pkt.d;
            @(posedge clk);
        end
        #10 $finish;
    end
endmodule
