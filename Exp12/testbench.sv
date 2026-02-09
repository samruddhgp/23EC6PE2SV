module tb;
    logic clk = 0, rst;
    logic [4:0] coin;
    logic dispense;

    vending dut (.*);

    always #5 clk = ~clk;

    initial begin
        $dumpfile("vending.vcd");
        $dumpvars(0, tb);

        rst = 1; #10; rst = 0;
        coin = 5;  @(posedge clk);
        coin = 10; @(posedge clk);

        $finish;
    end
endmodule
