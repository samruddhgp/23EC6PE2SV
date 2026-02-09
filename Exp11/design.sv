module arbiter (
    input  logic clk, rst,
    input  logic [3:0] req,
    output logic [3:0] gnt
);
    always_ff @(posedge clk)
        if (rst) gnt <= 0;
        else if (req[0]) gnt <= 4'b0001;
        else if (req[1]) gnt <= 4'b0010;
        else if (req[2]) gnt <= 4'b0100;
        else if (req[3]) gnt <= 4'b1000;
endmodule
