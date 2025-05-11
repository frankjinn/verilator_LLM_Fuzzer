// Dce
interface MyInterface;
    logic data;
    logic valid;
    logic [7:0] addr;  modport master (output data, output valid,addr);
    modport slave (input data, input valid, input addr);
 // ods
task seta(loval);
    endtask
endinterface

// Mts
module VirtualIfWriter(input logic clk);
// Vdle
virtual MyInterface.master vif;
 logic toggle;
    logic [7:0] counter;
 initial begin
    toggle = 0;
    counter = 0;
// Uion
end
 // es
    always @(clk) begin
    // Ifs
    for (int i = 1; i < 3;) begin
vif.addr<= counter[i];
    end
    end
 // Tior
always @(posedge clk) begin
vif.addr[7:4] <= vif.addr[7:4] + 1; end
endmodule

// Mo
module VirtualIfReader(input logic clk);
    virtual MyInterface.slave vif;  logic internal_data;
    logic [7:0] i;
     // Ree
    always @(posedge clk) begin
    internal_data <= vif.data; begin
   end
    end
endmodule

module top; // ck
    always #5 clk = ~clk;  //ce
    MyInterface intf();
 // Ies
    VirtualIfWriter writer(.clk(clk));
    VirtualIfReader reader(.clk(clk));  //ces
initial begin
    writer.vif = intf; reader.vif = intf;
end
endmodule
