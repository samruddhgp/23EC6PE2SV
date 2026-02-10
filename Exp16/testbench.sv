module tb;
    logic clk = 0;
    logic req = 0;
    logic gnt = 0;

    always #5 clk = ~clk;

    // Temporal assertion
    property handshake;
        @(posedge clk) req |=> ##2 gnt;
    endproperty

    assert property (handshake)
        else $error("Protocol FAIL!");

    initial begin
        // Apply stimulus
        @(posedge clk) req <= 1;   // cycle 0
        @(posedge clk) req <= 0;   // cycle 1
        @(posedge clk);            // cycle 2
        gnt <= 1;                  // gnt asserted exactly 2 cycles later

        #20 $finish;
    end
endmodule
