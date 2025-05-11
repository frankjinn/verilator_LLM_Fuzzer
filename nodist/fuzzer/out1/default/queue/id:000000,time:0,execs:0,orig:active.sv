module ae (
input wire clk,
input wire rst_n,
    input  [7:0] data_in,
input wire enable,
  wire select,
    output reg [7:0] data_out,[7:0] latch_out,outp
);
 // )
    wire [7:0]e = data_in & {8};
 // Id
    always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin data_out <=0;
    end else if (enable) begin
    data_out <= data_in;
   //b0;
end
end
 // on
    always @(enable or data_in) begin if (enable) begin
    latch_out = data_in;
end else begin
    // Adtch
latch_out = latch_out; // Orh00
end
// Ntch
end
 // or
    always_latch begin
    if (select) begin
latch_out = ^ 8'hFF; end end

endmodule