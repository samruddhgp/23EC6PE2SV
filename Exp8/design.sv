module fifo (
    input  logic clk, wr, rd,
    input  logic [7:0] din,
    output logic full, empty
);
    logic [4:0] cnt = 0;

    assign full  = (cnt == 16);
    assign empty = (cnt == 0);

    always_ff @(posedge clk) begin
        if (wr && !full)  cnt++;
        if (rd && !empty) cnt--;
    end
endmodule
