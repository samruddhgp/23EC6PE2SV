module clock59 (
    input  logic clk, rst,
    output logic [5:0] sec, min
);
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            sec <= 0; min <= 0;
        end else begin
            if (sec == 59) begin
                sec <= 0;
                min <= (min == 59) ? 0 : min + 1;
            end else sec <= sec + 1;
        end
    end
endmodule
