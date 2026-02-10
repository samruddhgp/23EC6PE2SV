module tb;
    int mem[int];
    int addr;

    initial begin
        $dumpfile("assoc.vcd");
        $dumpvars(0, tb);

        repeat (10) begin
            addr = $urandom_range(0,100);
            mem[addr] = $urandom();
        end
        $finish;
    end
endmodule
