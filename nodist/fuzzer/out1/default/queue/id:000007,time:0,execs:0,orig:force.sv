module tb_force_release;
    reg clk;
    reg [7:0] data_val;
    wire [7:0] net;
    reg [7:0] var_forceable;
    wire [7:0] net_forceable;
    dut uut (
        .clk(clk),
        .data_val(data_val),
        .net(net),
        .var_forceable(var_forceable),
        .net_forceable(net_forceable)
    );
    initial begin
        clk = 0;
        data_val = 8'h00;
        var_forceable = 8'h00;
        #10 force var_forceable = 8'hFF;
        #10 release var_forceable;
        #10 force net_forceable = 8'hFF;
        #10 release net_forceable;
        #10 force var_forceable[0] = 1'b1;
        #10 release var_forceable[0];
        #10 force net_forceable[0] = 1'b1;
        #10 release net_forceable[0];
        #10 force var_forceable[3:0] = 4'b1111;
        #10 release var_forceable[3:0];
        #10 force net_forceable[3:0] = 4'b1111;
        #10 release net_forceable[3:0];
        #10 $finish;
    end
    always #5 clk = ~clk;
endmodule
module dut (
    input clk,
    input [7:0] data_val,
    output [7:0] net,
    input [7:0] var_forceable,
    output [7:0] net_forceable
);
    assign net = data_val;
    assign net_forceable = var_forceable;
endmodule
