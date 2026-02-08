class Transaction;
    rand bit [7:0] a, b;
    rand bit       sel;
endclass


module tb;
    logic [7:0] a, b, y;
    logic       sel;

    // DUT
    mux2to1 dut (.*);

    // Coverage
    covergroup cg_mux;
        cp_sel : coverpoint sel; // sel = 0 and sel = 1
    endgroup
    cg_mux cg = new();

    Transaction tr = new();

    initial begin
        // -------- WAVEFORM DUMP --------
        $dumpfile("mux2to1.vcd");   // waveform file
        $dumpvars(0, tb);           // dump all signals in tb
        // --------------------------------

        repeat (20) begin
            tr.randomize();
            a   = tr.a;
            b   = tr.b;
            sel = tr.sel;

            #5;
            cg.sample();

            // Self-check
            if (y !== (sel ? b : a))
                $error("Mismatch! a=%0h b=%0h sel=%0b y=%0h", a, b, sel, y);
        end

        $display("Coverage = %0.2f %%", cg.get_inst_coverage());
        #10;
        $finish;
    end
endmodule
