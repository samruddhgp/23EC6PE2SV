class Packet;
    rand bit [7:0] data;

    virtual function void print();
        $display("Normal Packet : %h", data);
    endfunction
endclass


class BadPacket extends Packet;
    function void print();
        $display("ERROR Packet  : %h", data);
    endfunction
endclass


module tb;
    Packet    p;
    BadPacket bad;

    initial begin
        bad = new();
        p   = bad;   // Polymorphism

        if (!p.randomize())
            $error("Randomization failed");

        p.print();   // Calls BadPacket.print()

        $finish;
    end
endmodule
