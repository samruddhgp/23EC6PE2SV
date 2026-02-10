class Transaction;
    rand logic [7:0] a, b;
    rand opcode_e op;

    constraint c_mul { op dist {MUL:=20, ADD:=30, SUB:=30, XOR:=20}; }
endclass

module tb;
    logic [7:0] a, b;
    opcode_e op;
    logic [15:0] y;

    alu dut (.*);

    covergroup cg;
        coverpoint op;
    endgroup
    cg c = new();

    Transaction tr;

    initial begin
        tr = new();
        repeat (50) begin
            tr.randomize();
            a = tr.a; b = tr.b; op = tr.op;
            #5;
            c.sample();
        end
        $display("Coverage = %0.2f %%", c.get_inst_coverage());
        $finish;
    end
endmodule
