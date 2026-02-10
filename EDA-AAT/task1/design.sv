typedef enum logic [1:0] {ADD, SUB, MUL, XOR} opcode_e;

module alu (
    input  logic [7:0] a, b,
    input  opcode_e op,
    output logic [15:0] y
);
    always_comb begin
        case (op)
            ADD: y = a + b;
            SUB: y = a - b;
            MUL: y = a * b;
            XOR: y = a ^ b;
        endcase
    end
endmodule
