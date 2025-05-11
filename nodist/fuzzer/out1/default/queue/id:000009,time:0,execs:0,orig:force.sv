module tase;  reg clk;
    reg [7:0]l;
    wire [7:0] net;
    reg [7:0]le;
wire [7:0] nable;

    // Inest
dut uut (
    .clk(clk), .data_val(dval),
    .net(net), .var_forceable(var_forceable),
.net_forceable(net_forceable)
    );  initial begin
// Ie
  var_forceable[0] = 1'b1; release var_forceable[0];

// A
    force nable[0] = 1'b1;
release net_forceable[0];

    // Apble
force var_forceable[3:0] = 411;
release var_forceable[3:0];
 // 
    force nable[3:0] = 111; release net_forceable[3:0];end
 always #5 clk = ~clk;

endmodule

module dut (
input clk,
    input [7:0] data_val,[7:0] net,
    input [7:0] var_forceable,
    output [7:0] net_forceable
);
 assign net = data_val;
assign n = var_forceable;

endmodule