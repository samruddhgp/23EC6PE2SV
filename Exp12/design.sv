module vending (
    input  logic clk, rst,
    input  logic [4:0] coin,
    output logic dispense
);
    typedef enum logic [1:0] {IDLE, HAS5, HAS10} state_t;
    state_t state;

    always_ff @(posedge clk) begin
        dispense <= 0;
        if (rst) state <= IDLE;
        else case (state)
            IDLE:  if (coin == 5) state <= HAS5;
            HAS5:  if (coin == 10) begin
                       state <= IDLE;
                       dispense <= 1;
                   end
        endcase
    end
endmodule
