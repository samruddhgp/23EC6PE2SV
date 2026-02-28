`timescale 1ns/1ps

module clock_tb;

    logic clk;

    initial clk = 0;
    always #5 clk = ~clk;  

    clock_interface intf (clk);


    digital_clock dut (
        .clk     (intf.clk),
        .reset   (intf.reset),
        .seconds (intf.seconds),
        .minutes (intf.minutes)
    );

    clock_test test (intf);

endmodule
