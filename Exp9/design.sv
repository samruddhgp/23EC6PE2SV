module fsm101 (
    input  logic clk, rst, in,
    output logic out
);
    typedef enum logic [1:0] {S0, S1, S2} state_t;
    state_t state, next;

    always_ff @(posedge clk)
        state <= rst ? S0 : next;

    always_comb begin
        out = 0;
        case (state)
            S0: next = in ? S1 : S0;
            S1: next = in ? S1 : S2;
            S2: begin
                out  = in;
                next = in ? S1 : S0;
            end
        endcase
    end
endmodule
