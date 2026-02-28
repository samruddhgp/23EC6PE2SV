`timescale 1ns/1ps

program clock_test (clock_interface.TB intf);

    // =========================================================
    // Functional Coverage
    // =========================================================

    covergroup clock_cg @(posedge intf.clk);

        seconds_cp : coverpoint intf.seconds {
            bins sec_vals[]   = {[0:59]};
            bins sec_rollover = (59 => 0);
        }


        minutes_cp : coverpoint intf.minutes {
            bins min_vals[]   = {[0:59]};
            bins min_rollover = (59 => 0);
        }


        cross seconds_cp, minutes_cp {

            ignore_bins ignore_sec_roll =
                binsof(seconds_cp.sec_rollover);

            ignore_bins ignore_min_roll =
                binsof(minutes_cp.min_rollover);
        }

    endgroup

    clock_cg cg;

    initial begin
        cg = new();

        intf.reset = 1;
        repeat (3) @(posedge intf.clk);
        intf.reset = 0;
        repeat (5000) @(posedge intf.clk);
      
        @(posedge intf.clk);
        intf.reset = 0;

        repeat (5000) @(posedge intf.clk);

        repeat (10) @(posedge intf.clk);

        $display("Simulation Completed Successfully");
        $finish;
    end

endprogram
