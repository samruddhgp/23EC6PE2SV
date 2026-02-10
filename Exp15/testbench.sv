class Packet;
    rand bit [7:0] val;
endclass


module tb;
    mailbox #(Packet) mbx;

    // Generator task
    task generator();
        Packet p;
        repeat (5) begin
            p = new();
            if (!p.randomize())
                $error("Randomization failed");
            mbx.put(p);
            $display("GEN  -> Sent %0d", p.val);
        end
    endtask

    // Driver task
    task driver();
        Packet p;
        repeat (5) begin
            mbx.get(p);
            $display("DRV  <- Received %0d", p.val);
        end
    endtask

    initial begin
        mbx = new();

        fork
            generator();
            driver();
        join

        $finish;
    end
endmodule

