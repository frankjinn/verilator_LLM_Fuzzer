interface MyInterface;
    logic data;
    logic valid;
    logic [7:0] addr;
    modport master (output data, output valid, output addr);
    modport slave (input data, input valid, input addr);
    task set_data(logic val);
        data = val;
    endtask
endinterface

module VirtualIfWriter(input logic clk);
    virtual MyInterface.master vif;
    logic toggle;
    logic [7:0] counter;

    initial begin
        toggle = 0;
        counter = 0;
        vif.data = 0;
        vif.valid = 0;
        vif.addr = 0;
    end

    always @(posedge clk) begin
        toggle <= ~toggle;
        vif.data <= toggle;
        counter <= counter + 1;
    end

    always @(toggle) begin
        vif.valid <= toggle;
    end

    always @(posedge clk) begin
        if (toggle) begin
            vif.addr[0] <= 1'b1;
        end else begin
            vif.addr[0] <= 1'b0;
        end
    end

    always @(posedge clk) begin
        for (int i = 1; i < 3; i++) begin
            vif.addr[i] <= counter[i];
        end
    end

    always @(posedge clk) begin
        vif.addr[7:4] <= vif.addr[7:4] + 1;
    end
endmodule

module VirtualIfReader(input logic clk);
    virtual MyInterface.slave vif;
    logic internal_data;
    logic [7:0] internal_addr;

    always @(posedge clk) begin
        internal_data <= vif.data;
        if (vif.valid) begin
            internal_addr <= vif.addr;
        end
    end
endmodule

module top;
    logic clk = 0;
    always clk = ~clk;
    MyInterface intf();
    VirtualIfWriter writer(.clk(clk));
    VirtualIfReader reader(.clk(clk));

    initial begin
        writer.vif = intf;
        reader.vif = intf;
        intf.set_data(1'b1);
        $finish;
    end
endmodule
